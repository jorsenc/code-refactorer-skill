# Patrones de Diseño para Refactorización

Patrones aplicables durante refactorización y cuándo usarlos.

## Patrones Creacionales

### Singleton
**Cuándo**: Necesitas una única instancia global
**Ejemplo**: Logger, Database connection pool
**Ventajas**: Control centralizado, acceso global
**Cuidado**: Puede dificultar testing, acoplamiento global

```python
# Implementación segura en Python
class Singleton(type):
    _instances = {}
    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super().__call__(*args, **kwargs)
        return cls._instances[cls]

class Logger(metaclass=Singleton):
    pass
```

### Factory Pattern
**Cuándo**: Creación compleja de objetos, múltiples subtipos
**Ejemplo**: Crear diferentes tipos de conexiones (MySQL, PostgreSQL, SQLite)
**Ventajas**: Desacopla creación, fácil de extender
**Cuándo aplicar**: Cuando tienes múltiples constructores condicionales

```python
# ❌ Mal (condicionales esparcidas)
if db_type == "mysql":
    db = MySQLDatabase()
elif db_type == "postgres":
    db = PostgresDatabase()

# ✅ Bien (Factory)
class DatabaseFactory:
    @staticmethod
    def create(db_type):
        mapping = {
            "mysql": MySQLDatabase,
            "postgres": PostgresDatabase,
        }
        return mapping[db_type]()

db = DatabaseFactory.create(db_type)
```

### Builder Pattern
**Cuándo**: Objetos complejos con muchos parámetros opcionales
**Ejemplo**: Configuración, requests HTTP
**Ventajas**: Interfaz clara, valida mientras construye
**Cuándo aplicar**: Funciones con >4-5 parámetros opcionales

```python
# ❌ Mal (demasiados parámetros)
def create_user(name, email, age=None, phone=None, address=None, verified=False):
    pass

# ✅ Bien (Builder)
class UserBuilder:
    def __init__(self):
        self.user = {}
    
    def set_name(self, name):
        self.user['name'] = name
        return self
    
    def set_email(self, email):
        self.user['email'] = email
        return self
    
    def build(self):
        return User(**self.user)

user = UserBuilder().set_name("John").set_email("john@example.com").build()
```

---

## Patrones Estructurales

### Decorator Pattern
**Cuándo**: Agregar funcionalidad dinámicamente a objetos
**Ejemplo**: Logging, caching, validación
**Ventajas**: Flexible, composable
**Cuándo aplicar**: Cuando tienes "sub-clases de sub-clases"

```python
# ❌ Mal (explosión de clases)
class CachedValidatedLoggedFunction:
    pass

# ✅ Bien (Decorators)
@cache
@validate_input
@log_execution
def expensive_operation(data):
    return result

# O manualmente
def expensive_operation_cached(data):
    @cache
    def _wrapped(data):
        return expensive_operation(data)
    return _wrapped(data)
```

### Adapter Pattern
**Cuándo**: Hacer compatible interfaces incompatibles
**Ejemplo**: Wrapper para bibliotecas legacy, adaptadores de BD
**Ventajas**: Aísla cambios, reutiliza código existente
**Cuándo aplicar**: Cuando integras código third-party

```python
# ❌ Acoplamiento directo
def process(legacy_system):
    data = legacy_system.get_info()  # Retorna tupla
    return data[0], data[1]  # Formato extraño

# ✅ Adapter
class LegacySystemAdapter:
    def __init__(self, legacy_system):
        self.legacy = legacy_system
    
    def get_data(self):
        raw = self.legacy.get_info()
        return {"id": raw[0], "value": raw[1]}

def process(adapter):
    data = adapter.get_data()  # Interface limpia
    return data
```

### Proxy Pattern
**Cuándo**: Control de acceso, lazy loading, logging
**Ejemplo**: Acceso a BD, servicios remotos
**Ventajas**: Transparente, control centralizado
**Cuándo aplicar**: Recursos costosos o acceso controlado

```python
# Proxy para lazy loading
class ExpensiveResourceProxy:
    def __init__(self, resource_loader):
        self.resource = None
        self.loader = resource_loader
    
    def get_data(self):
        if self.resource is None:
            self.resource = self.loader()  # Se carga solo cuando se necesita
        return self.resource.data
```

---

## Patrones de Comportamiento

### Strategy Pattern
**Cuándo**: Múltiples algoritmos intercambiables
**Ejemplo**: Diferentes métodos de pago, ordenamiento
**Ventajas**: Encapsula algoritmos, fácil cambiar
**Cuándo aplicar**: Bloques if/else grandes basados en tipo

```python
# ❌ Mal (condicionales basadas en tipo)
def process_payment(amount, payment_type):
    if payment_type == "credit_card":
        # validar tarjeta
        # procesar
    elif payment_type == "paypal":
        # validar paypal
        # procesar
    elif payment_type == "crypto":
        # validar blockchain
        # procesar

# ✅ Bien (Strategy)
class PaymentStrategy:
    def validate(self): pass
    def process(self, amount): pass

class CreditCardStrategy(PaymentStrategy):
    def validate(self): pass
    def process(self, amount): pass

class PaymentProcessor:
    def __init__(self, strategy: PaymentStrategy):
        self.strategy = strategy
    
    def process_payment(self, amount):
        self.strategy.validate()
        return self.strategy.process(amount)

processor = PaymentProcessor(CreditCardStrategy())
processor.process_payment(100)
```

