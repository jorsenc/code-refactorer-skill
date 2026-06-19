# Scripts

Herramientas de utilidad para el desarrollo y mantenimiento de la skill.

## Archivos

### `validate.py`
Valida la estructura de la skill después de cambios.

**Uso:**
```bash
python3 validate.py
```

**Verifica:**
- ✅ SKILL.md existe con frontmatter YAML válido
- ✅ Archivos de referencia existen y tienen >50 líneas
- ✅ test-cases.json es JSON válido
- ✅ Estructura de directorios es correcta

**Cuándo ejecutar:**
- Después de editar archivos de referencia
- Antes de hacer commit
- Después de agregar test cases

### `github-quick-commands.sh`
Comandos rápidos para operaciones comunes en GitHub.

**Incluye:**
- Crear ramas
- Hacer push
- Crear PRs
- Limpiar repositorio

### `upload-to-github.sh`
Script para subir la skill a GitHub de forma automatizada.

---

Última actualización: 2026-06-19
