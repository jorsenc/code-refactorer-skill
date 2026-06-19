#!/bin/bash
# Script Bash para subir Code Refactorer Skill a GitHub
# Uso: bash upload-to-github.sh

set -e  # Salir si hay error

echo "╔══════════════════════════════════════════════════════════╗"
echo "║  Code Refactorer Skill - GitHub Upload Script           ║"
echo "║  Este script sube automáticamente tu skill a GitHub     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ============================================
# CONFIGURACIÓN - CAMBIAR ESTOS VALORES
# ============================================

read -p "💻 Ingresa tu usuario de GitHub: " GITHUB_USERNAME
read -p "📧 Ingresa tu email de GitHub: " GITHUB_EMAIL
read -sp "🔑 Ingresa tu token de GitHub (o presiona Enter para usar SSH): " GITHUB_TOKEN
echo ""
REPO_NAME="code-refactorer-skill"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  CONFIGURACIÓN DETECTADA                                ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo "👤 Usuario: $GITHUB_USERNAME"
echo "📧 Email: $GITHUB_EMAIL"
echo "📁 Repositorio: $REPO_NAME"
echo ""

read -p "¿Es correcto? (s/n): " confirm
if [ "$confirm" != "s" ]; then
    echo "❌ Cancelado por el usuario"
    exit 1
fi

echo ""

# ============================================
# PASO 1: VERIFICAR REQUISITOS
# ============================================

echo "1️⃣  VERIFICANDO REQUISITOS..."
echo ""

# Verificar Git
if ! command -v git &> /dev/null; then
    echo "❌ Git NO está instalado"
    echo "   En Ubuntu/Debian: sudo apt-get install git"
    echo "   En macOS: brew install git"
    exit 1
fi

git_version=$(git --version)
echo "✅ Git encontrado: $git_version"

# Verificar carpeta correcta
if [ ! -f "SKILL.md" ]; then
    echo "❌ ERROR: No estás en la carpeta correcta"
    echo "   Debes ejecutar este script DENTRO de la carpeta 'code-refactorer-skill'"
    echo "   Ubicación actual: $(pwd)"
    exit 1
fi

echo "✅ Carpeta correcta detectada"
echo ""

# ============================================
# PASO 2: CONFIGURAR GIT LOCALMENTE
# ============================================

echo "2️⃣  CONFIGURANDO GIT..."
echo ""

git config user.name "$GITHUB_USERNAME"
git config user.email "$GITHUB_EMAIL"

echo "✅ Configuración de git completada"
echo ""

# ============================================
# PASO 3: INICIALIZAR REPOSITORIO
# ============================================

echo "3️⃣  INICIALIZANDO REPOSITORIO..."
echo ""

if [ -d ".git" ]; then
    echo "ℹ️  Git ya está inicializado"
else
    git init
    echo "✅ Repositorio inicializado"
fi

echo ""

# ============================================
# PASO 4: AGREGAR ARCHIVOS
# ============================================

echo "4️⃣  AGREGANDO ARCHIVOS..."
echo ""

git add .

# Mostrar archivos que se van a agregar
file_count=$(git diff --cached --name-only | wc -l)
echo "✅ Se agregarán $file_count archivos"
echo ""

# ============================================
# PASO 5: VERIFICAR ESTADO
# ============================================

echo "5️⃣  VERIFICANDO ESTADO..."
echo ""

git status

echo ""

# ============================================
# PASO 6: HACER COMMIT
# ============================================

echo "6️⃣  HACIENDO COMMIT..."
echo ""

if git commit -m "Initial commit: Code Refactorer Skill v1.0"; then
    echo "✅ Commit creado exitosamente"
else
    echo "⚠️  Aviso: No hay cambios para hacer commit (repositorio ya actualizado)"
fi

echo ""

# ============================================
# PASO 7: CONECTAR CON GITHUB
# ============================================

echo "7️⃣  CONECTANDO CON GITHUB..."
echo ""

# Verificar si remote ya existe
if git remote | grep -q origin; then
    echo "ℹ️  El remote 'origin' ya existe, actualizando URL..."
    git remote remove origin
fi

# Detectar si usar HTTPS o SSH
if [ -n "$GITHUB_TOKEN" ]; then
    # Usar HTTPS con token
    repo_url="https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
    auth_method="Token HTTPS"
else
    # Usar SSH
    repo_url="git@github.com:${GITHUB_USERNAME}/${REPO_NAME}.git"
    auth_method="SSH"
fi

git remote add origin "$repo_url"

echo "✅ Repositorio remoto agregado (método: $auth_method)"
echo "   URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""

# ============================================
# PASO 8: RENOMBRAR RAMA Y SUBIR
# ============================================

echo "8️⃣  SUBIENDO A GITHUB..."
echo ""

git branch -M main

echo "⏳ Subiendo... (esto puede tomar unos segundos)"
echo ""

if git push -u origin main; then
    echo "✅ ¡Subida exitosa!"
else
    echo "❌ Error al subir"
    echo "   Verifica que:"
    echo "   1. Tu token/SSH es válido"
    echo "   2. El repositorio existe en GitHub"
    echo "   3. Tienes permisos de escritura"
    exit 1
fi

echo ""

# ============================================
# PASO 9: VERIFICAR VALIDACIÓN
# ============================================

echo "9️⃣  VALIDANDO..."
echo ""

if [ -f "scripts/validate.py" ]; then
    echo "⏳ Ejecutando validación local..."
    if python3 scripts/validate.py; then
        echo "✅ Validación local completada exitosamente"
    else
        echo "⚠️  Advertencia: La validación local encontró problemas"
    fi
else
    echo "ℹ️  Script de validación no encontrado"
fi

echo ""

# ============================================
# FINALIZACIÓN
# ============================================

echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅ ¡TODO COMPLETADO EXITOSAMENTE!                     ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

echo "📊 RESUMEN:"
echo "  👤 Usuario: $GITHUB_USERNAME"
echo "  📁 Repositorio: $REPO_NAME"
echo "  🌐 URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "  🔧 Método: $auth_method"
echo ""

echo "📝 PRÓXIMOS PASOS:"
echo "  1. Ve a: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "  2. Verifica que los archivos estén ahí"
echo "  3. Espera a que se ejecute el workflow de validación"
echo "  4. Ve a Actions para ver el resultado"
echo ""

echo "🎉 ¡Tu skill está en GitHub!"
echo ""

# ============================================
# LIMPIAR VARIABLES SENSIBLES
# ============================================

unset GITHUB_USERNAME
unset GITHUB_EMAIL
unset GITHUB_TOKEN
unset repo_url

echo "✅ Script finalizado correctamente"
