# Code Refactorer Skill

Una skill especializada de Claude para refactorización y mejora de código fuente en cualquier lenguaje de programación.

## 📋 Descripción

Esta skill proporciona análisis profundo y refactorización profesional de código, detectando automáticamente:

- **Code smells**: Patrones problemáticos que afectan la mantenibilidad
- **Violaciones SOLID**: Violaciones de principios de diseño
- **Duplicación**: Código repetido que puede consolidarse
- **Complejidad**: Funciones y métodos demasiado complejos
- **Oportunidades de optimización**: Mejoras de rendimiento
- **Patrones de diseño**: Oportunidades para aplicar patrones GoF

## 🎯 Características

✅ **Análisis multi-lenguaje**: Python, JavaScript, TypeScript, Java, C#, Go, etc.  
✅ **Informe completo**: Análisis detallado con métricas antes/después  
✅ **Código refactorizado**: Versión mejorada lista para usar  
✅ **Cambios explicados**: Cada cambio documentado con justificación  
✅ **Tests sugeridos**: Indicaciones para validar la refactorización  
✅ **Modos flexibles**: Análisis automático o dirigido  

## 📦 Contenido

```
code-refactorer-skill/
├── SKILL.md                    # Definición principal de la skill
├── test-cases.json            # Casos de prueba
├── references/
│   ├── code-smells.md         # Catálogo de code smells
│   ├── design-patterns.md     # Patrones de diseño aplicables
│   └── metrics.md             # Métricas de calidad de código
├── scripts/
│   └── validate.py            # Script de validación
└── assets/                     # Recursos adicionales (templates, etc.)
```

## 🚀 Instalación

### En Claude.ai

1. Descargar la carpeta `code-refactorer-skill`
2. Ir a **Configuración** → **Skills** (en desarrollo)
3. Subir la carpeta como una skill personalizada
4. La skill se activará automáticamente

### En Claude Code

```bash
# Copiar a la carpeta de skills
cp -r code-refactorer-skill ~/.config/claude/skills/

# Validar instalación
python3 code-refactorer-skill/scripts/validate.py
```

## 💡 Cómo usar

### Modo 1: Análisis automático

```
"Refactoriza esto:"
[pegar código]
```

La skill detectará automáticamente todos los problemas y los arreglará.

### Modo 2: Refactorización dirigida

```
"Refactoriza esto enfocándote en reducir complejidad:"
[código]
```

La skill prioriza los problemas específicos mencionados.

### Modo 3: Análisis sin cambios

```
"Analiza este código pero no lo refactorices:"
[código]
```

Proporciona solo el análisis sin modificaciones.

### Modo 4: Código desde archivo

Sube un archivo directamente y pide refactorización:
```
"Refactoriza este archivo"
[upload file.py]
```

## 📊 Salida esperada

Para cada refactorización recibirás:

### 1. Análisis Inicial
- Resumen ejecutivo
- Lenguaje y framework detectado
- Propósito del código
- Nivel de complejidad

### 2. Problemas Identificados
- Code smells por severidad
- Duplicación de código
- Complejidad ciclomática por función
- Violaciones de SOLID

### 3. Métricas
- Índice de mantenibilidad (antes/después)
- Complejidad promedio
- % de duplicación
- Estimación de cobertura de testing

### 4. Propuestas de Refactorización
Cada propuesta incluye:
- Descripción del cambio
- Impacto esperado
- Nivel de dificultad
- Prioridad

### 5. Código Refactorizado
- Versión mejorada completa
- Cambios detallados línea por línea
- Notas de compatibilidad
- Tests sugeridos

### 6. Comparativa Antes/Después
- Mejoras en métricas
- Reducción de complejidad
- Cambios de rendimiento

### 7. Recomendaciones
- Patrones de diseño a aplicar
- Próximos pasos
- Herramientas útiles

## 🔍 Ejemplos de uso

### Ejemplo 1: Python con code smells

**Entrada:**
```python
def process_data(data, threshold):
    result = []
    for i in range(len(data)):
        if data[i] > threshold:
            result.append(data[i] * 2)
    return result
```

**Salida:**
- Detecta: Nombres genéricos, falta de type hints, falta de docstring
- Propone: List comprehension, type hints, docstring
- Refactoriza a código limpio y profesional

### Ejemplo 2: JavaScript con Callback Hell

**Entrada:**
```javascript
function processUser(userId, callback) {
  fetchUser(userId, function(err, user) {
    if (err) callback(err);
    else {
      fetchProfile(user.id, function(err, profile) {
        // Nested callbacks...
      });
    }
  });
}
```

