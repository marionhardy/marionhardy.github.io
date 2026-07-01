# ============================================================
#  publish.ps1  —  one-command publish: vault -> site -> live
#
#  Model: VAULT IS TRUTH. The site's src/content mirrors the
#  vault's Published/ subset exactly. A note removed from
#  Published/ is auto-removed from the site (un-publish).
#
#  Reads ONLY from Published/, so private notes never reach
#  the public repo — the safety wall is structural.
#
#  SAFETY GUARD: if a Published/<collection> folder is missing
#  or unexpectedly EMPTY while the repo has notes there, the
#  script PAUSES and asks — this prevents a mid-sync Drive
#  glitch from mass-deleting your published content.
#
#  USAGE:  from the site repo root, run:  .\publish.ps1
# ============================================================

$VaultPublished = "G:\My Drive\GithubWebsite\Published"
$SiteContent    = "$PSScriptRoot\src\content"
$Collections    = @("publications", "projects", "writing")

# --- SAFETY CHECKS ------------------------------------------------
if (-not (Test-Path $VaultPublished)) {
    Write-Host "ERROR: Published folder not found at:`n  $VaultPublished" -ForegroundColor Red
    Write-Host "Is Google Drive mounted and synced? Aborting (nothing changed)."
    exit 1
}
if (-not (Test-Path $SiteContent)) {
    Write-Host "ERROR: site content folder not found at:`n  $SiteContent" -ForegroundColor Red
    Write-Host "Run this from the site repo root."
    exit 1
}

Write-Host "Publishing (vault is truth) ..." -ForegroundColor Cyan
foreach ($c in $Collections) {
    $src = Join-Path $VaultPublished $c
    $dst = Join-Path $SiteContent    $c

    $srcExists = Test-Path $src
    $srcFiles  = @()
    if ($srcExists) {
        $srcFiles = Get-ChildItem -Path $src -Filter *.md -File -ErrorAction SilentlyContinue
    }
    $srcNames = $srcFiles | ForEach-Object { $_.Name }

    # Current repo notes for this collection.
    $dstFiles = @()
    if (Test-Path $dst) {
        $dstFiles = Get-ChildItem -Path $dst -Filter *.md -File -ErrorAction SilentlyContinue
    }

    # --- GUARD: source empty/missing but repo has notes -> ASK ----
    if (($srcFiles.Count -eq 0) -and ($dstFiles.Count -gt 0)) {
        Write-Host "`n  WARNING: Published/$c is missing or empty, but the repo has $($dstFiles.Count) note(s) there." -ForegroundColor Yellow
        Write-Host "  Proceeding would DELETE those $($dstFiles.Count) note(s) from the site." -ForegroundColor Yellow
        Write-Host "  (If Drive is mid-sync, cancel and retry in a moment.)" -ForegroundColor Yellow
        $ans = Read-Host "  Delete them? Type 'yes' to confirm, anything else to skip this collection"
        if ($ans -ne "yes") {
            Write-Host "  -> skipped '$c' (left repo notes intact)" -ForegroundColor DarkGray
            continue
        }
    }

    if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Path $dst | Out-Null }

    # Remove repo .md files not present in Published/ (un-publish).
    $dstFiles | Where-Object { $srcNames -notcontains $_.Name } | ForEach-Object {
        Write-Host "  - remove $c/$($_.Name) (unpublished)" -ForegroundColor Yellow
        Remove-Item $_.FullName
    }

    # Copy/overwrite current source files.
    foreach ($f in $srcFiles) {
        Copy-Item $f.FullName (Join-Path $dst $f.Name) -Force
        Write-Host "  + $c/$($f.Name)" -ForegroundColor Green
    }
}

# --- COMMIT & PUSH -----------------------------------------------
Write-Host "`nStaging changes..." -ForegroundColor Cyan
git add src/content

$changed = git status --porcelain src/content
if ([string]::IsNullOrWhiteSpace($changed)) {
    Write-Host "No content changes to publish. Done." -ForegroundColor DarkGray
    exit 0
}

$stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "Publish content ($stamp)"
Write-Host "Pushing..." -ForegroundColor Cyan
git push

Write-Host "`nDone. GitHub Actions is rebuilding — live in ~2 min." -ForegroundColor Green