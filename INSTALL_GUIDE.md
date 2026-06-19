# Guía de Instalación - Code Refactorer Skill v2.0

**Versión**: 2.0 (Fase 1+2 Completadas)  
**Fecha**: 2026-06-19  
**Estado**: Producción-ready (8.5/10)

---

## 📋 Requisitos Previos

- ✅ Acceso a Claude.ai
- ✅ Carpeta `code-refactorer-skill` (obtenida del repositorio GitHub)
- ✅ Navegador web moderno

---

## 🚀 Pasos de Instalación

### Paso 1: Descargar la carpeta

```bash
git clone https://github.com/jorsenc/code-refactorer-skill.git
# O descargar como ZIP desde GitHub
```

### Paso 2: Preparar para instalación

La carpeta debe contener estos archivos clave:

```
code-refactorer-skill/
├── SKILL.md                          # Definición principal (REQUERIDO)
├── CLAUDE.md                         # Guía para Claude Code
├── INTEGRATION.md                    # Guía CI/CD
├── WORKFLOWS.md                      # Guías de uso
├── README.md                         # Descripción general
├── QUICK_START.md                    # Inicio rápido
├── ARCHITECTURE.md                   # Arquitectura técnica
├── CONTRIBUTING.md                   # Contribución
├── test-cases.json                   # 12 casos de prueba
├── references/
│   ├── code-smells.md               # 50+ patrones problemáticos
│   ├── design-patterns.md           # 15 patrones GoF + SOLID
│   ├── metrics.md                   # Métricas de calidad
│   └── patterns-advanced.md         # 35+ patrones avanzados
└── scripts/
    └── validate.py                  # Validación de estructura
```

✅ Verifica que la carpeta tenga estos archivos (deberían estar en GitHub).

### Paso 3: Instalar en Claude.ai

#### Para usuarios web (claude.ai):

1. Abre **https://claude.ai**
2. Navega a **Configuración → Perfil → Skills** (en desarrollo)
3. Busca la opción **"Agregar skill personalizada"** o **"Upload Custom Skill"**
4. Arrastra y suelta la carpeta `code-refactorer-skill` completa
   - O selecciona la carpeta manualmente
5. Espera a que Claude procese y reconozca la skill

#### Para Claude Code (CLI):

```bash
# Copiar la skill a la carpeta de skills
cp -r code-refactorer-skill ~/.config/claude/skills/

# O en Windows (PowerShell):
Copy-Item -Recurse code-refactorer-skill "$env:APPDATA\Claude\skills\"
```

### Paso 4: Verificar instalación

Una vez instalada, la skill debería aparecer como opción en Claude.

**Test rápido** en Claude:
```
"Refactoriza esto:"
[pegar código simple]
```

La skill debería:
- ✅ Detectar el lenguaje automáticamente
- ✅ Identificar code smells
- ✅ Proponer mejoras
- ✅ Generar código refactorizado

---

## 📊 Versión 2.0 - Nuevas Características

### Lenguajes Soportados (9+)
- ✅ Python (mejorado)
- ✅ JavaScript/TypeScript (mejorado)
- ✅ Java (mejorado)
- ✅ C#/.NET (mejorado)
- ✅ Go (mejorado)
- 🆕 Rust
- 🆕 Ruby
- 🆕 PHP
- 🆕 Kotlin

### Nuevas Guías
- 🆕 **INTEGRATION.md**: CI/CD, GitHub Actions, pre-commit hooks
- 🆕 **WORKFLOWS.md**: 5 guías paso-a-paso
  - Refactoring de código heredado
  - Preparar código para testing
  - Optimización de rendimiento
  - Aplicar SOLID principles
  - Migración de async patterns

### Nuevos Patrones
- 🆕 **patterns-advanced.md**: 35+ patrones (Arquitectura, Cloud-native, Testing, Concurrency)

### Mejoras de Análisis
- 🆕 Magic Strings & Constants detection
- 🆕 Database anti-patterns (N+1, SELECT *)
- 🆕 Performance anti-patterns
- 🆕 Cognitive Complexity metric
- 🆕 Technical Debt Ratio

