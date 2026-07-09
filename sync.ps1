# Links every skill in this repo into ~/.claude/skills so Claude Code uses
# the repo as the live source. Uses directory junctions (no admin rights
# needed); replaces any plain copies from earlier installs.
# Usage: .\sync.ps1        re-run after adding a new skill directory.

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$dest = Join-Path $env:USERPROFILE '.claude\skills'
New-Item -ItemType Directory -Force $dest | Out-Null

Get-ChildItem $repo -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } | ForEach-Object {
    $link = Join-Path $dest $_.Name
    if (Test-Path $link) {
        $item = Get-Item $link -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            cmd /c rmdir "$link" | Out-Null          # remove junction only, never its target
        } else {
            Remove-Item $link -Recurse -Force        # plain copy from an earlier install
        }
    }
    New-Item -ItemType Junction -Path $link -Target $_.FullName | Out-Null
    Write-Host "linked  $($_.Name)"
}
Write-Host "`nDone. Skills in this repo are now live in $dest"
