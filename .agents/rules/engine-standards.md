---
paths:
  - "Assets/Scripts/**"
---

# Unity Engine & C# Standards

- **Encapsulation**: Default to `[SerializeField] private` instead of `public` fields for inspector-assignable variables.
- **Assembly Definitions (`.asmdef`)**: All major subsystems (`Core`, `Gameplay`, `UI`, `Tests`) must have their own `.asmdef` file to keep compile times minimal and prevent circular dependencies.
- **Reference Caching**: Cache all component references (`GetComponent<T>()`) in `Awake()` or `OnEnable()`. Never search the hierarchy in `Update()`.
- **No Magic Methods**: Never use `SendMessage()` or `BroadcastMessage()`. Use explicit C# interfaces or events.
- **Naming Conventions**:
  - Types, Methods, Properties: `PascalCase`
  - Private member fields: `_camelCase`
  - Parameters, Local variables: `camelCase`
  - Constants: `PascalCase` or `ALL_CAPS`
  - Interfaces: Prefix with `I` (e.g., `IDamageable`, `IInteractable`)
- **Package Management Directive (STRICT)**:
  - NEVER edit or write to `Packages/manifest.json`.
  - ALL packages must be installed by the user via Unity Editor Package Manager (`Window > Package Manager`).
  - The AI must guide the user with exact package names, wait for user confirmation, and verify via read-only inspection of `Packages/manifest.json`.
- **Unity Hub Project Genesis**:
  - The Unity project root must originate from Unity Hub (`ProjectSettings/ProjectVersion.txt` must exist).
