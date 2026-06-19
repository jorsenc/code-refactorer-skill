# Métricas de Calidad de Código

Cómo medir y interpretar la calidad del código.

## Métricas principales

### 1. Complejidad Ciclomática (Cyclomatic Complexity)

**Qué mide**: Número de caminos diferentes que puede tomar un programa

**Fórmula**: CC = número de decisiones + 1

```python
# CC = 1 (sin decisiones)
def simple():
    return 42

# CC = 2 (una decisión)
def with_if(x):
    if x > 0:
        return x
    return -x

# CC = 3 (dos decisiones)
def with_if_else(x):
    if x > 0:
        return x
    elif x < 0:
        return -x
    return 0

# CC = 4 (anidadas)
def nested(x, y):
    if x > 0:
        if y > 0:
            return x + y
        return x
    return 0
```

**Interpretación**:
- 1-3: Excelente (fácil testear)
- 4-7: Bueno (testeable)
- 8-10: Complejo (difícil testear, considerar refactorizar)
- 11+: Muy complejo (refactorizar urgentemente)

**Cómo reducir**:
- Extract Method por cada rama if/else
- Strategy Pattern para lógica condicional
- Guard clauses en lugar de if/else anidado

### 2. Índice de Mantenibilidad (Maintainability Index)

**Qué mide**: Combinación de complejidad, líneas de código, cobertura

**Fórmula**: MI = 171 - 5.2*ln(V) - 0.23*CC + 16.2*ln(LOC) + 50*sin(sqrt(2.4*CM))

Donde:
- V = Volumen (líneas de código Halstead)
- CC = Complejidad Ciclomática
- LOC = Líneas de código
- CM = Cobertura

**Rango**:
- 100-86: Excelente (verde)
- 85-71: Bueno (amarillo)
- 70-51: Moderado (naranja) - considerar refactorizar
- 50+: Pobre (rojo) - refactorizar urgentemente

**Cómo mejorar**:
- Reducir complejidad ciclomática
- Acortar funciones
- Mejorar cobertura de tests

### 3. Duplicación de Código (Code Duplication)

**Qué mide**: Porcentaje de código duplicado o similar

**Umbral**: <3% es excelente, 3-5% es normal, >10% es problemático

**Detección**:
- Bloques idénticos (fácil de detectar)
- Bloques similares (requiere análisis)

**Cómo reducir**:
- Extract Method / Extract Function
- Create utility functions
- Usar Templates (Template Method Pattern)
- DRY Principle

### 4. Complejidad del Acoplamiento

**Qué mide**: Cuánto depende una clase/módulo de otros

**Tipos**:
- **Acoplamiento aferente (Ca)**: Clases que dependen de esta
- **Acoplamiento eferente (Ce)**: Clases de las que depende esta

**Métrica**: Inestabilidad = Ce / (Ca + Ce)
- 0 = muy estable
- 1 = muy inestable

**Interpretación**:
- <0.3: Buen módulo base (stable)
- 0.3-0.7: Módulo intermedio
- >0.7: Módulo volatile (inestable, cambios frecuentes)

**Cómo reducir**:
- Dependency Injection
- Depender de abstracciones (interfaces)
- Extract stable base classes

### 5. Cohesión (Cohesion)

**Qué mide**: Cuánto están relacionados los métodos de una clase

**Métrica**: Lack of Cohesion of Methods (LCOM)
- 0 = Perfectamente cohesivo
- Valor alto = Baja cohesión (refactorizar)

**Cómo mejorar**:
- Si métodos no usan los mismos atributos → Extract Class
- Mantener clase enfocada en una responsabilidad

