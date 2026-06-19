---
name: code-refactorer
description: Refactoriza y mejora código fuente en cualquier lenguaje de programación. Úsalo siempre que el usuario quiera mejorar, optimizar o limpiar código existente, ya sea pegando fragmentos directamente, subiendo archivos, o indicando URLs. Detecta automáticamente problemas como duplicación, complejidad excesiva, code smells, falta de patrones de diseño, y oportunidades de optimización. Genera informes completos con análisis detallado, comparativas antes/después, métricas de mantenibilidad y recomendaciones de patrones. Actívalo cuando el usuario mencione "refactorizar", "limpiar código", "optimizar", "mejorar este código", "auditar código", "code review", "deuda técnica", "code smells", o simplemente pegue código que parezca que podría mejorarse.
---

# Code Refactorer Skill

Una skill especializada en refactorización y mejora de código fuente en cualquier lenguaje de programación. Proporciona análisis profundo, propuestas concretas y código refactorizado con explicaciones detalladas.

## Flujo de trabajo general

### 1. Captura del código fuente

El usuario puede proporcionar el código de varias formas:

- **Pegado directo en el chat**: Fragmentos de código entre triple backtick
- **Archivos locales**: Archivos subidos al chat
- **URLs**: Enlaces a repositorios o archivos en línea

Normaliza la entrada y detecta el lenguaje de programación automáticamente.

### 2. Análisis profundo

Ejecuta un análisis completo que incluye:

**Code Smells y Anti-patrones**
- Métodos/funciones demasiado largos
- Parámetros excesivos
- Duplicación de código
- Nombres poco descriptivos
- Complejidad ciclomática alta
- Violaciones del principio DRY

**Métricas de Calidad**
- Complejidad ciclomática
- Índice de mantenibilidad (maintainability index)
- Cobertura potencial de testing
- Nivel de acoplamiento

**Oportunidades de Optimización**
- Rendimiento y eficiencia
- Uso de memoria
- Operaciones redundantes
- Bucles y condicionales mejorables

**Patrones de Diseño**
- Patrones ausentes que podrían aplicarse
- Patrones mal utilizados
- Oportunidades para refactorización estratégica

### 3. Refactorización

Proporciona:

- **Código refactorizado**: Versión mejorada manteniendo la funcionalidad
- **Cambios explicados línea por línea**: Qué cambió y por qué
- **Tests sugeridos**: Para validar que la refactorización no rompió nada
- **Compatibilidad**: Información sobre cambios de API o comportamiento

### 4. Informe completo

El informe incluye:

```
📊 ANÁLISIS INICIAL
├── Resumen ejecutivo
├── Lenguaje y framework detectado
├── Propósito del código
└── Nivel de complejidad general

🚩 PROBLEMAS IDENTIFICADOS
├── Code smells (críticos, mayores, menores)
├── Duplicación de código
├── Complejidad ciclomática por función
└── Violaciones de principios SOLID

📈 MÉTRICAS
├── Índice de mantenibilidad (antes/después)
├── Complejidad promedio
├── Duplicación de código %
└── Estimación de testing coverage

🎯 PROPUESTAS DE REFACTORIZACIÓN
├── Refactorización #1: [Descripción]
│   ├── Impacto
│   ├── Dificultad
│   └── Prioridad
├── Refactorización #2
└── ...

💾 CÓDIGO REFACTORIZADO
├── Versión mejorada completa
├── Cambios detallados
├── Notas de compatibilidad
└── Tests sugeridos

🔄 COMPARATIVA ANTES/DESPUÉS
├── Métrica 1: X → Y
├── Métrica 2: X → Y
└── ...

🏗️ RECOMENDACIONES DE PATRONES
├── Patrón 1: Por qué aplicarlo
├── Patrón 2: Ejemplo de aplicación
└── ...

⚠️ CONSIDERACIONES
├── Breaking changes potenciales
├── Dependencias afectadas
└── Pasos de migración
```

## Modos de uso

### Modo 1: Análisis automático
```
Usuario: Refactoriza esto:
[código]
```
La skill detecta automáticamente todos los problemas y propone mejoras.

### Modo 2: Refactorización dirigida
```
Usuario: Refactoriza esto pero enfócate en reducir complejidad:
[código]
```
La skill prioriza problemas específicos mencionados.

