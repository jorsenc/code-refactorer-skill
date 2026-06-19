# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Quick Start

**Essential commands** for this project:

```bash
# Validate the skill structure
python3 scripts/validate.py

# Check JSON validity in test cases
python -m json.tool test-cases.json > /dev/null

# Test a single code smell detection
python -c "import json; print(json.dumps(json.load(open('test-cases.json')), indent=2))" | head -50
```

**Model requirement**: Claude Sonnet 4.0 or higher (this skill requires substantial reasoning capacity)

**Key workflow**: Read SKILL.md → check references → edit CLAUDE.md/test-cases.json → validate → test

---

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

When working with the skill, each file serves a specific purpose:

1. **[SKILL.md](SKILL.md)** — Behavior definition; controls how the skill executes. Only edit frontmatter or flow sections; changes here affect Claude's reasoning.
2. **[references/code-smells.md](references/code-smells.md)** — Knowledge base; 50+ problems organized by language. Safe to expand with new smells; existing patterns should not be modified without reason.
3. **[references/design-patterns.md](references/design-patterns.md)** — Pattern reference; GoF + SOLID. Add patterns as needed; reorganizing existing entries requires care (Claude references them by position).
4. **[references/metrics.md](references/metrics.md)** — Interpretation guide; explains how to read code quality numbers. Update thresholds and tools when standards change.
5. **[test-cases.json](test-cases.json)** — Validation suite; 6 test cases covering key scenarios. Add new cases to expand coverage; existing cases should stay representative.

### Testing and Validating Changes

**Local validation:**
```bash
# Run the validation script (checks structure, JSON, content size)
python3 scripts/validate.py

# Should output: ✅ Validation successful
```

**Manual testing after changes:**
1. Edit the file you changed
2. Run `python3 scripts/validate.py` 
3. Copy updated `test-cases.json` or references to test in Claude.ai
4. Run the skill against the test cases
5. Verify it detects expected issues and proposes correct improvements

**What each test case validates:**
- Python simple → Basic code smell detection, list comprehension conversion
- JavaScript callbacks → Callback hell detection, async/await suggestion  
- Java nullpointers → NPE risk detection, Optional suggestion
- Python god object → SRP violation detection, class decomposition
- Python duplication → Code duplication detection, extraction
- TypeScript types → Type safety issues, annotation suggestions

If a test case starts failing after your changes, investigate whether:
- The reference file was accidentally corrupted
- A code smell pattern needs clarification
- The test case itself is invalid

### Documentation to Maintain

- **README.md** — User-facing overview and features
- **QUICK_START.md** — Quick guide for users getting started
- **ARCHITECTURE.md** — Detailed technical architecture and analysis strategy
- **SKILL.md** — The actual skill definition (this drives behavior)

## Reference Files Philosophy

The skill's core strength is that it's **documentation-driven, not code-driven**. Rather than implementing detection logic in code, three reference Markdown files guide Claude's analysis:

1. **code-smells.md** — catalog of problems, organized by language
2. **design-patterns.md** — applicable patterns and when to use them
3. **metrics.md** — interpretation guides for code quality numbers

**Why this approach:**
- ✅ Extensible without code changes (add a new smell, Claude learns it)
- ✅ Transparent (all rules are human-readable and editable)
- ✅ Language-agnostic (same framework works for Python, Go, Java, etc.)
- ✅ Easy to maintain (no compilation, no deployment pipeline)

**Trade-off:** These files are carefully structured. Reorganizing sections or renaming patterns can confuse Claude because it learns position and phrasing. When editing, add new content; preserve existing structure.

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

## File Editing Patterns

### 📝 Safe to Edit

**[references/code-smells.md](references/code-smells.md)** — Expand the catalog
- Add new universal problems or language-specific issues
- Keep existing entries unchanged (Claude learns their structure)
- Format: **Name** → description → example (❌ bad, ✅ good) → fix steps

**[test-cases.json](test-cases.json)** — Grow the test suite
- Add new `id`, `title`, `language`, `input`, `expected_issues`, `expected_improvements`
- Validate with `python -m json.tool test-cases.json` before committing
- Existing test cases: only fix if the expected issues/improvements are factually wrong

**[CLAUDE.md](CLAUDE.md)** — Update development guidance
- Document new workflows or file purposes
- Clarify architecture as needed
- Do not remove sections without reason (they guide future maintainers)

### ⚠️ Edit with Care

**[SKILL.md](SKILL.md)** — Defines Claude's execution model
- Only modify if the 6-phase workflow needs restructuring
- Frontmatter (name, description) should only change for releases
- Examples in the sections guide Claude's reasoning—breaking them breaks detection

**[references/design-patterns.md](references/design-patterns.md)** — Pattern reference
- Add new patterns freely
- Reorganizing existing patterns can confuse Claude (it's position-dependent)
- Update when best practices for a pattern change (e.g., React Hooks replacing class patterns)

**[references/metrics.md](references/metrics.md)** — Quality thresholds
- Update when industry benchmarks change
- Clarify metric interpretation as needed
- Do not remove tools or sections (they guide detection)

### ❌ Avoid

- Deleting test cases (remove only if duplicates exist)
- Renaming code smell categories (moves the problem, doesn't solve it)
- Major restructuring of reference files (breaks Claude's cross-references)
- Adding code examples to SKILL.md if examples already exist elsewhere

## Common Development Tasks

### Adding a New Code Smell Pattern

1. Determine if **universal** (all languages) or **language-specific**
2. Edit [references/code-smells.md](references/code-smells.md), add under the appropriate section:
   
   ```
   ### Problem Name
   **Description**: What the problem is  
   **Impact**: Why it matters (maintainability, performance, security)  
   **Example**:
   ❌ Problematic code goes here
   ✅ Fixed code goes here
   
   **How to fix**: Steps to resolve
   ```

3. Run `python3 scripts/validate.py` to verify file integrity
4. Add a test case if this is a major new detection (optional but recommended)

### Adding a New Design Pattern

1. Identify category: Creational / Structural / Behavioral / SOLID
2. Edit [references/design-patterns.md](references/design-patterns.md), add entry with:
   - **Name**
   - **When to use**: Situations where this pattern applies
   - **Example**: Real-world scenario
   - **Advantages**: Why this pattern helps
   - **When to apply**: Detection triggers (what code looks like before the pattern)
   - **Code**: Before/after code example
   - **Language notes**: Language-specific considerations (optional)
3. Run `python3 scripts/validate.py`

### Adding Test Cases

1. Edit [test-cases.json](test-cases.json), append:
   ```json
   {
     "id": "test_N_language_shortname",
     "title": "Descriptive title",
     "language": "python",
     "input": "code with intentional issues",
     "expected_issues": ["problem 1", "problem 2"],
     "expected_improvements": ["fix 1", "fix 2"]
   }
   ```
2. Validate: `python -m json.tool test-cases.json > /dev/null` (no output = valid)
3. Test manually in Claude.ai by pasting the input code and running the skill
4. Verify it detects all expected issues and suggests the expected improvements

### Updating SKILL.md

Only when the workflow itself changes. For example:
- Adding a new phase (5-phase → 7-phase)
- Changing how analysis dimensions work
- Expanding or removing modes of use

**To edit safely:**
1. Keep the YAML frontmatter intact (name, description)
2. Update section headers only if they align with the 6-phase model
3. Keep language-specific considerations grouped
4. Maintain examples for each section
5. Run through a manual test case after editing

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
