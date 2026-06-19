# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Code Refactorer Skill** is a specialized Claude AI skill for refactoring and improving source code across any programming language. It detects code smells, duplications, complexity issues, and design pattern opportunities, then provides refactored code with detailed explanations.

The skill is designed to be installed in Claude.ai as a custom skill and triggered when users want to improve, optimize, or analyze code.

## Architecture

The skill follows a **6-phase execution model**:

1. **Code Capture** — Accepts code from chat, files, or URLs
2. **Language Detection** — Automatically identifies the programming language
3. **Deep Analysis** — Examines code across 4 dimensions: legibility, maintainability, performance, security
4. **Proposal Generation** — Creates prioritized refactoring proposals with impact/difficulty estimates
5. **Refactorization** — Generates improved code with line-by-line change explanations
6. **Report Generation** — Produces comprehensive analysis with metrics, comparisons, and recommendations

### Core Components

- **[SKILL.md](SKILL.md)** — Main skill definition with YAML frontmatter, execution flow, modes of use, and language-specific considerations
- **[references/](references/)** — Three reference documents that guide analysis:
  - `code-smells.md` — 50+ code smell patterns (universal + language-specific)
  - `design-patterns.md` — GoF patterns and SOLID principles with applications
  - `metrics.md` — Code quality metrics interpretation and measurement tools
- **[test-cases.json](test-cases.json)** — 6 test cases covering Python, JavaScript, Java, TypeScript scenarios
- **[scripts/validate.py](scripts/validate.py)** — Validates skill structure and completeness

### Key Dimensions of Analysis

The skill analyzes code across:
- **Legibility**: Variable names, documentation, code structure, consistency
- **Maintainability**: Coupling, cohesion, cyclomatic complexity, duplication
- **Performance**: Algorithm efficiency, memory issues, redundant operations
- **Security**: Input validation, injection risks, resource management

## Development Workflow

### Validate the Skill Structure

```bash
python3 scripts/validate.py
```

This checks:
- SKILL.md exists and has proper YAML frontmatter
- All 3 reference files exist and have sufficient content (50+ lines)
- test-cases.json is valid JSON with required fields
- Required directories (references, scripts, assets) exist

### Key Files to Understand

When working with the skill:

1. **For triggers & flow** → Read [SKILL.md](SKILL.md)
2. **For code smell detection logic** → Read [references/code-smells.md](references/code-smells.md)
3. **For refactoring proposals** → Read [references/design-patterns.md](references/design-patterns.md)
4. **For metrics** → Read [references/metrics.md](references/metrics.md)
5. **For testing** → Check [test-cases.json](test-cases.json)

### Testing the Skill

Use the test cases in `test-cases.json` to verify the skill works correctly. Each case includes:
- Input code with intentional issues
- Expected problems to identify
- Expected improvements to suggest

### Documentation to Maintain

- **README.md** — User-facing overview and features
- **QUICK_START.md** — Quick guide for users getting started
- **ARCHITECTURE.md** — Detailed technical architecture and analysis strategy
- **SKILL.md** — The actual skill definition (this drives behavior)

## Language-Specific Considerations

The skill adapts its analysis by language:

- **Python**: PEP 8, type hints, context managers, list comprehensions, dataclasses
- **JavaScript/TypeScript**: ES6+, async/await vs Promises, type safety, React patterns
- **Java**: SOLID, Generics, Streams API, exception handling, design patterns
- **C#/.NET**: LINQ, async/await, null-coalescing, properties, Immutability
- **Go**: Interfaces, error handling, goroutines, channels, composition

## Output Structure

Every refactoring analysis produces:

```
📊 Initial Analysis (summary, language, purpose, complexity level)
🚩 Identified Problems (code smells by severity, duplication, complexity, SOLID violations)
📈 Metrics (maintainability index, avg complexity, duplication %, test coverage estimate)
🎯 Refactoring Proposals (specific changes with impact, difficulty, priority)
💾 Refactored Code (improved version, line-by-line changes, compatibility notes)
🔄 Before/After Comparison (metric improvements, complexity reduction)
🏗️ Pattern Recommendations (applicable design patterns with examples)
⚠️ Considerations (breaking changes, affected dependencies, migration steps)
```

## Common Tasks

