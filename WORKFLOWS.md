# Workflows: Guías de Uso por Caso

Paso a paso para los casos de uso más comunes de la Code Refactorer Skill.

---

## Workflow 1: Refactoring de Código Heredado

**Situación**: Proyecto viejo, sin tests, baja mantenibilidad.  
**Objetivo**: Mejorar gradualmente sin romper nada.

### Paso 1: Evaluar el baseline

```bash
# Obtener métricas iniciales
python3 -m claude.skills.code_refactorer . \
  --metrics-only \
  > baseline_metrics.json
```

**Métricas clave a registrar**:
- Cyclomatic Complexity promedio
- Maintainability Index
- Duplication %
- Lines of Code

### Paso 2: Priorizar archivos

Enfócate en:
1. Archivos más acoplados (más dependencias)
2. Métodos con CC > 10
3. Archivos con duplicación > 10%

```python
# Priorización recomendada
files_to_refactor = [
    'src/user_manager.py',  # CC=15, MI=45, Dup=12%
    'src/order_processor.py',  # CC=12, MI=52, Dup=8%
    'src/payment_handler.py',  # CC=8, MI=60, Dup=5%
]
```

### Paso 3: Refactorizar incremental

Para cada archivo:

1. **Ejecutar análisis detallado**:
```bash
python3 -m claude.skills.code_refactorer src/user_manager.py \
  --mode detailed \
  --output json \
  > analysis.json
```

2. **Revisar propuestas**: Leer `analysis.json`, validar que tiene sentido

3. **Implementar cambios**: Refactorizar siguiendo propuestas

4. **Tests**: Ejecutar suite de tests
```bash
pytest tests/ -v
```

5. **Verificar mejora**:
```bash
python3 -m claude.skills.code_refactorer src/user_manager.py \
  --metrics-only \
  > new_metrics.json
# Comparar con baseline
```

### Paso 4: Iterar

Repetir Paso 3 para cada archivo prioritario.

### Paso 5: Medir impacto final

```python
# Comparar antes vs después
baseline = load_json('baseline_metrics.json')
final = load_json('final_metrics.json')

improvement = {
    'cc_reduction': (baseline['cc'] - final['cc']) / baseline['cc'] * 100,
    'mi_improvement': (final['mi'] - baseline['mi']) / baseline['mi'] * 100,
    'dup_reduction': (baseline['dup'] - final['dup']) / baseline['dup'] * 100,
}

print(f"CC improved by {improvement['cc_reduction']:.1f}%")
print(f"MI improved by {improvement['mi_improvement']:.1f}%")
print(f"Duplication reduced by {improvement['dup_reduction']:.1f}%")
```

---

## Workflow 2: Preparar Código para Testing

**Situación**: Código sin tests, alta complejidad.  
**Objetivo**: Refactorizar para testability.

### Paso 1: Identificar barreras para testing

Ejecutar skill con modo "testing-focused":

```bash
python3 -m claude.skills.code_refactorer . \
  --focus testing \
  > testing_analysis.json
```

**Problemas típicos**:
- Acoplamiento tight con BD/APIs
- Métodos demasiado largos
- Lógica y side effects mixtos
- Inyección de dependencias ausente

### Paso 2: Aplicar patrones de testabilidad

Por cada archivo:

**2a. Extraer lógica pura**
```python
# ❌ Antes (acoplado)
class UserService:
    def create_user(self, name, email):
        # Validar
        # Guardar en BD
        # Enviar email
        pass

# ✅ Después (separado)
class UserValidator:
    def validate(self, name, email) -> bool:
        # Lógica pura, fácil de testear

class UserRepository:
    def save(self, user) -> None:
        # Solo guarda

class UserService:
    def __init__(self, validator, repository, email_service):
        self.validator = validator
        self.repository = repository
        self.email = email_service
    
    def create_user(self, name, email):
        if self.validator.validate(name, email):
            user = User(name, email)
            self.repository.save(user)
            self.email.send_welcome(user)
```

**2b. Inyectar dependencias**
```python
# ❌ Antes (hardcoded)
def create_user(name):
    db = Database()  # Acoplado
    return db.insert(name)

# ✅ Después (inyectado)
def create_user(name, db: Database):
    return db.insert(name)
```

### Paso 3: Escribir tests

Para cada método refactorizado:

```python
# Test de lógica pura (sin dependencias)
def test_validate_email():
    validator = UserValidator()
    assert validator.validate('valid@email.com') == True
    assert validator.validate('invalid') == False

# Test con mocks
def test_create_user():
    mock_repo = MockRepository()
    mock_email = MockEmailService()
    service = UserService(UserValidator(), mock_repo, mock_email)
    
    service.create_user('John', 'john@example.com')
    
    assert len(mock_repo.saved) == 1
    assert mock_email.emails_sent == ['john@example.com']
```

### Paso 4: Verificar cobertura

```bash
pytest tests/ --cov=src/ --cov-report=html
```

Objetivo: >80% cobertura en código crítico.

---

## Workflow 3: Optimización de Rendimiento

**Situación**: Código funcional pero lento.  
**Objetivo**: Identificar y optimizar hotspots.

### Paso 1: Perfilar el código

```bash
# Identificar métodos lentos
python3 -m cProfile -s cumulative app.py > profile.txt
head -20 profile.txt
```

### Paso 2: Analizar con la skill

```bash
python3 -m claude.skills.code_refactorer . \
  --focus performance \
  > perf_analysis.json
```

**Problemas típicos**:
- N+1 queries
- String concatenation en loops
- Computaciones innecesarias
- Falta de caching

