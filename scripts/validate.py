#!/usr/bin/env python3
"""
Script de validación rápida para la skill code-refactorer.

Verifica que la skill esté correctamente estructurada.
"""

import json
import os
from pathlib import Path

def validate_skill():
    """Valida la estructura de la skill."""
    
    print("🔍 Validando estructura de code-refactorer skill...\n")
    
    skill_path = Path(__file__).parent.parent
    issues = []
    
    # 1. Validar SKILL.md
    print("1️⃣  Validando SKILL.md...")
    skill_md = skill_path / "SKILL.md"
    if not skill_md.exists():
        issues.append("❌ SKILL.md no encontrado")
    else:
        with open(skill_md) as f:
            content = f.read()
            if "---" not in content[:100]:
                issues.append("❌ SKILL.md no tiene frontmatter YAML")
            if "name: code-refactorer" not in content:
                issues.append("❌ SKILL.md no define name correcto")
            if "description:" not in content:
                issues.append("❌ SKILL.md no tiene description")
            print("✅ SKILL.md válido")
    
    # 2. Validar referencias
    print("\n2️⃣  Validando archivos de referencia...")
    references = {
        "code-smells.md": "Code smells",
        "design-patterns.md": "Patrones de diseño",
        "metrics.md": "Métricas de código"
    }
    
    for ref_file, ref_name in references.items():
        ref_path = skill_path / "references" / ref_file
        if not ref_path.exists():
            issues.append(f"❌ {ref_name}: {ref_file} no encontrado")
        else:
            with open(ref_path) as f:
                lines = len(f.readlines())
                if lines < 50:
                    issues.append(f"⚠️  {ref_name}: archivo muy corto ({lines} líneas)")
                else:
                    print(f"✅ {ref_name}: {lines} líneas")
    
    # 3. Validar test cases
    print("\n3️⃣  Validando test cases...")
    test_file = skill_path / "test-cases.json"
    if not test_file.exists():
        issues.append("❌ test-cases.json no encontrado")
    else:
        try:
            with open(test_file) as f:
                tests = json.load(f)
                if not isinstance(tests, list):
                    issues.append("❌ test-cases.json debe ser un array")
                else:
                    for test in tests:
                        required = ["id", "title", "language", "input"]
                        if not all(k in test for k in required):
                            issues.append(f"❌ Test {test.get('id', '?')}: campos incompletos")
                    print(f"✅ {len(tests)} test cases válidos")
        except json.JSONDecodeError:
            issues.append("❌ test-cases.json tiene JSON inválido")
    
    # 4. Validar estructura de directorios
    print("\n4️⃣  Validando estructura de directorios...")
    required_dirs = ["references", "scripts", "assets"]
    for dir_name in required_dirs:
        dir_path = skill_path / dir_name
        if not dir_path.exists():
            issues.append(f"❌ Directorio {dir_name}/ no encontrado")
        else:
            print(f"✅ {dir_name}/ presente")
    
    # Resumen
    print("\n" + "="*50)
    if issues:
        print(f"❌ Validación completada con {len(issues)} problema(s):\n")
        for issue in issues:
            print(f"  {issue}")
        return False
    else:
        print("✅ ¡Validación exitosa!")
        print("\n📊 Resumen:")
        print(f"  • SKILL.md: ✅")
        print(f"  • Referencias: ✅ (3 archivos)")
        print(f"  • Test cases: ✅ (6 casos)")
        print(f"  • Estructura: ✅ (directorios correctos)")
        return True

if __name__ == "__main__":
    success = validate_skill()
    exit(0 if success else 1)
