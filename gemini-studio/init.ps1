# ====================================================================
# Gemini Code Game Studio (GCGS) — Project Initializer & Bridge Setup
# Run this script whenever you drop 'gemini-studio/' into a Unity project.
# Usage: powershell -ExecutionPolicy Bypass -File ./gemini-studio/init.ps1
# ====================================================================

$ErrorActionPreference = "Stop"
$root = (Get-Item .).FullName

Write-Host ">>> Initializing Gemini Code Game Studio in: $root" -ForegroundColor Cyan

# 1. Create root GEMINI.md bridge
$bridgeContent = @'
# Gemini Code Game Studio (GCGS) — Studio Bridge

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
'@

Set-Content -Path (Join-Path $root "GEMINI.md") -Value $bridgeContent -Encoding UTF8
Write-Host "  [OK] Created root GEMINI.md bridge." -ForegroundColor Green

# 2. Setup root .agents/ configuration
$rootAgents = Join-Path $root ".agents"
if (-not (Test-Path $rootAgents)) {
    New-Item -ItemType Directory -Path $rootAgents -Force | Out-Null
}

# Setup skills.json pointer
$skillsJson = @{
    entries = @(
        @{ path = "gemini-studio/.agents/skills" }
    )
}
$skillsJson | ConvertTo-Json -Depth 5 | Set-Content -Path (Join-Path $rootAgents "skills.json") -Encoding UTF8
Write-Host "  [OK] Configured .agents/skills.json pointer." -ForegroundColor Green

# Setup root hooks.json pointing to gemini-studio
$hooksJson = @'
{
  "gcgs-safety-gate": {
    "enabled": true,
    "PreToolUse": [
      {
        "matcher": "run_command",
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \"$p = @('gemini-studio/.agents/hooks/validate-command.ps1', '.agents/hooks/validate-command.ps1') | Where-Object { Test-Path $_ } | Select-Object -First 1; & $p\"",
            "timeout": 15
          }
        ]
      }
    ]
  },
  "gcgs-asset-validator": {
    "enabled": true,
    "PostToolUse": [
      {
        "matcher": "write_to_file|replace_file_content|multi_replace_file_content",
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \"$p = @('gemini-studio/.agents/hooks/validate-file.ps1', '.agents/hooks/validate-file.ps1') | Where-Object { Test-Path $_ } | Select-Object -First 1; & $p\"",
            "timeout": 10
          }
        ]
      }
    ]
  },
  "gcgs-session-checkpoint": {
    "enabled": true,
    "PreInvocation": [
      {
        "type": "command",
        "command": "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \"$p = @('gemini-studio/.agents/hooks/session-context.ps1', '.agents/hooks/session-context.ps1') | Where-Object { Test-Path $_ } | Select-Object -First 1; & $p\"",
        "timeout": 10
      }
    ]
  }
}
'@
Set-Content -Path (Join-Path $rootAgents "hooks.json") -Value $hooksJson -Encoding UTF8
Write-Host "  [OK] Configured .agents/hooks.json." -ForegroundColor Green

# Copy rules to root .agents/rules for path-scoped matching
$rootRules = Join-Path $rootAgents "rules"
if (-not (Test-Path $rootRules)) {
    New-Item -ItemType Directory -Path $rootRules -Force | Out-Null
}
Copy-Item -Path (Join-Path $root "gemini-studio/.agents/rules/*") -Destination $rootRules -Recurse -Force
Write-Host "  [OK] Synchronized .agents/rules/." -ForegroundColor Green

