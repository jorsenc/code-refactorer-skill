# Code Smells por Lenguaje

Catálogo de patrones problemáticos comunes y cómo identificarlos.

## Universales (aplican a todos los lenguajes)

### 1. Métodos/Funciones demasiado largos
**Síntoma**: Función con >20-30 líneas
**Impacto**: Difícil de entender, testear y mantener
**Solución**: Extract Method / Function extraction

### 2. Clases/Módulos demasiado grandes
**Síntoma**: >300-400 líneas, múltiples responsabilidades
**Impacto**: Violación de Single Responsibility Principle
**Solución**: Extract Class, Split Module

### 3. Duplicación de código
**Síntoma**: Bloques de código idénticos o similares en múltiples lugares
**Impacto**: Mantenimiento difícil, propenso a bugs
**Solución**: Extract Method, Create utility function

### 4. Nombres poco descriptivos
**Síntoma**: Variables `x`, `temp`, `data`, `obj`; funciones `do()`, `process()`
**Impacto**: Código difícil de entender
**Solución**: Rename, usar nombres específicos del dominio

### 5. Demasiados parámetros
**Síntoma**: Función con >3-4 parámetros
**Impacto**: Interfaz compleja, difícil de llamar y mantener
**Solución**: Object Parameter, Group related parameters

### 6. Complejidad ciclomática alta
**Síntoma**: Muchas decisiones (if/else, switch) anidadas
**Impacto**: Difícil de testear, propenso a bugs
**Solución**: Extract Method, Strategy Pattern

### 7. Comentarios que explican código mal escrito
**Síntoma**: Comentarios extensos explicando lógica confusa
**Impacto**: Indica código poco claro
**Solución**: Refactorizar el código para ser auto-explicativo

### 8. Números mágicos
**Síntoma**: Números sin contexto en el código
**Impacto**: Significado poco claro, difícil mantener
**Solución**: Extract constant, named variable

---

## Python-específicos

### 1. Falta de type hints
```python
# ❌ Malo
def process(data, threshold):
    if data > threshold:
        return data * 2

# ✅ Bueno
def process(data: float, threshold: float) -> float:
    if data > threshold:
        return data * 2
```

### 2. Try/except demasiado genérico
```python
# ❌ Malo
try:
    result = risky_operation()
except:
    return None

# ✅ Bueno
try:
    result = risky_operation()
except SpecificError as e:
    logger.error(f"Operation failed: {e}")
    return None
```

### 3. Mutable default arguments
```python
# ❌ Malo
def append_item(item, items=[]):
    items.append(item)
    return items

# ✅ Bueno
def append_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items
```

### 4. Listas/diccionarios en lugar de data classes
```python
# ❌ Malo
user = {"name": "John", "age": 30, "email": "john@example.com"}

# ✅ Bueno
from dataclasses import dataclass

@dataclass
class User:
    name: str
    age: int
    email: str
```

### 5. No usar context managers
```python
# ❌ Malo
f = open('file.txt')
data = f.read()
f.close()

# ✅ Bueno
with open('file.txt') as f:
    data = f.read()
```

---

## JavaScript/TypeScript-específicos

### 1. Callbacks anidados (Callback Hell)
```javascript
// ❌ Malo
function process(data, callback) {
  fetchData(function(err, data1) {
    if (err) callback(err);
    else {
      processData(data1, function(err, data2) {
        if (err) callback(err);
        else {
          saveData(data2, function(err) {
            callback(err);
          });
        }
      });
    }
  });
}

// ✅ Bueno
async function process(data) {
  const data1 = await fetchData();
  const data2 = await processData(data1);
  await saveData(data2);
}
```

### 2. No usar type checking (en TypeScript)
```typescript
// ❌ Malo
function calculate(a, b) {
  return a + b;
}

// ✅ Bueno
function calculate(a: number, b: number): number {
  return a + b;
}
```

### 3. Mutación de objetos
```javascript
// ❌ Malo
function updateUser(user) {
  user.name = "New Name";
  return user;
}

// ✅ Bueno
function updateUser(user) {
  return { ...user, name: "New Name" };
}
```

### 4. Falta de error handling
```javascript
// ❌ Malo
fetch('/api/data').then(r => r.json()).then(d => console.log(d));

// ✅ Bueno
fetch('/api/data')
  .then(r => {
    if (!r.ok) throw new Error(`HTTP ${r.status}`);
    return r.json();
  })
  .then(d => console.log(d))
  .catch(err => console.error(err));
```

---

## Java-específicos

### 1. Nullpointer demaferences
```java
// ❌ Malo
String name = user.getProfile().getName(); // ¿Qué si user o profile es null?

// ✅ Bueno
String name = Optional.ofNullable(user)
  .map(User::getProfile)
  .map(Profile::getName)
  .orElse("Unknown");
```

### 2. No usar Streams API
```java
// ❌ Malo
List<Integer> doubled = new ArrayList<>();
for (Integer i : numbers) {
  if (i > 0) {
    doubled.add(i * 2);
  }
}

// ✅ Bueno
List<Integer> doubled = numbers.stream()
  .filter(i -> i > 0)
  .map(i -> i * 2)
  .collect(Collectors.toList());
```

### 3. Exception handling genérico
```java
// ❌ Malo
try {
  // código
} catch (Exception e) {
  e.printStackTrace();
}

// ✅ Bueno
try {
  // código
} catch (SpecificException e) {
  logger.error("Operation failed", e);
  // handle recovery
}
```

### 4. Violación de SOLID - God Objects
Un objeto con demasiadas responsabilidades.

---

## C#/.NET-específicos

### 1. No usar LINQ
```csharp
// ❌ Malo
List<int> evens = new List<int>();
foreach (int i in numbers) {
  if (i % 2 == 0) {
    evens.Add(i);
  }
}

// ✅ Bueno
var evens = numbers.Where(i => i % 2 == 0).ToList();
```

### 2. Null checking manual
```csharp
// ❌ Malo
string value = null;
if (value != null && value.Length > 0) {
  // use value
}

// ✅ Bueno
string value = null;
if (value?.Length > 0) {
  // use value
}
```

### 3. No usar async/await
```csharp
// ❌ Malo
public void ProcessData() {
  var data = httpClient.GetStringAsync(url).Result;
}

// ✅ Bueno
public async Task ProcessData() {
  var data = await httpClient.GetStringAsync(url);
}
```

---

## Go-específicos

### 1. Ignorar errores
```go
// ❌ Malo
data, _ := ioutil.ReadFile("file.txt")

// ✅ Bueno
data, err := ioutil.ReadFile("file.txt")
if err != nil {
  log.Fatalf("Error reading file: %v", err)
}
```

### 2. No usar interfaces
```go
// ❌ Malo
func Process(data *DataStruct) {
  // ...
}

// ✅ Bueno
type DataReader interface {
  Read() ([]byte, error)
}

func Process(reader DataReader) {
  // ...
}
```

### 3. Goroutines sin sincronización
```go
// ❌ Malo
go doSomething()
// Continúa sin esperar

// ✅ Bueno
var wg sync.WaitGroup
wg.Add(1)
go func() {
  defer wg.Done()
  doSomething()
}()
wg.Wait()
```

---

## Cómo usar esta referencia

Durante el análisis de código:
1. Identifica code smells que coincidan con los patrones aquí
2. Nota la severidad (crítica, mayor, menor)
3. Proporciona el patrón problemático + solución sugerida
4. En el informe, agrupa por severidad y tipo