### Modo 3: Análisis sin refactorización
```
Usuario: Analiza este código pero no lo refactorices aún:
[código]
```
La skill proporciona solo el informe de análisis.

### Modo 4: Refactorización incremental
Para archivos grandes, la skill:
- Divide el análisis en secciones
- Prioriza por impacto e importancia
- Proporciona refactorización incremental

## Guía de ejecución

### Paso 1: Recepción y normalización
1. Identifica dónde viene el código (chat, archivo, URL)
2. Normaliza el formato
3. Detecta el lenguaje y framework automáticamente
4. Si es ambiguo, pregunta al usuario

### Paso 2: Análisis inicial
1. Lee el código completo
2. Identifica el propósito principal
3. Detecta el patrón arquitectónico
4. Lista problemas obvios

### Paso 3: Análisis profundo
Ejecuta el análisis en cada dimensión:

**Legibilidad**
- Nombres de variables/funciones
- Documentación
- Estructura lógica
- Consistencia de estilo

**Mantenibilidad**
- Acoplamiento
- Cohesión
- Duplicación
- Complejidad

**Rendimiento**
- Algoritmos ineficientes
- Operaciones costosas
- Problemas de memoria
- Cuellos de botella

**Seguridad**
- Validación de entrada
- Inyecciones potenciales
- Gestión de recursos

### Paso 4: Generación de propuestas
1. Agrupa problemas por categoría
2. Prioriza por impacto/esfuerzo
3. Propone refactorizaciones específicas
4. Estima dificultad y esfuerzo

### Paso 5: Refactorización
1. Crea versión mejorada
2. Documenta cada cambio
3. Proporciona tests sugeridos
4. Mantiene compatibilidad donde es posible

### Paso 6: Generación del informe
1. Estructura el informe en secciones
2. Incluye visualizaciones de métricas
3. Proporciona comparativa antes/después
4. Sugiere próximos pasos

## Consideraciones especiales por lenguaje

### Python
**Análisis específico**:
- **Estilo**: PEP 8 compliance, naming conventions (snake_case)
- **Tipos**: Type hints modernos (PEP 484, 585), Union types, TypeVar
- **Async**: async/await sobre asyncio, generators, context managers
- **Sintaxis**: List/dict/set comprehensions vs loops, decoradores, f-strings
- **Patrones**: Dataclasses vs named tuples vs namedtuples, duck typing
- **Referencias**: code-smells.md secciones Python y Database
- **Frameworks**: Django N+1 queries (use prefetch_related), FastAPI async patterns

### TypeScript
**Análisis específico**:
- **Tipos**: Type safety, generics, union/intersection types, type guards
- **Decoradores**: Angular-style decorators, class-based type declaration
- **Async**: async/await sobre Promises, RxJS observables (si aplica)
- **Interfaces**: Structurally typed interfaces, strict property declaration
- **Patrones**: React Hooks vs class components, dependency injection
- **Referencias**: code-smells.md sección TypeScript, patterns-advanced.md Testing
- **Frameworks**: Angular RxJS patterns, React Hooks rules, NestJS decorators

### JavaScript
**Análisis específico**:
- **ES6+**: Arrow functions, destructuring, spread operator, classes
- **Async**: Promises vs async/await, callback hell avoidance
- **Patrones**: Module patterns, IIFE, closures for encapsulation
- **Arrays/Strings**: map/filter/reduce over loops, string interpolation
- **Referencias**: code-smells.md sección JavaScript, patterns-advanced.md Async
- **Frameworks**: React JSX patterns, Node.js middleware chains

### Java
**Análisis específico**:
- **SOLID**: Separación de responsabilidades, dependency injection
- **Generics**: Type erasure awareness, wildcards vs bounded types
- **Streams API**: map/filter/reduce patterns, lazy evaluation
- **Exceptions**: Checked vs unchecked, custom exception hierarchies
- **Patrones**: Factory, Strategy, Observer (GoF), Records (Java 14+)
- **Referencias**: code-smells.md sección Java, patterns-advanced.md Architectural
- **Frameworks**: Spring dependency injection, Hibernate ORM patterns