**Ejemplo**:
```python
# ❌ Baja cohesión (LCOM alto)
class UserManager:
    def validate_email(self):      # Usa: email
        pass
    
    def validate_password(self):   # Usa: password
        pass
    
    def calculate_age(self):       # Usa: birth_date
        pass
    
    def send_notification(self):   # Usa: notification_service
        pass
    # Pocos métodos comparten datos

# ✅ Alta cohesión (LCOM bajo)
class UserValidator:
    def validate_email(self):
        pass
    
    def validate_password(self):
        pass
    # Todos usan el mismo estado

class UserAgeCalculator:
    def calculate_age(self):
        pass

class NotificationService:
    def send_notification(self):
        pass
```

### 6. Cobertura de Tests (Test Coverage)

**Qué mide**: Porcentaje de código ejecutado por tests

**Tipos**:
- **Line coverage**: Líneas ejecutadas
- **Branch coverage**: Ramas if/else ejecutadas
- **Path coverage**: Todos los caminos ejecutados

**Objetivos**:
- >80%: Excelente
- 60-80%: Bueno
- 40-60%: Regular (mejorable)
- <40%: Pobre (refactorizar + tests)

**Nota**: 100% coverage no garantiza calidad, pero <50% es riesgoso

### 7. Densidad de Defectos

**Qué mide**: Bugs por línea de código (problemas encontrados en testing)

**Cálculo**: Defects / Lines of Code * 1000

**Benchmarks**:
- <1: Excelente
- 1-3: Bueno
- 3-5: Regular
- >5: Pobre (refactorizar)

---

## Cómo interpretar múltiples métricas

### Código "Rojo" (Refactorizar urgentemente)
- Complejidad ciclomática: >10 por función
- Maintainability Index: <50
- Duplicación: >15%
- Cobertura: <40%

### Código "Amarillo" (Mejorable)
- Complejidad ciclomática: 8-10 por función
- Maintainability Index: 50-70
- Duplicación: 5-10%
- Cobertura: 60-80%

### Código "Verde" (Buena calidad)
- Complejidad ciclomática: <7 por función (promedio <4)
- Maintainability Index: >71
- Duplicación: <3%
- Cobertura: >80%

---

## Herramientas por lenguaje

### Python
- **pylint**: Análisis estático, convenciones PEP 8
- **flake8**: Linting
- **radon**: Complejidad ciclomática, mantenibilidad
- **coverage**: Cobertura de tests

```bash
radon cc file.py  # Complejidad ciclomática
radon mi file.py  # Índice de mantenibilidad
radon metrics file.py  # Métricas generales
```

### JavaScript/TypeScript
- **ESLint**: Linting
- **SonarQube**: Análisis completo
- **code-complexity**: Complejidad
- **Istanbul/NYC**: Coverage

### Java
- **SonarQube**: Enterprise standard
- **SpotBugs**: Bugs potenciales
- **Checkstyle**: Convenciones
- **JaCoCo**: Coverage

### C#/.NET
- **SonarQube**: Análisis
- **FxCopAnalyzers**: Reglas de diseño
- **StyleCopAnalyzers**: Estilo
- **OpenCover**: Coverage

### Go
- **golangci-lint**: Linting completo
- **gocyclo**: Complejidad ciclomática
- **dupl**: Duplicación
- **go tool cover**: Coverage

---

## Cómo usar métricas en refactorización

1. **Baseline**: Mide el código actual
2. **Identifica puntos calientes**: Qué tiene peor métrica
3. **Prioriza**: Empieza por lo más impactante (CC alta, Duplicación, etc.)
4. **Refactoriza**: Aplica patrones para mejorar
5. **Remide**: Verifica que mejoraron las métricas
6. **Valida**: Asegura que tests pasan

---

## Regla de oro

**No todas las métricas altas son malas, ni todas las bajas son buenas.**

La métrica es una guía, no una regla. Un función puede tener CC=8 pero ser clara. Una función puede tener CC=2 pero ser confusa.

**Enfoque**:
- Usa métricas para identificar candidatos para refactorización
- Usa juicio técnico para decidir si refactorizar
- Valida con tests que todo sigue funcionando
