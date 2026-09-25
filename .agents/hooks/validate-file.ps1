# GCGS Hook: PostToolUse Validator for file edits and writes
# Outputs empty JSON object {} as required by Antigravity PostToolUse contract

$inputRaw = ""
if ([Console]::IsInputRedirected) {
    $inputRaw = [Console]::In.ReadToEnd()
}

# PostToolUse contract expects an empty JSON object
Write-Output "{}"