### C#/.NET
**Análisis específico**:
- **LINQ**: Method chaining, deferred execution, expression trees
- **Async**: async/await, ConfigureAwait(false), Task vs ValueTask
- **Null safety**: Nullable reference types (C# 8+), null-coalescing operator (??)
- **Propiedades**: Properties vs auto-properties vs fields, init-only properties
- **Patrones**: SOLID, async factory patterns, dependency injection containers
- **Referencias**: code-smells.md sección C#/.NET, patterns-advanced.md Resilience
- **Frameworks**: ASP.NET Core middleware, Entity Framework Core async queries

### Go
**Análisis específico**:
- **Interfaces**: Implicit interfaces, composition over inheritance
- **Errores**: Error handling (err != nil), custom error types, error wrapping
- **Concurrencia**: Goroutines, channels, select statements, sync patterns
- **Paquetes**: Package organization, unexported vs exported (naming)
- **Patrones**: Interface segregation, dependency injection (constructor)
- **Referencias**: code-smells.md sección Go, patterns-advanced.md Concurrency
- **Frameworks**: Web frameworks (Gin, Echo) middleware patterns

### Rust
**Análisis específico**:
- **Ownership**: Borrow checker, move semantics, lifetimes
- **Errores**: Result<T, E> vs Option<T>, error propagation (?), custom errors
- **Seguridad**: Memory safety, no null pointers, unwrap/expect wisely
- **Concurrencia**: Safe concurrent patterns, Arc, Mutex, channels
- **Patrones**: Builder pattern, type state pattern, trait-based design
- **Referencias**: code-smells.md sección Rust, patterns-advanced.md Actor Model

### Ruby
**Análisis específico**:
- **Estilo**: Snake_case, convention over configuration, blocks/yield
- **Metaprogramming**: Monkey patching (use modules), eval avoidance
- **Collections**: map/select/reduce over imperative loops, Symbol vs String
- **Patrones**: Mixins (modules), duck typing, DSL patterns
- **Rails**: ActiveRecord patterns, migrations, concern patterns
- **Referencias**: code-smells.md sección Ruby, patterns-advanced.md Testing

### PHP
**Análisis específico**:
- **OOP**: Type declarations, access modifiers, interfaces vs traits
- **Async**: Generators (yield), async via Amp/ReactPHP, error handling
- **Strings**: Type juggling risks, early returns to reduce nesting
- **Frameworks**: Laravel service containers, middleware pipeline, eloquent ORM
- **Referencias**: code-smells.md secciones universales, patrones framework-specific

### Kotlin
**Análisis específico**:
- **Null safety**: Non-null by default, smart casts, ?: Elvis operator
- **Funcional**: Lambda expressions, extension functions, scoping functions
- **Coroutines**: Async patterns via Kotlin coroutines, structured concurrency
- **Java interop**: Java collection compatibility, Kotlin-Java bridge patterns
- **Android**: Fragment lifecycle, LiveData patterns, Jetpack Compose (si aplica)
- **Referencias**: patterns-advanced.md Async, concurrency best practices

## Salida esperada

La skill siempre proporciona:

1. **Análisis HTML interactivo** (si es viable)
   - Código con resaltado de sintaxis
   - Métricas visualizadas
   - Comparativas antes/después

2. **Código refactorizado**
   - En archivos descargables
   - Con comentarios explicativos
   - Listo para usar

3. **Documentación**
   - Informe en markdown
   - Guía de cambios
   - Tests sugeridos

4. **Recomendaciones**
   - Próximos pasos
   - Herramientas útiles
   - Lecturas recomendadas

## Limitaciones y salvedades

- La refactorización respeta la funcionalidad original (sin cambios de comportamiento)
- No refactoriza código ofuscado intencionalmente sin confirmación
- Para cambios arquitectónicos mayores, propone un plan incremental
- Respeta las restricciones del lenguaje y framework
- Sugiere revisar compatibilidad con versiones mínimas requeridas

## Casos de uso ideales

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

## Recursos adicionales

Para análisis y propuestas más específicas, ver:
- `/references/code-smells.md` — Catálogo de code smells por lenguaje
- `/references/design-patterns.md` — Patrones aplicables y cuándo usarlos
- `/references/metrics.md` — Interpretación de métricas de calidad
