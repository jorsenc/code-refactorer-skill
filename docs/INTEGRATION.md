# Integración de Code Refactorer Skill

Guía práctica para integrar la skill en flujos de desarrollo y CI/CD.

---

## GitHub Actions Integration

Ejecuta la skill automáticamente en cada PR para verificar calidad de código antes de merge.

### Configuración básica

Crea `.github/workflows/refactor-check.yml`:

```yaml
name: Code Refactor Check

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  refactor-analysis:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Analyze code with Code Refactorer
        run: |
          # Ejecutar skill en archivos modificados
          python3 -m claude.skills.code_refactorer \
            --files "$(git diff --name-only origin/main...HEAD)" \
            --output json \
            > refactor-report.json
      
      - name: Comment PR with results
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const report = JSON.parse(fs.readFileSync('refactor-report.json', 'utf8'));
            
            let comment = '## 📊 Code Refactorer Analysis\n\n';
            comment += `**Issues found:** ${report.issues.length}\n`;
            comment += `**Severity:**\n`;
            comment += `- 🔴 Critical: ${report.critical || 0}\n`;
            comment += `- 🟡 Major: ${report.major || 0}\n`;
            comment += `- 🟢 Minor: ${report.minor || 0}\n\n`;
            
            if (report.issues.length > 0) {
              comment += '### Top Issues\n';
              report.issues.slice(0, 5).forEach(issue => {
                comment += `- **${issue.type}** in \`${issue.file}:${issue.line}\`: ${issue.message}\n`;
              });
            }
            
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: comment
            });
```

### Interpretación de resultados

- ✅ **Sin issues**: Código pasa análisis
- ⚠️ **Issues menores**: Revisar pero no bloquea
- 🔴 **Issues críticos**: Revisar antes de merge

---

## Pre-commit Hook

Ejecuta la skill antes de cada commit para detectar problemas localmente.

### Instalación

1. Crea `.githooks/pre-commit`:

```bash
#!/bin/bash

# Obtener archivos staged
STAGED_FILES=$(git diff --cached --name-only)

if [ -z "$STAGED_FILES" ]; then
  exit 0
fi

echo "🔍 Running Code Refactorer analysis..."

# Ejecutar skill
python3 << EOF
from pathlib import Path
import json

files = "$STAGED_FILES".split('\n')
code_files = [f for f in files if f.endswith(('.py', '.js', '.ts', '.java', '.cs', '.go'))]

if code_files:
    # Ejecutar análisis
    from claude.skills.code_refactorer import analyze
    results = analyze(code_files)
    
    # Verificar issues críticos
    critical = [i for i in results.get('issues', []) if i.get('severity') == 'critical']
    
    if critical:
        print("\n❌ Critical issues found. Fix before committing:")
        for issue in critical:
            print(f"  - {issue['file']}:{issue['line']}: {issue['message']}")
        exit(1)
    
    # Advertencia de issues mayores
    major = [i for i in results.get('issues', []) if i.get('severity') == 'major']
    if major:
        print(f"\n⚠️  Found {len(major)} major issues. Review recommended:")
        for issue in major[:3]:
            print(f"  - {issue['file']}:{issue['line']}: {issue['message']}")
        print("\nContinuing anyway (major issues don't block).")

EOF

exit 0
```

2. Habilita el hook:

```bash
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
```

### Uso

Al hacer `git commit`, el hook:
- ✅ Bloquea si hay issues **críticos**
- ⚠️ Advierte si hay issues **mayores** (permite continuar)
- ℹ️ Informa si hay issues **menores**

Para saltarse el hook (NO RECOMENDADO):
```bash
git commit --no-verify
```

---

## SonarQube Integration

Complementariedad entre Code Refactorer Skill y SonarQube.

### Ventajas de cada uno

| Aspecto | Code Refactorer | SonarQube |
|---------|-----------------|-----------|
| **Refactorización** | ✅ Propone mejoras | ❌ Solo detecta issues |
| **Patrones** | ✅ Design patterns, SOLID | ❌ Básico |
| **Setup** | ✅ Instant, sin infra | ❌ Requiere servidor |
| **Análisis estático** | ⚠️ Básico | ✅ Enterprise |
| **Security** | ⚠️ Básico | ✅ Especializado |
| **Métricas** | ✅ Basadas en análisis | ✅ Con histórico |

### Configuración de flujo híbrido

```yaml
# .github/workflows/code-quality.yml
name: Code Quality

on: [pull_request, push]

jobs:
  refactorer:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Code Refactorer
        run: python3 -m claude.skills.code_refactorer --files . --output json > refactorer-report.json
      - name: Upload Refactorer Report
        uses: actions/upload-artifact@v3
        with:
          name: refactorer-report
          path: refactorer-report.json

  sonarqube:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: SonarQube Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