**Salida:**
- Detecta: Callback Hell, duplicación de error handling
- Propone: Usar async/await, centralizar error handling
- Refactoriza a código moderno y legible

### Ejemplo 3: Java con God Object

**Entrada:**
```java
public class UserManager {
    // Múltiples responsabilidades...
}
```

**Salida:**
- Detecta: Violación de SRP, múltiples responsabilidades
- Propone: Separar en UserRepository, UserValidator, UserNotifier
- Refactoriza con inyección de dependencias

## ⚙️ Configuración

La skill funciona out-of-the-box, pero puedes ajustar su comportamiento con frases adicionales:

- **"Sin breaking changes"**: Preserva compatibilidad total
- **"Cambios agresivos"**: Propone refactorizaciones más drásticas
- **"Enfocado en rendimiento"**: Prioriza optimizaciones de velocidad
- **"Enfocado en legibilidad"**: Prioriza código legible sobre brevedad
- **"Solo análisis"**: No refactoriza, solo analiza

## 📚 Referencias internas

La skill incluye tres referencias principales:

### 1. Code Smells (`references/code-smells.md`)
Catálogo de 50+ patrones problemáticos organizados por:
- Universales (aplican a todos los lenguajes)
- Específicos por lenguaje (Python, JavaScript, Java, C#, Go)

### 2. Design Patterns (`references/design-patterns.md`)
Patrones aplicables durante refactorización:
- Patrones Creacionales (Singleton, Factory, Builder)
- Patrones Estructurales (Decorator, Adapter, Proxy)
- Patrones de Comportamiento (Strategy, Observer, Command)
- Principios SOLID

### 3. Métricas (`references/metrics.md`)
Explicación de métricas de calidad:
- Complejidad Ciclomática
- Índice de Mantenibilidad
- Duplicación de Código
- Acoplamiento y Cohesión
- Coverage de tests

## 🧪 Validación

Para validar que la skill está correctamente instalada:

```bash
cd code-refactorer-skill
python3 scripts/validate.py
```

Deberías ver:
```
✅ SKILL.md: ✅
✅ Referencias: ✅ (3 archivos)
✅ Test cases: ✅ (6 casos)
✅ Estructura: ✅ (directorios correctos)
```

## 🔄 Flujo de refactorización típico

1. **Captura**: Recibe el código en cualquier formato
2. **Análisis**: Examina profundamente buscando problemas
3. **Priorización**: Ordena propuestas por impacto
4. **Refactorización**: Crea versión mejorada
5. **Documentación**: Explica todos los cambios
6. **Validación**: Sugiere tests para validar

## ⚠️ Limitaciones

- Respeta la funcionalidad original (sin cambios de comportamiento)
- No refactoriza código ofuscado intencionalmente sin confirmación
- Para cambios arquitectónicos, propone un plan incremental
- Respeta restricciones del lenguaje y framework
- Sugiere revisar compatibilidad con versiones mínimas

## 🤝 Casos de uso ideales

✅ Limpiar código de proyectos heredados  
✅ Mejorar legibilidad antes de onboarding  
✅ Preparar código para testing  
✅ Optimizar hotspots de rendimiento  
✅ Aplicar principios SOLID  
✅ Implementar patrones de diseño  
✅ Reducir deuda técnica  
✅ Code review automatizado  
✅ Refactorización incremental  
✅ Documentación de cambios  

## 📝 Notas técnicas

- **Modelo**: Usa Claude Sonnet 4 o superior
- **Lenguajes**: Soporta cualquier lenguaje de programación
- **Context**: Maneja archivos de cualquier tamaño
- **Salida**: HTML interactivo + Markdown + Código

## 🐛 Reporte de problemas

Si encuentras algún problema o tienes sugerencias:

1. Verifica que la skill esté validada (`validate.py`)
2. Prueba con el archivo de test cases incluido
3. Reporta el específico language y tipo de problema

## 📄 Licencia

Esta skill se proporciona como está, libre para usar y modificar.

## ✨ Mejoras futuras

- [ ] Integración con SonarQube
- [ ] Soporte para análisis de performance detallado
- [ ] Generación automática de tests unitarios
- [ ] Integración con CI/CD
- [ ] Dashboard de métricas
- [ ] Comparativa visual antes/después
- [ ] Reportes en formato PDF/HTML

---

**¿Preguntas?** Usa la skill directamente preguntando "¿Cómo refactorizo esto?" con tu código.

¡Que disfrutes refactorizando! 🎉
