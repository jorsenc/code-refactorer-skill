# Patrones de Diseño Avanzados

Catálogo de patrones para arquitectura, cloud-native, testing y concurrencia.

---

## Patrones Arquitectónicos

### Hexagonal Architecture (Ports & Adapters)

**Cuándo**: Cuando necesitas desacoplar tu lógica de negocio de detalles técnicos (DB, APIs).

**Beneficios**:
- ✅ Lógica independiente de frameworks
- ✅ Fácil de testear
- ✅ Intercambiar implementaciones fácilmente

**Estructura**:
```
┌─────────────────────────────────────┐
│         Application Core            │  (Lógica pura)
│     (Use cases, Entities)           │
└────────────┬────────────────────────┘
             │
    ┌────────┴────────┐
    ▼                 ▼
┌─────────┐      ┌─────────┐
│Ports    │      │Adapters │
│(Interfaces)    │(Impl.)  │
└─────────┘      └─────────┘
  │                  │
  └──► HTTP, DB, Queue, Email, etc.
```

**Antes/Después**:
```python
# ❌ Acoplado
class UserService:
    def create(self, data):
        self.db.insert('users', data)  # Acoplado a DB

# ✅ Hexagonal
class CreateUserUseCase:  # Lógica pura
    def execute(self, data: UserData) -> User:
        return User.create(data.name, data.email)

class UserRepositoryAdapter:  # Adaptador a BD
    def save(self, user: User) -> None:
        self.db.insert('users', user.to_dict())
```

---

### CQRS (Command Query Responsibility Segregation)

**Cuándo**: Cuando lectura y escritura tienen patrones muy diferentes.

**Idea**: Separar comandos (write) de queries (read) en modelos distintos.

**Beneficios**:
- ✅ Optimizar lectura y escritura por separado
- ✅ Escalabilidad independiente
- ✅ Eventos auditables

**Patrón**:
```python
# Comandos (Write)
class CreateUserCommand:
    name: str
    email: str

# Queries (Read)
class GetUserByIdQuery:
    user_id: int

# Handlers separados
class CreateUserCommandHandler:
    def handle(self, cmd: CreateUserCommand) -> User:
        user = User.create(cmd.name, cmd.email)
        self.event_bus.publish(UserCreatedEvent(user))
        return user

class GetUserByIdQueryHandler:
    def handle(self, query: GetUserByIdQuery) -> UserReadModel:
        return self.read_db.users.find_by_id(query.user_id)
```

---

### Event Sourcing

**Cuándo**: Cuando necesitas audit trail completo de cambios.

**Idea**: No guardar estado actual, guardar secuencia de eventos.

**Beneficios**:
- ✅ Auditoría completa
- ✅ Reproducir estados anteriores
- ✅ Debugging más fácil

---

### Repository Pattern

**Cuándo**: Cuando necesitas abstraer acceso a datos.

```python
# ✅ Bueno
class UserRepository:
    def find_by_id(self, id: int) -> User:
        pass
    
    def find_by_email(self, email: str) -> User:
        pass
    
    def save(self, user: User) -> None:
        pass

class UserRepositorySQL(UserRepository):
    # Implementación con SQL

class UserRepositoryMongo(UserRepository):
    # Implementación con MongoDB
```

---

### Service Locator (Anti-Pattern ⚠️)

**No usar**, usa Dependency Injection en su lugar.

```python
# ❌ Service Locator (malo)
class UserService:
    def __init__(self):
        self.db = ServiceLocator.get('database')

# ✅ Dependency Injection (bueno)
class UserService:
    def __init__(self, db: Database):
        self.db = db
```

---

## Cloud-Native & Resilience Patterns

### Circuit Breaker

**Cuándo**: Cuando llamas a servicios externos que pueden fallar.

**Idea**: 3 estados (Closed → Open → Half-Open → Closed)