### Observer Pattern
**Cuándo**: Notificaciones de cambios de estado
**Ejemplo**: Event listeners, publish/subscribe
**Ventajas**: Desacoplamiento, reactividad
**Cuándo aplicar**: Cuando múltiples partes reaccionan a eventos

```python
# Usar built-in properties/signals
class Subject:
    def __init__(self):
        self._observers = []
        self._state = None
    
    def attach(self, observer):
        self._observers.append(observer)
    
    @property
    def state(self):
        return self._state
    
    @state.setter
    def state(self, value):
        self._state = value
        for observer in self._observers:
            observer.update(value)
```

### Template Method Pattern
**Cuándo**: Algoritmo con pasos fijos, variantes en detalles
**Ejemplo**: Procesamiento de archivos (CSV, JSON, XML)
**Ventajas**: Reutiliza lógica común, evita duplicación
**Cuándo aplicar**: Clases similares con lógica parcialmente duplicada

```python
# ❌ Mal (código duplicado)
class CSVProcessor:
    def process(self):
        self.open_file()
        self.parse_csv()
        self.validate()
        self.save()

class JSONProcessor:
    def process(self):
        self.open_file()
        self.parse_json()
        self.validate()
        self.save()

# ✅ Bien (Template Method)
class FileProcessor:
    def process(self):
        self.open_file()
        self.parse()
        self.validate()
        self.save()
    
    def parse(self):
        raise NotImplementedError

class CSVProcessor(FileProcessor):
    def parse(self):
        # CSV-specific parsing

class JSONProcessor(FileProcessor):
    def parse(self):
        # JSON-specific parsing
```

### Command Pattern
**Cuándo**: Encapsular solicitudes, undo/redo, colas
**Ejemplo**: Undo/Redo, task queues, macros
**Ventajas**: Desacopla invocador de ejecutor
**Cuándo aplicar**: Cuando necesitas deshacer, rehacer, o encolar operaciones

```python
class Command:
    def execute(self): pass
    def undo(self): pass

class SaveCommand(Command):
    def __init__(self, document):
        self.document = document
        self.original_state = None
    
    def execute(self):
        self.original_state = self.document.content
        self.document.save()
    
    def undo(self):
        self.document.content = self.original_state

class CommandHistory:
    def __init__(self):
        self.history = []
    
    def execute(self, command):
        command.execute()
        self.history.append(command)
    
    def undo(self):
        if self.history:
            self.history.pop().undo()
```

---

## Patrones SOLID

### Single Responsibility Principle (SRP)
**Qué arregla**: Clases con múltiples razones para cambiar
**Cómo**: Divide en clases más pequeñas, cada una con una responsabilidad

### Open/Closed Principle (OCP)
**Qué arregla**: Necesidad de modificar código existente para nuevas características
**Cómo**: Usa herencia/interfaces, permite extensión sin modificación

### Liskov Substitution Principle (LSP)
**Qué arregla**: Subclases que rompen contrato de la clase base
**Cómo**: Asegura que subclases pueden usarse donde se espera la clase base

### Interface Segregation Principle (ISP)
**Qué arregla**: Interfaces gruesas con muchos métodos
**Cómo**: Divide en interfaces más pequeñas y específicas

```python
# ❌ Mal (Interface gorda)
class Worker:
    def work(self): pass
    def eat(self): pass
    def sleep(self): pass

# ✅ Bien (ISP)
class Workable:
    def work(self): pass

class Eatable:
    def eat(self): pass

class Sleepable:
    def sleep(self): pass

class Robot(Workable):
    pass  # No necesita eat() ni sleep()

class Human(Workable, Eatable, Sleepable):
    pass
```

### Dependency Inversion Principle (DIP)
**Qué arregla**: Dependencias en implementaciones concretas
**Cómo**: Depende de abstracciones, inyecta dependencias

```python
# ❌ Mal (acoplado)
class UserService:
    def __init__(self):
        self.db = MySQLDatabase()  # Acoplado a MySQL

# ✅ Bien (inyección)
class UserService:
    def __init__(self, database: Database):
        self.db = database  # Puede ser cualquier Database

service = UserService(MySQLDatabase())
# O en tests:
service = UserService(MockDatabase())
```

---

## Cómo usar esta referencia durante refactorización

1. **Identifica el patrón problemático**: ¿Qué estructura/patrón está ausente?
2. **Proporciona el patrón sugerido**: ¿Cuál aplicarías?
3. **Muestra el antes/después**: Cómo se vería la refactorización
4. **Estima el impacto**: ¿Cuánto mejora mantenibilidad/extensibilidad?
5. **Evalúa el costo**: ¿Vale la pena el esfuerzo?
