# Code Refactorer Skill

[![Validate Skill](https://github.com/TU_USUARIO/code-refactorer-skill/workflows/Validate%20Skill/badge.svg)](https://github.com/TU_USUARIO/code-refactorer-skill/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.10+](https://img.shields.io/badge/python-3.10+-blue.svg)](https://www.python.org/downloads/)

Una skill especializada de Claude para refactorización y mejora automática de código fuente en cualquier lenguaje de programación.

## 📖 Descripción

**Code Refactorer** es una skill avanzada que analiza código y proporciona refactorización inteligente. Detecta automáticamente:

- 55+ code smells (patrones problemáticos)
- Violaciones de principios SOLID
- Complejidad excesiva
- Oportunidades de optimización
- 12 patrones de diseño aplicables

Genera informes completos con código refactorizado, explicaciones de cambios, comparativas de métricas y tests sugeridos.

## 🚀 Características

✨ **Análisis profundo en cualquier lenguaje**
- Python, JavaScript, TypeScript, Java, C#, Go, Rust, PHP, etc.

📊 **Informe estructurado**
- Análisis inicial → Problemas identificados → Propuestas → Código refactorizado → Métricas → Comparativa

🎯 **4 modos de uso**
- Automático: Análisis y refactorización completa
- Dirigido: Enfocado en áreas específicas
- Solo análisis: Sin refactorización
- Incremental: Para archivos grandes

🏆 **Mejores prácticas**
- Basado en principios SOLID
- Patrones de diseño GoF
- Métricas estándar de industria
- Convenciones de cada lenguaje

## 📦 Instalación

### En Claude.ai

1. Descargar esta carpeta
2. Ir a **Settings** → **Profile** → **Skills**
3. Subir la carpeta como skill personalizada
4. ¡Listo para usar!

### En Claude Code

```bash
cp -r code-refactorer-skill ~/.config/claude/skills/
```

## 💡 Uso rápido

```
"Refactoriza esto:"
```python
def process_data(data):
    result = []
    for i in range(len(data)):
        if data[i] > 10:
            result.append(data[i] * 2)
    return result
```
```

La skill proporcionará:
- ✅ Análisis de problemas
- ✅ Código refactorizado
- ✅ Explicación de cambios
- ✅ Métricas mejoradas
- ✅ Tests sugeridos

## 📚 Documentación

- [Guía rápida](./QUICK_START.md) - Empezar en 3 minutos
- [Guía completa](./README.md) - Instalación y uso detallado
- [Arquitectura técnica](./ARCHITECTURE.md) - Cómo funciona
- [CONTRIBUTING.md](./CONTRIBUTING.md) - Cómo contribuir

### Referencias técnicas

- [Code Smells](./references/code-smells.md) - Catálogo de problemas (55+)
- [Design Patterns](./references/design-patterns.md) - Patrones aplicables (12+)
- [Métricas](./references/metrics.md) - Interpretación de métricas

## 🧪 Validación

Verifica que la skill esté correcta:

```bash
python scripts/validate.py
```

Resultado esperado:
```
✅ Validación exitosa
📊 Resumen:
  • SKILL.md: ✅
  • Referencias: ✅ (3 archivos)
  • Test cases: ✅ (6 casos)
  • Estructura: ✅ (directorios correctos)
```

## 📊 Estadísticas

| Métrica | Valor |
|---------|-------|
| Lenguajes soportados | Todos |
| Code smells catalogados | 55+ |
| Patrones de diseño | 12 |
| Métricas de calidad | 7 |
| Casos de prueba | 6 |
| Líneas de documentación | 2,800+ |
| Status | ✅ Producción |

## 🎓 Ejemplos de uso

### Python simple

```
"Analiza este código Python:"
```python
def validate_email(email):
    if email:
        if '@' in email:
            if '.' in email:
                return True
    return False
```
```

**Resultado:**
- Detección de anidamiento innecesario
- Propuesta: Simplificar con expresión única
- Code refactorizado y más legible

### JavaScript con Callback Hell

```
"Refactoriza este JavaScript:"
```javascript
function processUser(userId, callback) {
  fetchUser(userId, function(err, user) {
    if (err) callback(err);
    else {
      fetchProfile(user.id, function(err, profile) {
        // ... más callbacks anidados
      });
    }
  });
}
```
```

**Resultado:**
- Detección: Callback Hell, falta de error handling centralizado
- Propuesta: Usar async/await, Promise
- Código moderno y mantenible

## 🔧 Casos de uso

✅ Limpiar código heredado  
✅ Mejorar legibilidad  
✅ Preparar para testing  
✅ Optimizar rendimiento  
✅ Aplicar SOLID  
✅ Implementar patrones  
✅ Reducir deuda técnica  
✅ Code review automático  
✅ Documentar cambios  

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Ver [CONTRIBUTING.md](./CONTRIBUTING.md) para detalles.

### Contribuciones comunes

- **Nuevos code smells**: Edita `references/code-smells.md`
- **Nuevos patrones**: Edita `references/design-patterns.md`
- **Casos de prueba**: Agrega a `test-cases.json`
- **Mejoras de documentación**: Edita archivos .md

## 📝 Licencia

Licenciado bajo MIT. Ver [LICENSE](./LICENSE) para más detalles.

## 🐛 Reportar issues

¿Encontraste un problema? [Abre un issue](https://github.com/TU_USUARIO/code-refactorer-skill/issues)

Incluye:
- Descripción clara del problema
- Pasos para reproducir
- Lenguaje de programación afectado
- Resultado esperado vs actual

## 💬 Feedback

¿Ideas para mejorar? Abre un [Discussion](https://github.com/TU_USUARIO/code-refactorer-skill/discussions)

## 🗺️ Roadmap

- [ ] Integración con SonarQube
- [ ] Análisis de performance detallado
- [ ] Generación automática de tests unitarios
- [ ] Dashboard de métricas
- [ ] Reportes en PDF/HTML
- [ ] Integración con CI/CD
- [ ] Análisis de seguridad avanzado

## 📊 Status

**Versión**: 1.0  
**Status**: ✅ Producción  
**Última actualización**: Mayo 2026  
**Modelo base**: Claude Sonnet 4+  

## 🎉 Reconocimientos

Creado con ❤️ usando [Claude](https://claude.ai)

---

**¿Listo para refactorizar?** Instala la skill e comienza a mejorar tu código hoy mismo.

```bash
# Valida antes de instalar
python scripts/validate.py
```

¡Que disfrutes! 🚀