```python
class CircuitBreaker:
    def __init__(self, failure_threshold=5, timeout=60):
        self.failure_threshold = failure_threshold
        self.timeout = timeout
        self.failures = 0
        self.last_failure_time = None
        self.state = 'closed'  # closed, open, half-open
    
    def call(self, func, *args):
        if self.state == 'open':
            if time.time() - self.last_failure_time > self.timeout:
                self.state = 'half-open'
            else:
                raise CircuitBreakerOpenException()
        
        try:
            result = func(*args)
            if self.state == 'half-open':
                self.state = 'closed'
                self.failures = 0
            return result
        except Exception as e:
            self.failures += 1
            self.last_failure_time = time.time()
            if self.failures >= self.failure_threshold:
                self.state = 'open'
            raise
```

### Retry Pattern

**Cuándo**: Para fallos transitorios (timeouts, connection drops).

```python
def retry(max_attempts=3, backoff_factor=2, exceptions=(Exception,)):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            attempt = 0
            wait_time = 1
            while attempt < max_attempts:
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    attempt += 1
                    if attempt >= max_attempts:
                        raise
                    time.sleep(wait_time)
                    wait_time *= backoff_factor
        return wrapper
    return decorator

@retry(max_attempts=3, backoff_factor=2)
def call_external_api():
    response = requests.get('https://api.example.com/data')
    response.raise_for_status()
    return response.json()
```

### Rate Limiting & Throttling

**Cuándo**: Proteger sistemas de sobrecarga.

```python
class RateLimiter:
    def __init__(self, max_requests=100, window_seconds=60):
        self.max_requests = max_requests
        self.window_seconds = window_seconds
        self.requests = []
    
    def is_allowed(self):
        now = time.time()
        # Remove old requests
        self.requests = [t for t in self.requests if t > now - self.window_seconds]
        
        if len(self.requests) < self.max_requests:
            self.requests.append(now)
            return True
        return False
```

### Bulkhead Pattern

**Idea**: Aislar recursos para evitar que fallos en cascada.

```python
# Diferentes thread pools para diferentes operaciones
import concurrent.futures

user_service_pool = concurrent.futures.ThreadPoolExecutor(max_workers=10)
order_service_pool = concurrent.futures.ThreadPoolExecutor(max_workers=20)

# Fallos en user_service no afectan order_service
```

### Health Checks

**Cuándo**: Para load balancers y orchestrators.

```python
@app.get('/health')
def health_check():
    checks = {
        'database': check_database(),
        'cache': check_redis(),
        'external_api': check_external_api(),
    }
    status = 'healthy' if all(checks.values()) else 'unhealthy'
    return {'status': status, 'checks': checks}
```

---

## Testing Patterns

### Mock Object

**Cuándo**: Reemplazar dependencia real con fake para testing.

```python
# ❌ Sin Mock (acoplado a DB real)
def test_create_user():
    service = UserService(RealDatabase())
    result = service.create_user('John')

# ✅ Con Mock
class MockUserRepository:
    def __init__(self):
        self.saved = []
    
    def save(self, user):
        self.saved.append(user)

def test_create_user():
    repo = MockUserRepository()
    service = UserService(repo)
    service.create_user('John')
    assert len(repo.saved) == 1
```

### Test Stub

**Diferencia con Mock**: Stub provee respuestas canned, Mock verifica comportamiento.

```python
class StubUserRepository:
    def find_by_id(self, id):
        return User(id=1, name='John', email='john@example.com')

def test_get_user():
    service = UserService(StubUserRepository())
    user = service.get_user(1)
    assert user.name == 'John'
```

### Test Spy

**Idea**: Wrappear servicio real para espiar su comportamiento.

```python
class SpyEmailService:
    def __init__(self, real_service):
        self.real_service = real_service
        self.emails_sent = []
    
    def send(self, to, subject, body):
        self.emails_sent.append({'to': to, 'subject': subject})
        return self.real_service.send(to, subject, body)
```

### Test Fixture

**Idea**: Datos de prueba reutilizables.

```python
@pytest.fixture
def user_fixture():
    return User(id=1, name='John', email='john@example.com')

def test_user_email(user_fixture):
    assert user_fixture.email == 'john@example.com'
```

### Test Data Builder

**Cuándo**: Construir objetos complejos para tests.

