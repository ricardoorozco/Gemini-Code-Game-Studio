# ====================================================================
# Gemini Code Game Studio (GCGS)  -  Studio Updater
# Safely updates studio intelligence in an existing Unity project
# WITHOUT touching or overwriting your game design, stories, or settings.
# ====================================================================

param(
    [Parameter(Mandatory=$false, Position=0)]
    [string]$TargetProject = "",

    [Parameter(Mandatory=$false)]
    [string]$SourceStudio = ""
)

$ErrorActionPreference = "Stop"

# 1. Determine Source Studio
$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    $scriptDir = (Get-Item .).FullName
}

if (-not $SourceStudio) {
    if ((Split-Path -Leaf $scriptDir) -eq "gemini-studio") {
        $SourceStudio = $scriptDir
    } else {
        $candidate = Join-Path $scriptDir "gemini-studio"
        if (Test-Path $candidate) {
            $SourceStudio = $candidate
        } else {
            $SourceStudio = $scriptDir
        }
    }
}

if (-not (Test-Path (Join-Path $SourceStudio ".agents"))) {
    Write-Error "Source studio path does not seem valid (no .agents found): $SourceStudio"
}

# 2. Determine Target Project
if (-not $TargetProject) {
    Write-Host "`n>>> Gemini Code Game Studio Updater" -ForegroundColor Cyan
    Write-Host "This script will update the studio tools in your Unity project without touching your GDDs, stories, or project.yaml.`n" -ForegroundColor Gray
    $TargetProject = Read-Host "Enter the path to your target Unity project (e.g. D:\Projects\MyGame)"
}

if (-not $TargetProject) {
    Write-Error "Target project path is required."
}

# Normalize target root and target gemini-studio dir
$targetRoot = (Resolve-Path $TargetProject).Path
$targetStudio = Join-Path $targetRoot "gemini-studio"

if (-not (Test-Path $targetStudio)) {
    # If the user passed the gemini-studio folder directly
    if ((Split-Path -Leaf $targetRoot) -eq "gemini-studio") {
        $targetStudio = $targetRoot
        $targetRoot = Split-Path -Parent $targetRoot
    } else {
        Write-Host "Target studio folder not found at $targetStudio." -ForegroundColor Yellow
        $create = Read-Host "Do you want to initialize gemini-studio in $targetRoot? (y/n)"
        if ($create -ne "y") {
            Write-Host "Update aborted." -ForegroundColor Red
            exit 1
        }
        New-Item -ItemType Directory -Path $targetStudio -Force | Out-Null
    }
}

Write-Host "`n>>> Updating Gemini Code Game Studio..." -ForegroundColor Cyan
Write-Host "    Source: $SourceStudio" -ForegroundColor Gray
Write-Host "    Target: $targetStudio`n" -ForegroundColor Gray

# 3. Synchronize Intelligence Folders (Safe to overwrite with latest version)
$frameworkDirs = @(
    ".agents",
    "docs/engine-reference/unity",
    "docs/templates"
)

foreach ($relDir in $frameworkDirs) {
    $src = Join-Path $SourceStudio $relDir
    $dst = Join-Path $targetStudio $relDir

    if (Test-Path $src) {
        if (-not (Test-Path $dst)) {
            New-Item -ItemType Directory -Path $dst -Force | Out-Null
        }
        Copy-Item -Path (Join-Path $src "*") -Destination $dst -Recurse -Force
        Write-Host "  [OK] Updated $relDir" -ForegroundColor Green
    }
}

# 4. Synchronize Single Framework Files
$frameworkFiles = @(
    "init.ps1",
    "update.ps1",
    "GEMINI.md",
    "README.md",
    "docs/workflow-catalog.yaml"
)

foreach ($relFile in $frameworkFiles) {
    $src = Join-Path $SourceStudio $relFile
    $dst = Join-Path $targetStudio $relFile

    if (Test-Path $src) {
        $parent = Split-Path -Parent $dst
        if (-not (Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Copy-Item -Path $src -Destination $dst -Force
        Write-Host "  [OK] Updated $relFile" -ForegroundColor Green
    }
}

# 5. Copy New Registry Files ONLY IF THEY DO NOT EXIST (Do not overwrite existing game data!)
$registries = @(
    "docs/architecture/tr-registry.yaml",
    "design/registry/entities.yaml"
)

foreach ($reg in $registries) {
    $src = Join-Path $SourceStudio $reg
    $dst = Join-Path $targetStudio $reg

    if (Test-Path $src) {
        if (-not (Test-Path $dst)) {
            $parent = Split-Path -Parent $dst
            if (-not (Test-Path $parent)) {
                New-Item -ItemType Directory -Path $parent -Force | Out-Null
            }
            Copy-Item -Path $src -Destination $dst -Force
            Write-Host "  [+] Seeded new registry: $reg" -ForegroundColor Cyan
        } else {
            Write-Host "  [i] Existing registry preserved: $reg" -ForegroundColor Gray
        }
    }
}

# 6. Inform user about preserved files
Write-Host "`n  [PRESERVED] Your game data was left intact:" -ForegroundColor DarkCyan
Write-Host "    - project.yaml" -ForegroundColor Gray
Write-Host "    - production/session-state/active.md" -ForegroundColor Gray
Write-Host "    - design/ (GDDs, concept, briefs)" -ForegroundColor Gray
Write-Host "    - production/ (epics, sprints, evidence)" -ForegroundColor Gray
Write-Host "    - docs/architecture/ (ADRs)" -ForegroundColor Gray

# 7. Run init.ps1 on the target project to update bridge, hooks and rules
Write-Host "`n>>> Running init.ps1 on target project to refresh bridge and hooks..." -ForegroundColor Cyan
$targetInit = Join-Path $targetStudio "init.ps1"
if (Test-Path $targetInit) {
    & powershell.exe -ExecutionPolicy Bypass -File $targetInit
}

Write-Host "`n>>> Update complete! Target project is now running the latest Gemini Code Game Studio.`n" -ForegroundColor Green
