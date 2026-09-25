# GCGS Hook: PreToolUse Validator for run_command
# Enforces safety gates and checks git commits

$inputRaw = ""
if ($input) {
    $inputRaw = ($input | Out-String)
}
if ([string]::IsNullOrWhiteSpace($inputRaw) -and [Console]::IsInputRedirected) {
    $inputRaw = [Console]::In.ReadToEnd()
}

$decision = "allow"
$reason = ""

if (-not [string]::IsNullOrWhiteSpace($inputRaw)) {
    try {
        $data = $inputRaw | ConvertFrom-Json
        $cmd = $data.toolCall.args.CommandLine

        if ($cmd) {
            # 1. Block/Ask on destructive commands
            $destructivePatterns = @(
                'git\s+push\s+.*(-f|--force)',
                'git\s+reset\s+--hard',
                'git\s+clean\s+.*-f',
                'rmdir\s+/s\s+/q\s+\.git',
                'rm\s+-rf\s+\.git'
            )

            foreach ($pattern in $destructivePatterns) {
                if ($cmd -match $pattern) {
                    $decision = "ask"
                    $reason = "GCGS Safety Gate: Destructive git/filesystem command detected: '$cmd'. Please confirm."
                    break
                }
            }

            # 2. Check git commits for story reference
            if ($decision -eq "allow" -and $cmd -match 'git\s+commit') {
                # Advise having descriptive commit messages
                if ($cmd -match '-m\s+["'']?(wip|fix|update|temp)["'']?(\s|$)') {
                    $decision = "ask"
                    $reason = "GCGS Quality Gate: Vague commit message detected. Prefer referencing the Story ID or system (e.g., 'feat(combat): implement base attack story-001')."
                }
            }
        }
    }
    catch {
        # Fallback to allow on parse error so developer is not blocked
        $decision = "allow"
    }
}

$output = @{
    decision = $decision
}
if ($reason) {
    $output["reason"] = $reason
}

$output | ConvertTo-Json -Compress