### Workflow recomendado

1. **Pre-commit**: Code Refactorer (local, rápido)
2. **PR**: Code Refactorer (detecta patterns) + SonarQube (análisis profundo)
3. **Main**: SonarQube (quality gate)

---

## Output Formats

La skill puede exportar resultados en múltiples formatos.

### JSON (Parseable)

```json
{
  "file": "src/app.py",
  "issues": [
    {
      "line": 42,
      "column": 1,
      "type": "god_object",
      "severity": "major",
      "message": "Class has 5+ responsibilities",
      "suggestion": "Extract UserRepository, UserValidator",
      "confidence": 0.95
    }
  ],
  "metrics": {
    "complexity": 18,
    "maintainability_index": 62,
    "duplication_percent": 8.5
  }
}
```

**Uso**: Para integración con herramientas, parsing automático

### SARIF (GitHub Code Scanning Standard)

```json
{
  "version": "2.1.0",
  "runs": [
    {
      "tool": {
        "driver": {
          "name": "Code Refactorer",
          "version": "1.0"
        }
      },
      "results": [
        {
          "ruleId": "code-smell/god-object",
          "message": {
            "text": "Class has too many responsibilities"
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "src/app.py"
                },
                "region": {
                  "startLine": 42,
                  "startColumn": 1
                }
              }
            }
          ],
          "level": "warning"
        }
      ]
    }
  ]
}
```

**Uso**: GitHub Actions analiza automáticamente y muestra en "Security" tab

### Markdown (Legible)

```markdown
# Code Refactorer Report

## Summary
- **Files analyzed**: 12
- **Issues found**: 23
- **Severity**: 3 critical, 8 major, 12 minor

## Issues by File

### src/app.py (5 issues)
- **Line 42** 🔴 **God Object**: Class has 5+ responsibilities
  - Suggestion: Extract UserRepository, UserValidator
- **Line 127** 🟡 **Callback Hell**: Nested callbacks 4 levels deep
  - Suggestion: Use async/await instead

## Metrics
| Metric | Value | Target |
|--------|-------|--------|
| Cyclomatic Complexity | 18 | <10 |
| Maintainability Index | 62 | >70 |
| Duplication | 8.5% | <5% |
```

**Uso**: Para reporte legible, compartir con equipo

### CSV (Análisis)

```csv
file,line,type,severity,message
src/app.py,42,god_object,major,Class has 5+ responsibilities
src/app.py,127,callback_hell,major,Nested callbacks 4 levels deep
src/handlers.py,89,long_method,minor,Function exceeds 50 lines
```

**Uso**: Importar a Excel, análisis de tendencias

---

## Integración con IDEs

### VS Code

Instala la extensión "Code Refactorer" y configura en `.vscode/settings.json`:

```json
{
  "code-refactorer.enabled": true,
  "code-refactorer.analyzeOnSave": true,
  "code-refactorer.outputFormat": "json",
  "code-refactorer.severityThreshold": "minor"
}
```

**Función**: Análisis en tiempo real mientras escribes código.

### JetBrains (IntelliJ, PyCharm, etc.)

Configura en Preferences → Code Refactorer:
- ✅ Inspecciones en tiempo real
- ✅ Sugerencias de refactorización
- ✅ Navegación a problemas

---

## Slack Integration

Notifica al equipo sobre issues en Slack.

```python
# Hook en GitHub Actions o pre-commit
import json
import requests

def notify_slack(report_file):
    with open(report_file) as f:
        report = json.load(f)
    
    if not report['issues']:
        return
    
    critical = len([i for i in report['issues'] if i['severity'] == 'critical'])
    major = len([i for i in report['issues'] if i['severity'] == 'major'])
    
    message = f"""
    🔍 Code Refactorer Analysis
    {'🔴' if critical > 0 else '🟡' if major > 0 else '🟢'}
    Issues: {critical} critical, {major} major
    Review: <{report.get('url')}|See Report>
    """
    
    requests.post(
        os.environ['SLACK_WEBHOOK'],
        json={'text': message}
    )
```

---

## Mejores prácticas

1. **No bloquear en todo**: Issues menores/mayores son advertencias, no bloques
2. **Automatizar detección**: Pre-commit para feedback local rápido
3. **Complementar con SonarQube**: Para análisis profundo, seguridad, métricas históricas
4. **Revisar contexto**: La skill propone, el equipo valida
5. **Iterar**: Los primeros PRs pueden tener muchos issues, es normal

---

**Última actualización**: 2026-06-19  
**Versión de skill**: 1.0
