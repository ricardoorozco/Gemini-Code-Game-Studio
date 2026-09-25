# GCGS Hook: PreInvocation context injector
# Reads active session checkpoint and injects context before model runs

$inputRaw = ""
if ($input) {
    $inputRaw = ($input | Out-String)
}
if ([string]::IsNullOrWhiteSpace($inputRaw) -and [Console]::IsInputRedirected) {
    $inputRaw = [Console]::In.ReadToEnd()
}

$output = @{
    injectSteps = @()
}

try {
    $activePath = "production/session-state/active.md"
    if (Test-Path $activePath) {
        $content = Get-Content -Path $activePath -Raw
        $taskMatch = [regex]::Match($content, '\*\*Current task:\*\*\s*(.+)')
        if ($taskMatch.Success) {
            $task = $taskMatch.Groups[1].Value.Trim()
            $message = "GCGS Active Task: $task"
            $output.injectSteps += @{
                ephemeralMessage = $message
            }
        }
    }
}
catch {
    # Fail silently to avoid breaking invocation
}

$output | ConvertTo-Json -Compress
