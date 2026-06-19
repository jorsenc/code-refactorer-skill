# Guía Rápida - Code Refactorer Skill

Comienza a refactorizar código en 2 minutos.

## ⚡ 3 pasos para empezar

### 1️⃣ Instala la skill

En Claude.ai:
- Settings → Profile → Skills (en desarrollo)
- Arrastra la carpeta `code-refactorer-skill`
- ✅ Listo

### 2️⃣ Usa una de estas frases

```
"Refactoriza esto:"
"Analiza este código"
"Mejora este código"
"¿Qué problemas tiene este código?"
"Limpia este código"
```

### 3️⃣ Pega o sube tu código

Opción A - Directo en chat:
```
"Refactoriza esto:"
```python
def process(data):
    result = []
    for i in range(len(data)):
        if data[i] > 10:
            result.append(data[i] * 2)
    return result
```
```

Opción B - Sube archivo:
```
"Refactoriza este archivo"
[sube archivo.py]
```

---

## 📚 Ejemplos rápidos

### Python simple

**Tu código:**
```python
def validate_email(email):
    if email:
        if '@' in email:
            if '.' in email:
                return True
    return False
```

**Resultado:**
- ✅ Código refactorizado
- ✅ Explica cambios
- ✅ Sugiere mejoras

### JavaScript con problemas

**Tu código:**
```javascript
function fetchAndProcess(id, cb) {
  fetch('/api/user/' + id)
    .then(r => r.json())
    .then(d => {
      let processed = [];
      for (let i = 0; i < d.length; i++) {
        processed.push(d[i] * 2);
      }
      cb(processed);
    })
    .catch(e => cb(null));
}
```

**La skill:**
- Detecta Promises en lugar de async/await
- Sugiere arrow functions
- Propone modernizar el código
- Mejora error handling

---

## 🎯 Modos de uso

### Modo: Análisis automático (por defecto)
```
"Refactoriza esto:"
[código]
```
→ Análisis completo + código mejorado + informe

### Modo: Solo análisis
```
"Analiza este código pero no lo refactorices:"
[código]
```
→ Solo problemas identificados, sin cambios

### Modo: Refactorización enfocada
```
"Refactoriza esto enfocándote en [específico]:"
- performance
- legibilidad
- patrones de diseño
- reducir complejidad
[código]
```
→ Prioriza el área específica

### Modo: Sin breaking changes
```
"Refactoriza pero sin breaking changes:"
[código]
```
→ Solo refactorización segura, preserva compatibilidad

---

## 📊 Qué esperar en la respuesta

La skill te dará:

```
📋 ANÁLISIS
├─ Problemas encontrados
├─ Severidad (crítica/mayor/menor)
└─ Cuántas líneas afectadas

💡 PROPUESTAS
├─ Cada mejora explicada
├─ Impacto esperado
└─ Nivel de dificultad

💾 CÓDIGO REFACTORIZADO
├─ Versión limpia
├─ Cambios resaltados
└─ Listo para copiar/pegar

📈 MÉTRICAS
├─ Antes: complejidad X
└─ Después: complejidad Y

🔬 TESTS SUGERIDOS
└─ Cómo validar los cambios
```

---

## 🚨 Tipos de problemas que detecta

### Code Smells
- Funciones demasiado largas
- Variables con nombres genéricos (x, data, temp)
- Duplicación de código
- Demasiados parámetros
- Complejidad excesiva

### Violaciones SOLID
- Multiple responsabilidades (SRP)
- Dificultad para extender sin modificar (OCP)
- Interfaces incorrectas (ISP)
- Acoplamiento a implementaciones (DIP)