### Adding a New Code Smell Pattern

Edit [references/code-smells.md](references/code-smells.md):
1. Determine if it's universal or language-specific
2. Add it under the appropriate section
3. Include: description, example, how to fix, why it matters
4. Run validation to ensure file integrity

### Adding a New Design Pattern Example

Edit [references/design-patterns.md](references/design-patterns.md):
1. Identify the pattern category (Creational/Structural/Behavioral/SOLID)
2. Add entry with: Name, When to use, Example, Advantages, When to apply, Before/after code
3. Include language-specific variants if relevant

### Adding Test Cases

Edit [test-cases.json](test-cases.json):
1. Create a new object with unique `id`
2. Include required fields: `title`, `language`, `input`, `expected_issues`, `expected_improvements`
3. Run validation to ensure JSON is valid
4. Test manually with the skill to verify it detects expected issues

### Updating the Skill Definition

Edit [SKILL.md](SKILL.md):
1. Maintain the YAML frontmatter (name, description)
2. Update sections as needed (workflow, modes, considerations)
3. Keep examples and limitations up-to-date
4. Ensure references section links are correct

## Languages and Frameworks Covered

**Primary focus**: Python, JavaScript/TypeScript, Java, C#/.NET, Go

**Also supports**: Rust, PHP, Ruby, C++, Swift, Kotlin, and any other language (with more generic analysis)

**Frameworks with specific patterns**:
- Python: Django, FastAPI, Flask, Pandas
- JavaScript: React, Vue, Angular, Node.js
- Java: Spring, Hibernate
- C#: .NET Framework/Core, ASP.NET

## Metrics Interpretation

The skill uses these key metrics in analysis:

- **Cyclomatic Complexity (CC)**: 1-5 = Low, 6-10 = Moderate, 11+ = High
- **Maintainability Index**: 0-40 = Low, 41-55 = Moderate, 56-100 = High
- **Code Duplication**: Target < 3%, warn at > 5%
- **Test Coverage**: Estimate based on code structure, not actual execution
- **SOLID Violations**: Track each principle (SRP, OCP, LSP, ISP, DIP)

## Limitations and Boundaries

The skill:
- ✅ Preserves original functionality (no behavior changes)
- ✅ Respects language/framework constraints
- ✅ Provides incremental approaches for large changes
- ❌ Does NOT execute code (static analysis only)
- ❌ Does NOT run actual tests (suggests them)
- ❌ Does NOT refactor obfuscated code without confirmation
- ❌ Does NOT modify generated code without warning

## When Expanding the Skill

If adding support for a new language or framework:

1. Add language-specific code smells to [references/code-smells.md](references/code-smells.md)
2. Document framework-specific patterns in [references/design-patterns.md](references/design-patterns.md)
3. Add test cases with examples in [test-cases.json](test-cases.json)
4. Update language considerations in [SKILL.md](SKILL.md)
5. Run `python3 scripts/validate.py` to ensure structure is intact

## File Organization

```
code-refactorer-skill/                     (repository root)
├── CLAUDE.md                              (this file - for Claude Code)
├── SKILL.md                               (skill definition with YAML frontmatter)
├── README.md                              (user-facing overview)
├── QUICK_START.md                         (quick start guide)
├── ARCHITECTURE.md                        (technical architecture details)
├── CONTRIBUTING.md                        (contribution guidelines)
├── LICENSE                                (license)
├── test-cases.json                        (6 test cases for validation)
├── references/                            (analysis guidance documents)
│   ├── code-smells.md
│   ├── design-patterns.md
│   └── metrics.md
├── scripts/                               (validation and maintenance)
│   └── validate.py
└── assets/                                (future: templates, images, etc.)
```

**File Organization Philosophy**:
- **Root level**: Skill definition (SKILL.md) + user-facing docs
- **references/**: Analysis guidance documents (read-only, only update content)
- **scripts/**: Validation and maintenance tools
- **assets/**: Future resource directory

## Key Principles

1. **Single Responsibility** — Each file has a clear purpose
2. **Documentation-Driven** — References guide analysis decisions
3. **Extensibility** — New patterns/smells added via reference docs, not code
4. **Validation** — Always validate structure after changes
5. **Language Agnostic** — Works with any language with language-aware customizations