### Paso 3: Refactorizar puntos calientes

**Ejemplo: N+1 queries**
```python
# ❌ Antes (N+1)
users = User.objects.all()
for user in users:
    print(user.profile.bio)  # 1 + N queries

# ✅ Después (optimizado)
users = User.objects.prefetch_related('profile').all()
for user in users:
    print(user.profile.bio)  # 2 queries total
```

### Paso 4: Medir mejora

```bash
# Antes
time python3 app.py

# Después
time python3 app.py

# Esperar reducción >20%
```

---

## Workflow 4: Aplicar SOLID Principles

**Situación**: Código viola SOLID, difícil de cambiar.  
**Objetivo**: Aplicar principios de forma incremental.

### Paso 1: Diagnosticar violaciones

```bash
python3 -m claude.skills.code_refactorer . \
  --focus solid \
  > solid_report.json
```

**Prioridad de aplicación**:
1. **SRP** (Single Responsibility): Separar responsabilidades
2. **OCP** (Open/Closed): Extender sin modificar
3. **LSP** (Liskov Substitution): Herencia correcta
4. **ISP** (Interface Segregation): Interfaces específicas
5. **DIP** (Dependency Inversion): Depender de abstracciones

### Paso 2: Aplicar SRP (Single Responsibility)

**Identificar**: Clases con múltiples razones para cambiar.

```python
# ❌ Antes (God Object)
class User:
    def create(self, data):  # Responsabilidad 1: crear
        pass
    
    def validate(self, email):  # Responsabilidad 2: validar
        pass
    
    def send_email(self, to):  # Responsabilidad 3: comunicar
        pass
    
    def log(self, message):  # Responsabilidad 4: loguear
        pass

# ✅ Después (SRP)
class User:
    def create(self, data): pass

class UserValidator:
    def validate(self, email): pass

class UserNotifier:
    def send_email(self, to): pass

class Logger:
    def log(self, message): pass
```

### Paso 3: Aplicar OCP (Open/Closed)

Extender sin modificar.

```python
# ❌ Antes (cerrado para extensión)
class DiscountCalculator:
    def calculate(self, user_type):
        if user_type == 'premium':
            return 0.2
        elif user_type == 'member':
            return 0.1
        else:
            return 0

# ✅ Después (abierto para extensión)
class DiscountStrategy:
    def calculate(self): pass

class PremiumDiscount(DiscountStrategy):
    def calculate(self): return 0.2

class MemberDiscount(DiscountStrategy):
    def calculate(self): return 0.1

class DiscountCalculator:
    def calculate(self, strategy: DiscountStrategy):
        return strategy.calculate()
```

### Paso 4: Verificar mejora

Después de aplicar SOLID:
- Métodos deberían ser <20 líneas
- Clases deberían tener 1 razón para cambiar
- Dependencias inyectadas
- Fácil de testear

---

## Workflow 5: Migración de Async Patterns

**Situación**: Callbacks o Promises anidadas, difícil de leer.  
**Objetivo**: Modernizar a async/await.

### Paso 1: Identificar async code

```bash
python3 -m claude.skills.code_refactorer . \
  --focus async \
  > async_analysis.json
```

**Antipatrones**:
- Callback Hell
- Promise chains profundas
- Falta de error handling
- Race conditions

### Paso 2: Migración secuencial

**Archivo por archivo**, de menos a más crítico.

### Paso 3: Refactorizar

**JavaScript/TypeScript**:
```javascript
// ❌ Antes (Callback Hell)
function processData(url, callback) {
  fetch(url)
    .then(r => r.json())
    .then(data => {
      transform(data, (err, transformed) => {
        if (err) callback(err);
        else {
          save(transformed, (err, result) => {
            if (err) callback(err);
            else callback(null, result);
          });
        }
      });
    })
    .catch(err => callback(err));
}

// ✅ Después (async/await)
async function processData(url) {
  try {
    const response = await fetch(url);
    const data = await response.json();
    const transformed = await transform(data);
    return await save(transformed);
  } catch (err) {
    console.error(err);
    throw err;
  }
}
```

**Python**:
```python
# ❌ Antes (callbacks)
def process(data, callback):
    def on_transform(transformed):
        def on_save(result):
            callback(result)
        save(transformed, on_save)
    transform(data, on_transform)

# ✅ Después (async/await)
async def process(data):
    transformed = await transform(data)
    result = await save(transformed)
    return result

# Uso
result = await process(data)
```

### Paso 4: Error handling centralizado

```javascript
// ✅ Bueno
async function main() {
    try {
        const user = await fetchUser(1);
        const profile = await fetchProfile(user.id);
        const posts = await fetchPosts(profile.id);
        return { user, profile, posts };
    } catch (err) {
        console.error('Pipeline failed:', err);
        return null;
    }
}
```

### Paso 5: Tests

Verify async behavior:

```python
import pytest

@pytest.mark.asyncio
async def test_process():
    result = await process(test_data)
    assert result is not None
    assert result['user_id'] == 1
```

---

## Workflow General: Checklist Pre-Merge

Antes de hacer merge a main:

- [ ] Ejecutar skill: `python3 -m claude.skills.code_refactorer . --mode detailed`
- [ ] Revisar propuestas
- [ ] Implementar refactorizaciones
- [ ] Ejecutar tests: `pytest tests/ -v --cov=src/`
- [ ] Verificar cobertura: >80%
- [ ] Validar métricas mejoraron
- [ ] Code review del equipo
- [ ] Pre-commit hook pasa
- [ ] CI/CD pasa

---

**Última actualización**: 2026-06-19  
**Versión**: 1.0 (Workflows)
