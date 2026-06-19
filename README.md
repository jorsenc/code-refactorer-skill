# Code Refactorer Skill v2.0

Skill especializada de Claude para refactorización y mejora de código fuente en cualquier lenguaje de programación. Detecta automáticamente problemas como code smells, complejidad excesiva, duplicación, violaciones SOLID, y propone patrones de diseño aplicables.

## ✨ Características v2.0

- **9+ lenguajes soportados**: Python, JavaScript, TypeScript, Java, C#, Go, Rust, Ruby, PHP, Kotlin
- **50+ code smells**: Patrones problemáticos universales y específicos por lenguaje
- **50+ design patterns**: GoF, SOLID, Arquitectónicos, Cloud-native, Testing, Concurrency
- **7 métricas avanzadas**: Cyclomatic Complexity, Cognitive Complexity, Maintainability Index, Technical Debt, y más
- **12 test cases**: Validación completa de detección de issues
- **5 guías de uso**: Workflows específicos para casos comunes
- **CI/CD integración**: GitHub Actions, pre-commit hooks, SonarQube, salida SARIF

## 🚀 Inicio Rápido

### Instalación en Claude Desktop
```bash
git clone https://github.com/jorsenc/code-refactorer-skill.git
cp -r code-refactorer-skill ~/.claude/skills/
```

Reinicia Claude Desktop y la skill aparecerá en el menú de Skills.

### Instalación en Claude.ai Web
1. Descarga: `code-refactorer-skill-v2.0.zip`
2. Ve a https://claude.ai → Configuración → Skills
3. Sube el ZIP

**→ [Guía completa de instalación](INSTALL_GUIDE.md)**

## 📖 Documentación

- **[QUICK_START.md](QUICK_START.md)** — Comienza en 2 minutos
- **[INSTALL_GUIDE.md](INSTALL_GUIDE.md)** — Instalación paso-a-paso  
- **[CONTRIBUTING.md](CONTRIBUTING.md)** — Contribuir mejoras
- **[CLAUDE.md](CLAUDE.md)** — Guía para Claude Code

### Documentación Técnica

- **[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)** — Arquitectura interna y 6-phase execution model
- **[docs/INTEGRATION.md](docs/INTEGRATION.md)** — CI/CD, GitHub Actions, pre-commit hooks
- **[docs/WORKFLOWS.md](docs/WORKFLOWS.md)** — 5 workflows: legacy code, testing, performance, SOLID, async
- **[docs/DEVELOPMENT.md](docs/DEVELOPMENT.md)** — Guía de desarrollo

## 📊 Capacidades

### Análisis Multi-Dimensional
- **Legibilidad**: Nombres, documentación, estructura
- **Mantenibilidad**: Acoplamiento, complejidad, duplicación  
- **Rendimiento**: Queries N+1, string concatenation, loops ineficientes
- **Seguridad**: SQL injection, input validation, resource management

### Lenguajes
Python • JavaScript • TypeScript • Java • C# • Go • Rust • Ruby • PHP

### Output
- Análisis detallado con métricas
- Código refactorizado con explicación línea-por-línea
- Patrones aplicables sugeridos
- Comparativa antes/después
- Salida JSON, SARIF (GitHub), Markdown, CSV

## 🔧 Uso

### En Claude Desktop o Claude.ai
Simplemente menciona:
```
"Refactoriza esto"
"/code-refactorer"
"Mejora este código"
"Audita este código"
```

O sube un archivo y pídele que lo analice.

## 📈 Evolución

| Métrica | v1.0 | v2.0 | Cambio |
|---------|------|------|--------|
| Lenguajes | 6 | 9+ | +50% |
| Code Smells | 27 | 50+ | +85% |
| Patrones | 15 | 50+ | +233% |
| Test Cases | 6 | 12 | +100% |
| Score | 6.5/10 | 8.5/10 | +2 |

## 🤝 Contribuir

Reporta bugs, sugiere features, o contribuye mejoras en [CONTRIBUTING.md](CONTRIBUTING.md)

## 📋 Referencia

- **Smells**: [references/code-smells.md](references/code-smells.md) — 50+ patrones problemáticos
- **Patrones**: [references/design-patterns.md](references/design-patterns.md) — 15 GoF + SOLID  
- **Avanzados**: [references/patterns-advanced.md](references/patterns-advanced.md) — 35+ patrones
- **Métricas**: [references/metrics.md](references/metrics.md) — Interpretación de calidad

## 📜 Licencia

MIT License — Ver [LICENSE](LICENSE)

---

**v2.0** | Actualizado: 2026-06-19 | [GitHub](https://github.com/jorsenc/code-refactorer-skill)
