# Contribuir a Code Refactorer Skill

¡Gracias por tu interés en contribuir! Este documento proporciona guías y directrices para contribuir.

## 🎯 Cómo contribuir

### Reportar bugs
- Abre un issue con el label `bug`
- Describe el problema claramente
- Incluye pasos para reproducir
- Especifica qué lenguaje/versión afecta

### Sugerir mejoras
- Abre un issue con el label `enhancement`
- Explica el caso de uso
- Proporciona ejemplos si es posible

### Enviar código

1. **Fork el repositorio**
2. **Crea una rama** (`git checkout -b feature/amazing-feature`)
3. **Haz tus cambios**
4. **Commits claros** (`git commit -m 'Add amazing feature'`)
5. **Push a la rama** (`git push origin feature/amazing-feature`)
6. **Abre un Pull Request**

## 📋 Estándares de contribución

### Código
- Sigue el estilo existente
- Comenta código complejo
- Mantén la compatibilidad hacia atrás cuando sea posible
- Incluye tests cuando sea relevante

### Documentación
- Actualiza README.md si cambias funcionalidad
- Documenta nuevos code smells en `references/code-smells.md`
- Documenta nuevos patrones en `references/design-patterns.md`
- Incluye ejemplos antes/después

### Referencias
- **code-smells.md**: Agregar problemas, incluir ejemplos
- **design-patterns.md**: Agregar patrones, mostrar cuándo usar
- **metrics.md**: Actualizar herramientas, umbrales

### Test cases
- Agregar casos en `test-cases.json`
- Incluir `id`, `title`, `language`, `input`
- Especificar `expected_issues` y `expected_improvements`

## 🏗️ Estructura del proyecto

```
code-refactorer-skill/
├── SKILL.md                 ← Definición principal (NO tocar ligeramente)
├── references/              ← Documentación de referencia
│   ├── code-smells.md
│   ├── design-patterns.md
│   └── metrics.md
├── scripts/
│   └── validate.py         ← Script de validación
├── test-cases.json         ← Casos de prueba
├── assets/                 ← Recursos
└── .github/
    └── workflows/          ← GitHub Actions
```

## ✅ Antes de hacer Push

1. **Valida tu trabajo:**
   ```bash
   python scripts/validate.py
   ```

2. **Verifica que el JSON es válido:**
   ```bash
   python -m json.tool test-cases.json
   ```

3. **Revisa el markdown:**
   - No haya links rotos
   - Código resaltado correctamente
   - Ningún typo evidente

## 📝 Tipos de contribuciones

### 1. Nuevos code smells
Edita `references/code-smells.md`:
```markdown
### Mi nuevo smell
**Síntoma**: Lo que se ve mal
**Impacto**: Por qué es un problema
**Solución**: Cómo solucionarlo

```python
# ❌ Malo
...

# ✅ Bueno
...
```
```

### 2. Nuevos patrones
Edita `references/design-patterns.md`:
```markdown
### Mi patrón

**Cuándo**: Situaciones de uso  
**Ejemplo**: Caso real  
**Ventajas**: Por qué usarlo  
**Cómo aplicar**: Criterios  

```python
# Ejemplo de código
```
```

### 3. Nuevos casos de prueba
Agrega a `test-cases.json`:
```json
{
  "id": "test_N_language_description",
  "title": "Descripción clara",
  "language": "python",
  "input": "código a refactorizar",
  "expected_issues": ["problema 1", "problema 2"],
  "expected_improvements": ["mejora 1", "mejora 2"]
}
```

## 🔍 Validación automática

Los PRs se validan automáticamente con GitHub Actions:
- Validación de estructura
- Validación de YAML en SKILL.md
- Validación de JSON en test-cases.json
- Verificación de referencias

## 🎯 Prioridades de contribución

### 🔴 Altas
- Bugs en la validación
- Errores en code smells existentes
- Problemas de documentación crítica

### 🟡 Medias
- Nuevos code smells
- Nuevos patrones de diseño
- Mejoras de documentación
- Nuevos test cases

### 🟢 Bajas
- Mejoras de estilo
- Optimizaciones de performance
- Reformateo de código

## 📞 Comunicación

- Usa los issues para discusión
- Sé respetuoso y constructivo
- Incluye contexto suficiente
- Responde preguntas en los PRs

## 🚀 Merging

Un PR se puede mergear cuando:
- ✅ Pasa todos los checks automáticos
- ✅ Tiene al menos 1 approval
- ✅ No hay conflictos de merge
- ✅ Está actualizado con main

## 📜 Licencia

Al contribuir, aceptas que tu código sea licenciado bajo MIT.

## 💡 Preguntas?

- Abre un issue con la etiqueta `question`
- Mira las issues cerradas - puede que ya se haya respondido

---

¡Gracias por contribuir a Code Refactorer! 🎉