# 3. Optional: Scaffold recommended Unity architecture if Assets/ exists but Scripts/ does not
$assetsDir = Join-Path $root "Assets"
if (Test-Path $assetsDir) {
    $scriptsDir = Join-Path $assetsDir "Scripts"
    if (-not (Test-Path $scriptsDir)) {
        Write-Host "  [+] Blank Assets folder detected. Scaffolding recommended modular architecture..." -ForegroundColor Cyan

        # Core
        $coreDir = Join-Path $scriptsDir "Core"
        New-Item -ItemType Directory -Path $coreDir -Force | Out-Null
        @'
{
    "name": "Studio.Core",
    "rootNamespace": "Studio.Core",
    "references": [],
    "includePlatforms": [],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": false,
    "precompiledReferences": [],
    "autoReferenced": true,
    "defineConstraints": [],
    "versionDefines": [],
    "noEngineReferences": false
}
'@ | Set-Content -Path (Join-Path $coreDir "Studio.Core.asmdef") -Encoding UTF8

        # Gameplay
        $gameplayDir = Join-Path $scriptsDir "Gameplay"
        New-Item -ItemType Directory -Path $gameplayDir -Force | Out-Null
        @'
{
    "name": "Studio.Gameplay",
    "rootNamespace": "Studio.Gameplay",
    "references": [
        "Studio.Core"
    ],
    "includePlatforms": [],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": false,
    "precompiledReferences": [],
    "autoReferenced": true,
    "defineConstraints": [],
    "versionDefines": [],
    "noEngineReferences": false
}
'@ | Set-Content -Path (Join-Path $gameplayDir "Studio.Gameplay.asmdef") -Encoding UTF8

        # UI
        $uiDir = Join-Path $scriptsDir "UI"
        New-Item -ItemType Directory -Path $uiDir -Force | Out-Null
        @'
{
    "name": "Studio.UI",
    "rootNamespace": "Studio.UI",
    "references": [
        "Studio.Core"
    ],
    "includePlatforms": [],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": false,
    "precompiledReferences": [],
    "autoReferenced": true,
    "defineConstraints": [],
    "versionDefines": [],
    "noEngineReferences": false
}
'@ | Set-Content -Path (Join-Path $uiDir "Studio.UI.asmdef") -Encoding UTF8

        # Data
        $dataDir = Join-Path $scriptsDir "Data"
        New-Item -ItemType Directory -Path $dataDir -Force | Out-Null
        "# ScriptableObject data assets" | Set-Content -Path (Join-Path $dataDir ".gitkeep") -Encoding UTF8

        # Tests
        $testsEditor = Join-Path $assetsDir "Tests/Editor"
        New-Item -ItemType Directory -Path $testsEditor -Force | Out-Null
        @'
{
    "name": "Studio.Tests.Editor",
    "rootNamespace": "Studio.Tests.Editor",
    "references": [
        "Studio.Core",
        "Studio.Gameplay"
    ],
    "includePlatforms": [
        "Editor"
    ],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": true,
    "precompiledReferences": [
        "nunit.framework.dll"
    ],
    "autoReferenced": false,
    "defineConstraints": [
        "UNITY_INCLUDE_TESTS"
    ],
    "versionDefines": [],
    "noEngineReferences": false
}
'@ | Set-Content -Path (Join-Path $testsEditor "Studio.Tests.Editor.asmdef") -Encoding UTF8

        $testsRuntime = Join-Path $assetsDir "Tests/Runtime"
        New-Item -ItemType Directory -Path $testsRuntime -Force | Out-Null
        @'
{
    "name": "Studio.Tests.Runtime",
    "rootNamespace": "Studio.Tests.Runtime",
    "references": [
        "Studio.Core",
        "Studio.Gameplay"
    ],
    "includePlatforms": [],
    "excludePlatforms": [],
    "allowUnsafeCode": false,
    "overrideReferences": true,
    "precompiledReferences": [
        "nunit.framework.dll"
    ],
    "autoReferenced": false,
    "defineConstraints": [
        "UNITY_INCLUDE_TESTS"
    ],
    "versionDefines": [],
    "noEngineReferences": false
}
'@ | Set-Content -Path (Join-Path $testsRuntime "Studio.Tests.Runtime.asmdef") -Encoding UTF8

        Write-Host "  [OK] Generated Assets/Scripts (Core, Gameplay, UI, Data) and Tests with .asmdef." -ForegroundColor Green
    } else {
        Write-Host "  [INFO] Existing Assets/Scripts detected — preserving existing project structure." -ForegroundColor Gray
    }
}

Write-Host "`n>>> Gemini Code Game Studio is fully initialized and linked!" -ForegroundColor Cyan
Write-Host "    You can now use /start or /brainstorm in your AI session.`n" -ForegroundColor Yellow
