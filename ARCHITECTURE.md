# Arquitectura de Code Refactorer Skill

Documentación técnica interna de la skill.

## Estructura general

```
code-refactorer-skill/
├── SKILL.md                    # Definición principal (8.1 KB)
├── test-cases.json            # 6 casos de prueba
├── references/                # Documentación de referencia
│   ├── code-smells.md         # 352 líneas - Catálogo de problemas
│   ├── design-patterns.md     # 378 líneas - Patrones aplicables
│   └── metrics.md             # 273 líneas - Métricas de calidad
├── scripts/
│   └── validate.py            # Validación de estructura
└── assets/                     # Recursos futuros
```

## Flujo de ejecución

### Fase 1: Recepción (Entry Point)

```
Usuario pide refactorización
    ↓
Detectar fuente: chat/archivo/URL
    ↓
Normalizar formato
    ↓
Detectar lenguaje automáticamente
```

**Detección de lenguaje:**
- Extensión de archivo
- Análisis de sintaxis
- Keywords specificos
- Fallback a preguntar si es ambiguo

### Fase 2: Análisis profundo

```
Lectura del código
    ↓
┌─── Análisis de legibilidad
│    ├─ Nombres de variables/funciones
│    ├─ Documentación
│    ├─ Estructura lógica
│    └─ Consistencia de estilo
│
├─── Análisis de mantenibilidad
│    ├─ Acoplamiento (Ca, Ce)
│    ├─ Cohesión (LCOM)
│    ├─ Complejidad ciclomática
│    └─ Duplicación de código
│
├─── Análisis de rendimiento
│    ├─ Algoritmos ineficientes
│    ├─ Operaciones costosas
│    ├─ Problemas de memoria
│    └─ Cuellos de botella
│
└─── Análisis de seguridad
     ├─ Validación de entrada
     ├─ Inyecciones potenciales
     └─ Gestión de recursos

        ↓
    Compilar resultados
```

### Fase 3: Generación de propuestas

```
Problemas identificados
    ↓
Agrupar por categoría
    ↓
Calcular impacto (Alto/Medio/Bajo)
    ↓
Estimar dificultad (Fácil/Moderada/Difícil)
    ↓
Calcular esfuerzo (1-5 horas)
    ↓
Priorizar por impacto/esfuerzo
```

### Fase 4: Refactorización

```
Para cada propuesta (en orden prioritario):
    ├─ Modificar código
    ├─ Validar sintaxis
    ├─ Documentar cambio
    ├─ Crear test sugerido
    └─ Actualizar métricas

        ↓
    Compilar versión final
```

### Fase 5: Generación de informe

```
Crear estructura de informe:
├─ Resumen ejecutivo
├─ Problemas identificados
├─ Propuestas de refactorización
├─ Código refactorizado
├─ Comparativa antes/después
├─ Recomendaciones
└─ Próximos pasos
```

## Componentes principales

### 1. SKILL.md (8.1 KB)

**Secciones:**
- Metadata (name, description)
- Flujo de trabajo general
- Modos de uso (4 modos)
- Guía de ejecución (6 pasos)
- Consideraciones por lenguaje
- Salida esperada
- Limitaciones
- Casos de uso

**Propósito:**
- Define behavior esperado
- Guía al modelo en cada paso
- Establece límites y salvedades
- Proporciona ejemplos

### 2. references/code-smells.md (352 líneas)

**Estructura:**
```
Problemas universales (7)
├─ Métodos demasiado largos
├─ Clases demasiado grandes
├─ Duplicación de código
├─ Nombres poco descriptivos
├─ Demasiados parámetros
├─ Complejidad alta
└─ Comentarios de código malo

Problemas Python (5)
├─ Falta de type hints
├─ Exception handling genérico
├─ Mutable default arguments
├─ Diccionarios vs dataclasses
└─ No usar context managers

Problemas JavaScript (4)
├─ Callback Hell
├─ No usar type checking
├─ Mutación de objetos
└─ Falta de error handling

Problemas Java (4)
├─ Null dereferences
├─ No usar Streams API
├─ Exception handling genérico
└─ God Objects

Problemas C#/.NET (3)
├─ No usar LINQ
├─ Null checking manual
└─ No usar async/await

Problemas Go (3)
├─ Ignorar errores
├─ No usar interfaces
└─ Goroutines sin sincronización
```

