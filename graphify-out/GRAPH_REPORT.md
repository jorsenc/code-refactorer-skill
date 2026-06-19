# Graph Report - .  (2026-06-19)

## Corpus Check
- Corpus is ~16,198 words - fits in a single context window. You may not need a graph.

## Summary
- 22 nodes · 17 edges · 6 communities (2 shown, 4 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 1,000 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Reference Docs|Reference Docs]]
- [[_COMMUNITY_Core Skill|Core Skill]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]

## God Nodes (most connected - your core abstractions)
1. `permissions` - 2 edges
2. `validate_skill()` - 2 edges
3. `GITHUB_QUICK_COMMANDS.sh script` - 1 edges
4. `upload-to-github.sh script` - 1 edges
5. `allow` - 1 edges
6. `Valida la estructura de la skill.` - 1 edges

## Surprising Connections (you probably didn't know these)
- `Code Refactorer Skill` --implements--> `6-Phase Execution Model`  [EXTRACTED]
  unknown → unknown  _Bridges community 1 → community 0_

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Six Execution Phases** — six_phase_model [EXTRACTED 1.00]

## Communities (6 total, 4 thin omitted)

### Community 0 - "Reference Docs"
Cohesion: 0.29
Nodes (7): Legibility Analysis, Maintainability Analysis, Performance Analysis, Security Analysis, Code Smells Reference, Metrics Reference, 6-Phase Execution Model

### Community 1 - "Core Skill"
Cohesion: 0.40
Nodes (4): Design Patterns Reference, Documentation-Driven Architecture, Code Refactorer Skill, Validation Script

## Knowledge Gaps
- **3 isolated node(s):** `GITHUB_QUICK_COMMANDS.sh script`, `upload-to-github.sh script`, `allow`
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `GITHUB_QUICK_COMMANDS.sh script`, `upload-to-github.sh script`, `allow` to the rest of the system?**
  _4 weakly-connected nodes found - possible documentation gaps or missing edges._