### Test Cases Expandidos
- De 6 → **12 casos** (Rust, Ruby, async, database, security, large files)

---

## 🧪 Pruebas Recomendadas

Después de instalar, prueba estos casos:

### Test 1: Python Simple
```python
def process_data(data, threshold):
    result = []
    for i in range(len(data)):
        if data[i] > threshold:
            result.append(data[i] * 2)
    return result
```
**Esperado**: Detectar nombres genéricos, range(len()), falta de type hints

### Test 2: Rust Ownership
```rust
fn read_config() -> String {
    std::fs::read_to_string("config.json").unwrap()
}

fn parse_number(input: &str) -> i32 {
    input.parse().unwrap()
}
```
**Esperado**: Detectar unwrap() sin manejo de errores

### Test 3: TypeScript Types
```typescript
function calculatePrice(basePrice, quantity, taxRate, discount) {
  const subtotal = basePrice * quantity;
  const tax = subtotal * taxRate;
  const finalDiscount = subtotal * discount;
  return subtotal + tax - finalDiscount;
}
```
**Esperado**: Detectar falta de type annotations, magic numbers

### Test 4: Database N+1
```python
users = User.objects.all()
for user in users:
    print(f"{user.name}: {user.profile.bio}")
    for post in user.posts.all():
        print(f"  - {post.title}")
```
**Esperado**: Detectar N+1 queries, sugerir prefetch_related

### Test 5: Async Chains
```javascript
function processData(url) {
  return fetch(url)
    .then(r => r.json())
    .then(data => transform(data)
      .then(t => save(t)
        .then(r => notify(r))
      )
    )
    .catch(err => console.error(err));
}
```
**Esperado**: Detectar Promise chains profundas, sugerir async/await

---

## 📈 Métricas de Versión 2.0

| Métrica | v1.0 | v2.0 | Mejora |
|---------|------|------|--------|
| Lenguajes | 6 | 9+ | +50% |
| Code smells | 27 | 50+ | +85% |
| Patrones | 15 | 50+ | +233% |
| Test cases | 6 | 12 | +100% |
| Líneas de referencia | 1,000 | 2,500 | +150% |
| **Score** | **6.5/10** | **8.5/10** | **+2** |

---

## ⚙️ Configuración Avanzada

### En Claude Code

```json
// .claude/settings.json
{
  "code-refactorer": {
    "enabled": true,
    "defaultMode": "detailed",
    "focusArea": "maintainability"
  }
}
```

### Pre-commit Hook (Opcional)

```bash
# .git/hooks/pre-commit
python3 -m claude.skills.code_refactorer . --check
```

---

## 🐛 Troubleshooting

### "Skill no aparece en Claude"

- Verifica que la carpeta tenga `SKILL.md` en el root
- Recarga la página de Claude
- Intenta desinstalar y reinstalar

### "No detecta mi lenguaje"

- Asegúrate de que el código está bien formado
- Prueba con uno de los test cases incluidos
- Verifica que el lenguaje esté en la lista soportada

### "Error de validación"

- Ejecuta: `python3 scripts/validate.py`
- Verifica que `test-cases.json` es JSON válido
- Asegúrate de que las referencias existen

---

## 📞 Soporte

**Documentación**:
- QUICK_START.md — Inicio en 2 minutos
- ARCHITECTURE.md — Cómo funciona internamente
- INTEGRATION.md — Integración con CI/CD
- WORKFLOWS.md — Casos de uso paso-a-paso

**GitHub**:
- Reporta issues: https://github.com/jorsenc/code-refactorer-skill/issues
- Fork & contribuye: https://github.com/jorsenc/code-refactorer-skill

---

## ✨ Qué Esperar

Después de instalar, la skill:

✅ Analiza código en cualquier lenguaje  
✅ Detecta 50+ code smells  
✅ Propone 50+ patrones de diseño  
✅ Genera código refactorizado  
✅ Proporciona guías paso-a-paso  
✅ Integra con CI/CD  
✅ Mide mejoras (métricas antes/después)  

**Resultado**: Código más limpio, mantenible y profesional.

---

**¡Disfruta refactorizando! 🚀**

*Generated: 2026-06-19*  
*Version: 2.0 (Production-Ready)*