**Uso:**
- Referencia durante análisis
- Identifica patrones problemáticos
- Proporciona soluciones

### 3. references/design-patterns.md (378 líneas)

**Patrones incluidos:**

**Creacionales (3):**
- Singleton
- Factory Pattern
- Builder Pattern

**Estructurales (3):**
- Decorator
- Adapter
- Proxy

**Comportamiento (4):**
- Strategy
- Observer
- Template Method
- Command

**SOLID (5):**
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

**Estructura de cada patrón:**
```
Nombre
├─ Cuándo: situaciones de uso
├─ Ejemplo: caso de uso real
├─ Ventajas: beneficios
├─ Cuándo aplicar: triggers
└─ Código: antes/después
```

**Uso:**
- Propone patrones aplicables
- Muestra cómo implementar
- Explica beneficios

### 4. references/metrics.md (273 líneas)

**Métricas cubiertas:**

1. **Complejidad Ciclomática**
   - Qué mide
   - Fórmula
   - Rangos de interpretación
   - Cómo reducir

2. **Índice de Mantenibilidad**
   - Combinación de factores
   - Escala 0-100
   - Cómo mejorar

3. **Duplicación de Código**
   - Detección
   - Umbrales
   - Cómo reducir

4. **Acoplamiento**
   - Aferente vs Eferente
   - Inestabilidad
   - Cómo reducir

5. **Cohesión**
   - LCOM (Lack of Cohesion of Methods)
   - Cómo mejorar

6. **Cobertura de Tests**
   - Tipos de coverage
   - Objetivos recomendados

7. **Densidad de Defectos**
   - Cálculo
   - Benchmarks

8. **Herramientas por lenguaje**
   - Python: pylint, radon, coverage
   - JavaScript: ESLint, Istanbul
   - Java: SonarQube, SpotBugs
   - C#: SonarQube, FxCopAnalyzers
   - Go: golangci-lint, gocyclo

**Uso:**
- Interpreta métricas en análisis
- Proporciona benchmarks
- Valida mejoras

### 5. test-cases.json

**Estructura:**
```json
{
  "id": "test_1_python_simple",
  "title": "Descripción del caso",
  "language": "python",
  "input": "código a refactorizar",
  "expected_issues": ["problema 1", "problema 2"],
  "expected_improvements": ["mejora 1", "mejora 2"]
}
```

**Casos incluidos:**
1. Python - Función con code smells
2. JavaScript - Callback Hell
3. Java - Null pointer dereference
4. Python - God Object
5. Python - Código duplicado
6. TypeScript - Sin type hints

**Uso:**
- Validar que la skill funciona
- Casos para entrenar
- Ejemplos para usuarios

### 6. scripts/validate.py

**Validaciones:**
- SKILL.md existe y tiene estructura YAML
- Referencias existen y tienen contenido suficiente
- Test cases están en JSON válido
- Directorios están creados
- Permisos correctos

**Salida:**
```
✅ Validación exitosa
📊 Resumen de recursos
```

## Estrategia de análisis por lenguaje

### Python

```
Detectar:
├─ Falta de type hints → Agregar PEP 484
├─ Métodos largos → Extract method
├─ Excepciones genéricas → Especificar tipos
├─ Mutable defaults → Usar None
├─ No context managers → with statement
└─ Diccionarios → dataclass/TypedDict

Frameworks:
├─ Django → ORM patterns
├─ FastAPI → Async patterns
├─ Flask → Blueprints
└─ Pandas → Vectorization
```

### JavaScript/TypeScript

```
Detectar:
├─ Callback Hell → async/await
├─ Promises anidadas → async/await
├─ Sin type checking → TypeScript
├─ Mutación → Immutability
├─ Strings mágicas → Enums
└─ Sin error handling → Try/catch

Frameworks:
├─ React → Hooks patterns
├─ Vue → Composition API
├─ Node.js → Async patterns
└─ Angular → RxJS
```

### Java

