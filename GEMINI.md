# Gemini Code Game Studio (GCGS)  -  Studio Bridge

This Unity project is powered by **Gemini Code Game Studio**.
All studio intelligence, 49 specialist roles, 74 workflow skills, design documents, and configurations are encapsulated inside the `gemini-studio/` directory.

---

## 1. Studio Core Navigation

- **Master Studio Instructions**: `gemini-studio/GEMINI.md`
- **Studio Configuration**: `gemini-studio/project.yaml`
- **Active Session State Checkpoint**: `gemini-studio/production/session-state/active.md`
- **Game Design Documents (GDDs)**: `gemini-studio/design/gdd/`
- **Technical Architecture & ADRs**: `gemini-studio/docs/architecture/`
- **Visual QA Evidence**: `gemini-studio/production/qa/evidence/`
- **Studio Documentation**: `gemini-studio/README.md`

---

## 2. Mandatory Unity Directives (Strict & Non-Negotiable)

1. **Unity Hub Genesis**:
   - The Unity project MUST be created by the user from **Unity Hub**.
   - Verify that `ProjectSettings/ProjectVersion.txt` exists before writing code.
2. **No Direct Package Manifest Modification**:
   - The AI MUST NEVER attempt to directly edit `Packages/manifest.json`.
   - ALL packages (Input System, UI Toolkit, Addressables, URP, etc.) MUST be installed by the user through the **Unity Editor Package Manager** (`Window > Package Manager`).
   - Guide the user with the exact package name/ID, pause for confirmation, then verify via read-only check.
3. **Data-Driven Gameplay**:
   - Store all gameplay parameters in `ScriptableObject` assets in `Assets/Scripts/Data/`.
4. **Decoupled Architecture**:
   - UI views must never own game state. Use C# events or observable patterns.
5. **Run and Observe**:
   - Visual and gameplay features require runtime observation and a verification screenshot saved in `gemini-studio/production/qa/evidence/`.
