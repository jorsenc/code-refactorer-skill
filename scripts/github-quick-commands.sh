#!/bin/bash
# Script rápido para subir a GitHub
# Reemplaza TU_USUARIO y TU_EMAIL antes de ejecutar

# ⚠️ REEMPLAZA ESTOS VALORES ⚠️
GITHUB_USER="TU_USUARIO"
GITHUB_EMAIL="TU_EMAIL@ejemplo.com"
REPO_NAME="code-refactorer-skill"

# ============================================

echo "🚀 Preparando para subir a GitHub"
echo "======================================"
echo "Usuario: $GITHUB_USER"
echo "Email: $GITHUB_EMAIL"
echo "Repositorio: $REPO_NAME"
echo "======================================"
echo ""

# Configura git
echo "1️⃣  Configurando git..."
git config user.name "$GITHUB_USER"
git config user.email "$GITHUB_EMAIL"

# Inicializa si es necesario
if [ ! -d .git ]; then
    echo "2️⃣  Inicializando repositorio..."
    git init
else
    echo "2️⃣  Git ya inicializado"
fi

# Agrega archivos
echo "3️⃣  Agregando archivos..."
git add .

# Muestra estado
echo "4️⃣  Verificando estado..."
git status

# Primer commit
echo "5️⃣  Haciendo commit inicial..."
git commit -m "Initial commit: Code Refactorer Skill v1.0"

# Configura remoto
echo "6️⃣  Conectando con GitHub..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git

# Sube
echo "7️⃣  Subiendo a GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ ¡Listo!"
echo ""
echo "Tu repositorio está en:"
echo "https://github.com/$GITHUB_USER/$REPO_NAME"
echo ""