### Anti-patrones
- Callback Hell (JavaScript)
- Null pointer dereferences (Java/C#)
- Giant switch statements
- Falta de error handling
- Código mágico sin explicación

### Oportunidades
- Usar list comprehensions (Python)
- Usar async/await (JavaScript)
- Aplicar patrones (Factory, Strategy, etc.)
- Modernizar sintaxis
- Optimizar algoritmos

---

## 💬 Ejemplo conversación

**Tú:**
> Refactoriza esto:
> ```python
> def process_users(users):
>     result = []
>     for user in users:
>         if user['age'] > 18:
>             result.append({
>                 'name': user['name'],
>                 'adult': True
>             })
>     return result
> ```

**Claude (con skill):**
> 🔍 **Análisis identificado:**
> - Variables sin type hints
> - Diccionarios en lugar de dataclasses
> - Loop que podría ser list comprehension
> - Falta de documentación
>
> 💡 **Propuesta:**
> - Usar dataclass User
> - Aplicar filter + map
> - Agregar type hints
> - Agregar docstring
>
> 💾 **Código refactorizado:**
> ```python
> from dataclasses import dataclass
> 
> @dataclass
> class User:
>     name: str
>     age: int
>
> @dataclass
> class AdultInfo:
>     name: str
>     adult: bool
>
> def process_users(users: list[User]) -> list[AdultInfo]:
>     """Filter users and return only adults with basic info."""
>     return [
>         AdultInfo(name=user.name, adult=True)
>         for user in users
>         if user.age > 18
>     ]
> ```

---

## 🎓 Aprende mientras usas

Cada refactorización te enseña:
- ✅ Qué mejorar
- ✅ Cómo mejorarlo
- ✅ Por qué es mejor
- ✅ Qué patrón se aplica

---

## ⚙️ Configuración fina

Puedes dirigir el comportamiento:

```
"Refactoriza priorizando:"
- Rendimiento
- Legibilidad
- Mantenibilidad
- Modernidad

"Sin cambiar:"
- APIs públicas
- Orden de ejecución
- Framework usado
```

---

## 🔍 Casos especiales

### Código heredado
```
"Refactoriza este código heredado incrementalmente"
→ Propone pasos pequeños y seguros
```

### Preparar para testing
```
"Refactoriza preparando para testing"
→ Desacopla, inyecta dependencias
```

### Modernizar
```
"Moderniza este código"
→ USA funcionalidades recientes del lenguaje
```

### Optimizar performance
```
"Optimiza rendimiento en este código"
→ Identifica cuellos de botella
```

---

## 📞 Tips & Trucos

✅ **Adjunta el lenguaje explícito** si no es obvio:
```
"Refactoriza este código Python:"
```

✅ **Menciona la versión** si importa:
```
"Refactoriza para Python 3.10+:"
```

✅ **Sé específico** sobre qué arreglar:
```
"Refactoriza enfocándote en eliminar duplicación"
```

✅ **Pide explicaciones**:
```
"Refactoriza y explica qué cambió y por qué"
```

✅ **Solicita tests**:
```
"Refactoriza y sugiere tests"
```

---

## 🎯 Próximos pasos

1. **Instala la skill**
2. **Prueba con código simple** (5-10 líneas)
3. **Observa qué detecta**
4. **Aplica a proyectos reales**
5. **Gradualmente archivos más grandes**

---

## ❓ FAQ

**P: ¿Qué lenguajes soporta?**
R: Todos. Python, JavaScript, Java, C#, Go, Rust, PHP, etc.

**P: ¿Pierde funcionalidad?**
R: No. El código refactorizado hace lo mismo, solo mejor.

**P: ¿Puedo deshacer cambios?**
R: Claro, el código original está en la comparativa.

**P: ¿Funciona con archivos grandes?**
R: Sí, pero puede dividir en secciones si es muy grande.

**P: ¿Cómo valido los cambios?**
R: La skill sugiere tests. Ejecuta tests existentes para verificar.

---

## 🚀 ¡Listo para empezar!

Abre Claude.ai y prueba:
```
"Refactoriza esto:"
[tu código aquí]
```

¡Que disfrutes refactorizando! 🎉
