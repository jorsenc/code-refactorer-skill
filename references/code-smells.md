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

## TypeScript-específicos

### 1. Generics complejos sin restricción
```typescript
// ❌ Malo
function process<T>(data: T): T {
  return data; // ¿Qué hacer con T?
}

// ✅ Bueno
function process<T extends { id: string }>(data: T): T {
  return data; // Sabemos que T tiene 'id'
}
```

### 2. Tipos any en lugar de tipado específico
```typescript
// ❌ Malo
function handleData(data: any) {
  return data.name.toUpperCase();
}

// ✅ Bueno
interface User {
  name: string;
}

function handleData(data: User) {
  return data.name.toUpperCase();
}
```

### 3. Type guards faltantes
```typescript
// ❌ Malo
function process(value: string | number) {
  console.log(value.toUpperCase()); // Error si es number
}

// ✅ Bueno
function process(value: string | number) {
  if (typeof value === 'string') {
    console.log(value.toUpperCase());
  } else {
    console.log(value.toString());
  }
}
```

### 4. Decoradores mal tipados
```typescript
// ❌ Malo
function Memoize(target: any, propertyKey: any, descriptor: any) {
  // Sin tipos específicos
}

// ✅ Bueno
function Memoize(target: Object, propertyKey: string | symbol, descriptor: PropertyDescriptor) {
  // Tipos específicos
}
```

---

## Rust-específicos

### 1. unwrap() innecesario
```rust
// ❌ Malo
let number = "42".parse::<i32>().unwrap(); // Panic si falla

// ✅ Bueno
match "42".parse::<i32>() {
    Ok(number) => println!("{}", number),
    Err(e) => eprintln!("Parse error: {}", e),
}
```

### 2. No usar Result/Option
```rust
// ❌ Malo
fn read_file() -> String {
  // ¿Qué si el archivo no existe?
  std::fs::read_to_string("file.txt").unwrap()
}

// ✅ Bueno
fn read_file() -> Result<String, std::io::Error> {
  std::fs::read_to_string("file.txt")
}
```

### 3. Borrow checker misuse
```rust
// ❌ Malo
fn process(data: &mut Vec<i32>) {
  let copy = data.clone();
  // Uso innecesario de clone
}

// ✅ Bueno
fn process(data: &Vec<i32>) {
  for item in data {
    // Usar referencias
  }
}
```

### 4. Panics innecesarios
```rust
// ❌ Malo
let items: Vec<i32> = vec![1, 2, 3];
let item = items[10]; // Panic!

// ✅ Bueno
let items: Vec<i32> = vec![1, 2, 3];
match items.get(10) {
    Some(item) => println!("{}", item),
    None => println!("Index out of bounds"),
}
```

---

## Ruby-específicos

### 1. Monkey patching
```ruby
# ❌ Malo
class String
  def my_method
    self.upcase
  end
end

# ✅ Bueno
module StringExtensions
  def my_method
    self.upcase
  end
end
String.include(StringExtensions)
```

### 2. Bloques demasiado largos
```ruby
# ❌ Malo
users.each do |user|
  # 20+ líneas de lógica
end

# ✅ Bueno
users.each { |user| process_user(user) }

def process_user(user)
  # Lógica clara en método separado
end
```

### 3. attr_accessor innecesario
```ruby
# ❌ Malo
class User
  attr_accessor :name, :email, :age, :phone, :address
  # 5 atributos públicos = demasiada exposición
end

# ✅ Bueno
class User
  attr_reader :name, :email
  attr_accessor :age # Solo lo que necesita cambiar
end
```

### 4. No usar blocks y yield
```ruby
# ❌ Malo
def process_items(items, operation)
  items.each do |item|
    if operation == :double
      puts item * 2
    elsif operation == :square
      puts item ** 2
    end
  end
end

# ✅ Bueno
def process_items(items)
  items.each { |item| yield(item) }
end

process_items([1, 2, 3]) { |i| puts i * 2 }
```

---

## Magic Strings & Constants

Complemento a "Números mágicos" - valores de string sin contexto.

```python
# ❌ Malo (Python)
if user.role == "admin":
    grant_permissions()

# ✅ Bueno
class UserRole:
    ADMIN = "admin"
    USER = "user"

if user.role == UserRole.ADMIN:
    grant_permissions()
```

```javascript
// ❌ Malo (JavaScript)
if (status === "active" || status === "pending") {
    processOrder();
}

// ✅ Bueno
const ORDER_STATUSES = {
    ACTIVE: "active",
    PENDING: "pending",
};

if ([ORDER_STATUSES.ACTIVE, ORDER_STATUSES.PENDING].includes(status)) {
    processOrder();
}
```

---

## Database Anti-patterns

### N+1 Queries
```python
# ❌ Malo (Django)
users = User.objects.all()
for user in users:
    print(user.profile.bio)  # 1 query + N queries (una por usuario)

# ✅ Bueno
users = User.objects.prefetch_related('profile').all()
for user in users:
    print(user.profile.bio)  # 1 + 1 query total
```

### SELECT * innecesario
```sql
-- ❌ Malo
SELECT * FROM users WHERE status = 'active';

-- ✅ Bueno
SELECT id, name, email FROM users WHERE status = 'active';
```

### Falta de índices
```sql
-- ❌ Malo
CREATE TABLE orders (user_id INT, amount DECIMAL);
-- Búsquedas por user_id son lentas

-- ✅ Bueno
CREATE TABLE orders (
    user_id INT,
    amount DECIMAL,
    INDEX idx_user_id (user_id)
);
```

---

## Performance Anti-patterns

### Operaciones costosas en loops
```python
# ❌ Malo
for item in items:
    result = expensive_operation()  # Se ejecuta N veces
    process(item, result)

# ✅ Bueno
result = expensive_operation()  # Una sola vez
for item in items:
    process(item, result)
```

### String concatenación en loops
```javascript
// ❌ Malo
let result = "";
for (let i = 0; i < 1000; i++) {
    result += getValue(i);  // Crea nuevo string cada iteración
}

// ✅ Bueno
const parts = [];
for (let i = 0; i < 1000; i++) {
    parts.push(getValue(i));
}
const result = parts.join("");
```

### Queries sin LIMIT
```sql
-- ❌ Malo
SELECT * FROM logs;  -- Millones de registros

-- ✅ Bueno
SELECT * FROM logs LIMIT 100;
-- O usar paginación
SELECT * FROM logs LIMIT 100 OFFSET 0;
```

---

## Cómo usar esta referencia

Durante el análisis de código:
1. Identifica code smells que coincidan con los patrones aquí
2. Nota la severidad (crítica, mayor, menor)
3. Proporciona el patrón problemático + solución sugerida
4. En el informe, agrupa por severidad y tipo