```python
class UserBuilder:
    def __init__(self):
        self.data = {
            'name': 'John',
            'email': 'john@example.com',
            'age': 30,
        }
    
    def with_name(self, name):
        self.data['name'] = name
        return self
    
    def with_email(self, email):
        self.data['email'] = email
        return self
    
    def build(self):
        return User(**self.data)

# Uso
user = UserBuilder().with_email('admin@example.com').build()
```

### Page Object Model

**Cuándo**: Tests de UI.

```python
class LoginPage:
    def __init__(self, driver):
        self.driver = driver
    
    def enter_email(self, email):
        self.driver.find_element("email").send_keys(email)
        return self
    
    def enter_password(self, password):
        self.driver.find_element("password").send_keys(password)
        return self
    
    def click_login(self):
        self.driver.find_element("login_btn").click()
        return self

# Test
def test_login():
    page = LoginPage(driver)
    page.enter_email('user@example.com').enter_password('pass').click_login()
```

---

## Concurrency & Async Patterns

### Future/Promise Pattern

**Cuándo**: Operaciones asincrónicas.

```javascript
// Promise (JavaScript)
fetch('/api/user')
  .then(r => r.json())
  .then(data => console.log(data))
  .catch(err => console.error(err));

// Async/Await (mejor)
async function getUser() {
  try {
    const response = await fetch('/api/user');
    const data = await response.json();
    console.log(data);
  } catch (err) {
    console.error(err);
  }
}
```

### Actor Model

**Cuándo**: Concurrencia con estado aislado.

```python
# Usando framework como Pykka o Akka
class UserActor(pykka.ThreadingActor):
    def __init__(self):
        super().__init__()
        self.data = {}
    
    def create_user(self, user_id, name):
        self.data[user_id] = name
        return f"User {user_id} created"

# Uso
actor = UserActor.start()
result = actor.ask({'action': 'create_user', 'id': 1, 'name': 'John'})
```

### Coroutines

**Cuándo**: Async code en Python.

```python
async def fetch_user(user_id):
    # Operación async
    response = await http_client.get(f'/api/users/{user_id}')
    return response.json()

async def main():
    # Ejecutar múltiples coroutines en paralelo
    users = await asyncio.gather(
        fetch_user(1),
        fetch_user(2),
        fetch_user(3),
    )
    return users
```

---

## Integration Patterns

### API Gateway

**Cuándo**: Sistema de microservicios.

```python
# API Gateway
@app.route('/api/*')
def route_request(path):
    if path.startswith('/users'):
        return proxy_to('user-service', path)
    elif path.startswith('/orders'):
        return proxy_to('order-service', path)
    else:
        return 404
```

### Saga Pattern

**Cuándo**: Transacciones distribuidas.

```python
# Orquestador de saga
class OrderSaga:
    async def execute(self, order):
        # Paso 1: Reservar inventario
        inventory_reserved = await self.inventory_service.reserve(order.items)
        
        try:
            # Paso 2: Procesar pago
            payment_done = await self.payment_service.charge(order.total)
            
            if not payment_done:
                raise PaymentFailedException()
            
            # Paso 3: Enviar orden
            return await self.shipping_service.ship(order)
        
        except Exception:
            # Compensación: liberar inventario
            await self.inventory_service.release(inventory_reserved)
            raise
```

### Event-Driven Architecture

**Cuándo**: Sistemas loosely coupled.

```python
# Publisher
class UserService:
    def create_user(self, data):
        user = User.create(data)
        self.event_bus.publish(UserCreatedEvent(user))
        return user

# Subscribers (independientes)
class EmailService:
    @subscribe(UserCreatedEvent)
    def on_user_created(self, event):
        send_welcome_email(event.user.email)

class NotificationService:
    @subscribe(UserCreatedEvent)
    def on_user_created(self, event):
        send_notification(f"New user: {event.user.name}")
```

---

## Cómo usar esta referencia

- **Durante análisis**: Identifica patrones faltantes o mal aplicados
- **Durante refactorización**: Propone patrones apropiados para el contexto
- **En diseño**: Elige patrones para nueva arquitectura
- **En review**: Sugiere patrones cuando detectas problemas

---

**Última actualización**: 2026-06-19  
**Versión**: 1.0 (Advanced Patterns)
