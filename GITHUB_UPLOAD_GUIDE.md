# 📤 Guía para subir a GitHub

Instrucciones paso a paso para subir la skill a GitHub.

## 🎯 Requisitos previos

- Cuenta en GitHub ([https://github.com](https://github.com))
- Git instalado en tu máquina
- Terminal/Command Prompt

## 📋 Pasos

### 1. Crear repositorio en GitHub

1. Ve a [https://github.com/new](https://github.com/new)
2. **Repository name**: `code-refactorer-skill`
3. **Description**: "A Claude skill for automated code refactoring and analysis"
4. **Visibility**: Público (✓ Public) - para que otros lo puedan encontrar
5. **Initialize with**:
   - ❌ No selecciones README (ya tenemos uno)
   - ❌ No selecciones .gitignore (ya tenemos uno)
   - ❌ No selecciones License (ya tenemos MIT license)
6. Click **Create repository**

### 2. Preparar tu máquina

En tu terminal:

```bash
# Navega a la carpeta del proyecto
cd /ruta/a/code-refactorer-skill

# Inicializa git (si no está inicializado)
git init

# Configura tu nombre y email (si es primera vez)
git config user.name "Tu Nombre"
git config user.email "tu.email@ejemplo.com"
```

### 3. Agregar todos los archivos

```bash
# Agrega todos los archivos
git add .

# Verifica qué se va a subir
git status

# Debería mostrar (en verde):
# - SKILL.md
# - references/
# - scripts/
# - test-cases.json
# - .gitignore
# - LICENSE
# - CONTRIBUTING.md
# - .github/workflows/
# etc.
```

### 4. Primer commit

```bash
git commit -m "Initial commit: Code Refactorer Skill v1.0"
```

### 5. Conectar con GitHub

Reemplaza `TU_USUARIO` con tu nombre de usuario de GitHub:

```bash
# Agrega la URL del repositorio remoto
git remote add origin https://github.com/TU_USUARIO/code-refactorer-skill.git

# Verifica que se agregó correctamente
git remote -v
```

### 6. Subir a GitHub

```bash
# Sube a la rama main
git branch -M main
git push -u origin main
```

Te pedirá autenticación. Puedes usar:
- **Token de acceso personal** (recomendado)
- **SSH key** (alternativa)
- **Usuario y contraseña** (menos seguro)

#### Opción A: Token de acceso (recomendado)

1. Ve a [https://github.com/settings/tokens](https://github.com/settings/tokens)
2. Click **Generate new token** → **Generate new token (classic)**
3. Name: `github-cli-token`
4. Selecciona estos scopes:
   - ✓ repo (full control)
   - ✓ workflow (update GitHub Actions)
5. Click **Generate token**
6. Copia el token
7. En la terminal, cuando pida contraseña, pega el token

#### Opción B: SSH Key

Si ya tienes SSH configurado:
```bash
# Usa SSH en lugar de HTTPS
git remote set-url origin git@github.com:TU_USUARIO/code-refactorer-skill.git
git push -u origin main
```

## ✅ Verificar

En GitHub, deberías ver:

✅ Archivos subidos correctamente  
✅ Workflow de validación ejecutándose (check en Actions)  
✅ README.md mostrándose en la página principal  
✅ LICENSE visible  

## 📝 Actualizar después de cambios

Cuando hagas cambios:

```bash
# Ve a la carpeta del proyecto
cd /ruta/a/code-refactorer-skill

# Agrega cambios
git add .

# Commit
git commit -m "Descripción del cambio"

# Push
git push origin main
```

## 🌿 Trabajo con ramas (opcional)

Para cambios mayores, usa ramas:

```bash
# Crea una rama
git checkout -b feature/new-feature

# Haz cambios, commits...
git add .
git commit -m "Add new feature"

# Push a la rama
git push origin feature/new-feature

# En GitHub, abre Pull Request (PR)
# Después que se apruebe, merge a main
```

## 📤 Actualizar README

Reemplaza `TU_USUARIO` en `README_GITHUB.md`:

```bash
# En tu carpeta local
sed -i 's/TU_USUARIO/tu_usuario_github/g' README_GITHUB.md

# O manualmente:
# - Reemplaza TU_USUARIO con tu usuario de GitHub
# - Renombra README_GITHUB.md a README.md
```

## 🔒 Proteger rama main (opcional)

En GitHub:

1. Ve a **Settings** → **Branches**
2. Haz click en **Add rule**
3. Branch name pattern: `main`
4. Habilita:
   - ✓ Require a pull request before merging
   - ✓ Require status checks to pass
5. Save

## 🔄 GitHub Actions

El workflow se ejecutará automáticamente:

1. Cada vez que hagas push a `main` o `develop`
2. Cada vez que abras un Pull Request

Para ver resultados:
- Ve a **Actions** en tu repositorio
- Verás validación automática

## 📊 Badge para README

Agrega este badge al inicio de README.md:

```markdown
[![Validate Skill](https://github.com/TU_USUARIO/code-refactorer-skill/workflows/Validate%20Skill/badge.svg)](https://github.com/TU_USUARIO/code-refactorer-skill/actions)
```

## 🎯 Próximos pasos opcionales

1. **Agregar Topics** (en Settings):
   - claude
   - skill
   - refactoring
   - code-quality
   - ai

2. **Habilitar Discussions**:
   - Ve a Settings
   - Habilita Discussions

3. **Crear primeras releases**:
   - Ve a Releases
   - Create new release
   - Tag: v1.0.0
   - Title: Version 1.0.0

## 🐛 Troubleshooting

### Error: "fatal: not a git repository"
```bash
git init  # Reinicia el repositorio
```

### Error: "Permission denied (publickey)"
Debes configurar SSH o usar token de acceso

### Error: "Please tell me who you are"
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### El workflow no se ejecuta
- Verifica que `.github/workflows/validate.yml` existe
- Verifica que el YAML es válido

## ✨ ¡Listo!

Tu skill está ahora en GitHub y accesible para:
- ✅ Compartir con otros
- ✅ Recibir contribuciones
- ✅ Validación automática
- ✅ Historial de cambios
- ✅ Control de versiones

---

**Tips finales:**

- Haz commits pequeños y frecuentes
- Usa mensajes descriptivos en los commits
- Revisa que `git status` está limpio antes de terminar
- Mantén la rama main siempre funcional

¡Que disfrutes! 🚀
