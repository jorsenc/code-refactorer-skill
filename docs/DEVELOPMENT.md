# Guía de Desarrollo

Documentación para desarrolladores que quieran entender, mejorar o extender la skill.

## Estructura del Proyecto

```
code-refactorer-skill/
├── SKILL.md                    # Definición de la skill (YAML + workflow)
├── references/                 # Knowledge base (documentación guía)
│   ├── code-smells.md         # 50+ patrones problemáticos
│   ├── design-patterns.md     # 15 patrones GoF + SOLID
│   ├── patterns-advanced.md   # 35+ patrones avanzados
│   └── metrics.md             # 7 métricas de calidad
├── test-cases.json            # 12 casos de validación
├── scripts/
│   └── validate.py            # Validación de estructura
└── docs/
    ├── ARCHITECTURE.md        # Arquitectura interna
    ├── INTEGRATION.md         # CI/CD e integración
    ├── WORKFLOWS.md           # 5 guías de uso
    └── DEVELOPMENT.md         # Este archivo
```

## Filosofía: Documentation-Driven

La skill **NO tiene código detectar**. En su lugar:
- Tres archivos Markdown guían el análisis
- Claude lee y aplica los patrones documentados
- Extensible sin cambios de código: agregar un smell → listo

**Ventajas:**
- ✅ Transparencia total (todas las reglas son legibles)
- ✅ Fácil de mantener (edita Markdown, no código)
- ✅ Extensible (agregar patrones es trivial)

## Flujo de Trabajo del Análisis (6 Fases)

1. **Code Capture** — Obtener código (chat, archivo, URL)
2. **Language Detection** — Detectar lenguaje automáticamente
3. **Deep Analysis** — Examinar en 4 dimensiones (legibilidad, mantenibilidad, performance, seguridad)
4. **Proposal Generation** — Crear propuestas priorizadas
5. **Refactorization** — Generar código mejorado
6. **Report Generation** — Métricas antes/después

## Cómo Agregar un Code Smell

1. Edita `references/code-smells.md`
2. Agrega bajo la sección de lenguaje (o universal):

```markdown
### Nombre del Problema
**Síntoma**: Cómo identificarlo  
**Impacto**: Por qué importa  
**Solución**: Cómo solucionarlo

Ejemplo:
❌ Código malo
✅ Código bueno
```

3. Ejecuta: `python3 scripts/validate.py`
4. Prueba manualmente en Claude

## Cómo Agregar un Design Pattern

1. Edita `references/design-patterns.md` o `patterns-advanced.md`
2. Agrega con estructura:

```markdown
### Nombre del Patrón

**Cuándo**: Situaciones aplicables  
**Beneficios**: Ventajas  
**Ejemplo**:
[Código antes/después]
```

3. Valida y prueba

## Cómo Agregar Test Cases

1. Edita `test-cases.json`
2. Agrega nuevo objeto:

```json
{
  "id": "test_N_language_shortname",
  "title": "Descriptive title",
  "language": "python",
  "input": "código con problemas",
  "expected_issues": ["problema 1", "problema 2"],
  "expected_improvements": ["mejora 1", "mejora 2"]
}
```

3. Valida: `python -m json.tool test-cases.json`
4. Prueba manualmente

## Validación

Ejecuta después de cambios:
```bash
python3 scripts/validate.py
```

Verifica:
- ✅ SKILL.md existe con frontmatter YAML
- ✅ Referencias tienen >50 líneas cada una
- ✅ test-cases.json es JSON válido
- ✅ Directorio estructura es correcta

## Lenguajes Soportados

### Primarios (con ejemplos en código-smells.md)
- Python
- JavaScript/TypeScript
- Java
- C#/.NET
- Go
- Rust
- Ruby
- PHP
- Kotlin

### Cómo agregar nuevo lenguaje
1. Agrega sección en `code-smells.md`
2. Documenta 4-5 smells específicos con ejemplos
3. Agrega test case en `test-cases.json`
4. Actualiza `SKILL.md` sección "Language-Specific Considerations"

## Métricas

Documentadas en `references/metrics.md`:
- Cyclomatic Complexity
- Cognitive Complexity
- Maintainability Index
- Code Duplication
- Test Coverage (estimado)
- Technical Debt Ratio
- SOLID violations

Para agregar métrica:
1. Edita `references/metrics.md`
2. Documenta: definición, escala, herramientas, interpretación
3. Prueba que Claude la usa en análisis

## CI/CD e Integración

Ver [docs/INTEGRATION.md](INTEGRATION.md) para:
- GitHub Actions workflow
- Pre-commit hooks
- SonarQube complementariedad
- Output formats (JSON, SARIF, Markdown, CSV)

## Improving the Skill

Prioridades de mejora:
1. **Agregar más code smells** — Cada patrón nuevo hace la skill más útil
2. **Casos de prueba específicos** — Validar detección en lenguajes nuevos
3. **Patrones de framework** — Django, FastAPI, React, Spring, etc.
4. **Métricas avanzadas** — Security scoring, technical debt automation

Ver [CONTRIBUTING.md](../CONTRIBUTING.md) para contribuir.

## Testing Manual

Pasos para probar cambios:

1. **En Claude Desktop**:
   - Copia skill a `~/.claude/skills/code-refactorer-skill`
   - Reinicia Claude Desktop
   - Prueba con fragmentos de código

2. **En Claude.ai web**:
   - Sube `code-refactorer-skill-v2.0.zip`
   - Prueba en Settings → Skills

3. **Con test cases**:
   - Pega código de `test-cases.json`
   - Verifica que detecta `expected_issues`
   - Verifica que sugiere `expected_improvements`

## Troubleshooting

### Skill no aparece
- Verifica `SKILL.md` exists en raíz
- Recarga Claude Desktop
- Limpia caché: `~/.claude/cache`

### Detección no funciona
- Verifica references files tienen contenido
- Prueba con test case conocido
- Lee línea de análisis en la respuesta de Claude

### Validación falla
```bash
python3 scripts/validate.py
```
Verifica que SKILL.md, references, test-cases.json existen y tienen contenido

---

**¿Preguntas o sugerencias?** Abre un issue en GitHub o contribuye un PR.

Última actualización: 2026-06-19