```
Detectar:
├─ Null checks → Optional
├─ Loops verbosos → Streams API
├─ Excepciones genéricas → Específicas
├─ God Objects → SRP
├─ Switch statements → Strategy
└─ Singletons → DI

Patterns:
├─ Entity beans → POJOs
├─ God classes → Extract classes
└─ Checked exceptions → Runtime
```

### C#/.NET

```
Detectar:
├─ Loops → LINQ
├─ Null checks → Nullable reference types
├─ Async void → async Task
├─ Mutable collections → Immutable
├─ Manual mapping → AutoMapper
└─ Property boilerplate → Auto-properties

Patterns:
├─ Null-coalescing operator
├─ Pattern matching
└─ Records
```

## Métricas de salida

### Antes de refactorización

```
Cyclomatic Complexity (CC):
├─ Promedio por función
├─ Máximo encontrado
└─ Funciones con CC > 10

Maintainability Index:
└─ 0-100 scale

Duplication:
├─ % total
├─ Líneas duplicadas
└─ Instancias

Test Coverage:
└─ Estimado (sin ejecutar tests)

SOLID violations:
├─ SRP: problemas encontrados
├─ OCP: casos de modificación
├─ LSP: incompatibilidades
├─ ISP: interfaces amplias
└─ DIP: acoplamiento directo
```

### Después de refactorización

```
Mismas métricas + Δ (cambio)

Ejemplo:
CC: 8 → 5 (↓ 37.5%)
MI: 62 → 78 (↑ 25.8%)
Duplication: 12% → 3% (↓ 75%)
```

## Casos de borde

### Archivos muy grandes (>1000 líneas)

```
Estrategia:
├─ Dividir en secciones lógicas
├─ Analizar sección por sección
├─ Priorizar refactorización
└─ Proponer plan incremental
```

### Código obfuscado

```
Comportamiento:
├─ Detectar patrones encriptados
├─ Preguntar al usuario antes de refactorizar
└─ Proponer documentación primero
```

### Código generado automáticamente

```
Comportamiento:
├─ Detectar (comentarios, estructura)
├─ Informar al usuario
├─ No refactorizar sin confirmación
└─ Sugerir mejoras en generador
```

### Dependencias complejas

```
Análisis:
├─ Detectar circular dependencies
├─ Evaluar breaking changes
├─ Proponer plan de migración
└─ Sugerir refactorización gradual
```

## Integración con herramientas

### Herramientas que completan análisis

```
Python:
├─ radon → Complejidad ciclomática
├─ pylint → Linting
└─ coverage → Test coverage

JavaScript:
├─ ESLint → Problemas
├─ SonarQube → Análisis profundo
└─ Istanbul → Coverage

Java/C#:
├─ SonarQube → Enterprise
└─ Checkstyle → Convenciones

Go:
├─ golangci-lint → Linting
└─ gocyclo → Complejidad
```

**Nota:** La skill usa heurística y análisis manual, no ejecuta herramientas.

## Limitaciones técnicas

1. **Sin ejecución de código**: No corre el código para validar
2. **Sin análisis de runtime**: Solo análisis estático
3. **Sin cobertura real**: Estima cobertura, no la mide
4. **Sin profiling**: No mide performance real
5. **Sin análisis de dependencias**: Análisis básico
6. **Sin tests reales**: Sugiere tests, no los ejecuta

## Seguridad

- ✅ No ejecuta código
- ✅ No accede a sistemas externos
- ✅ No modifica archivos automáticamente
- ✅ Requiere confirmación para cambios
- ✅ Preserva funcionalidad original

## Performance esperado

```
Tamaño de código | Tiempo estimado
────────────────┼─────────────────
< 100 líneas    | 10-20 segundos
100-500 líneas  | 20-40 segundos
500-2000 líneas | 40-120 segundos
> 2000 líneas   | Plan incremental
```

## Extensibilidad futura

### Plugins por lenguaje

```
plugins/
├── python_plugin.py
├── javascript_plugin.js
├── java_plugin.py
└── csharp_plugin.py
```

### Custom rules

```
rules/
├── company_style.json
├── performance_rules.json
└── security_rules.json
```

### Integración CI/CD

```
- GitHub Actions
- GitLab CI
- Jenkins
- CircleCI
```

---

**Última actualización**: Mayo 2026  
**Versión de skill**: 1.0  
**Modelo base**: Claude Sonnet 4+
