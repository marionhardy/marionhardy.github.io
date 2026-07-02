# ============================================================
#  publish.ps1  -  one-command publish: vault -> site -> live
#
#  Model: VAULT IS TRUTH. src/content mirrors Published/ exactly.
#  A note removed from Published/ is auto-removed from the site.
#  Reads ONLY from Published/ -> private notes never reach the
#  public repo (structural safety wall).
#
#  Copies per-collection Obsidian attachments into public/ and
#  rewrites ![[embed]] to Markdown image links in the MIRRORED
#  .md only (vault source note is never modified). Filename
#  spaces are URL-encoded (%20) in the emitted path.
#
#  All note I/O is explicit UTF-8 (no BOM) to preserve accented
#  author names / smart punctuation across the mirror.
#
#  SAFETY GUARD: if a Published/<collection> is missing or empty
#  while the repo has notes there, the script PAUSES and asks -
#  prevents a mid-sync Drive glitch from mass-deleting content.
#
#  USAGE: from the site repo root, run:  .\publish.ps1
#  NOTE:  ASCII-only source (avoids cross-machine encoding breakage).
# ============================================================

# --- CONFIG -------------------------------------------------------
$VaultPublished = "G:\My Drive\GithubWebsite\Published"  # source (read-only)
$SiteContent    = "$PSScriptRoot\src\content"            # note destination
$SitePublic     = "$PSScriptRoot\public"                 # attachment destination root
$Collections    = @("publications", "projects", "writing")

# UTF-8 without BOM, used for all note reads/writes.
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# --- PRECHECKS ----------------------------------------------------
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

# --- MIRROR EACH COLLECTION ---------------------------------------
Write-Host "Publishing (vault is truth) ..." -ForegroundColor Cyan
foreach ($c in $Collections) {
    $src = Join-Path $VaultPublished $c
    $dst = Join-Path $SiteContent    $c

    # Source notes for this collection.
    $srcFiles = @()
    if (Test-Path $src) {
        $srcFiles = Get-ChildItem -Path $src -Filter *.md -File -ErrorAction SilentlyContinue
    }
    $srcNames = $srcFiles | ForEach-Object { $_.Name }

    # Current repo notes for this collection.
    $dstFiles = @()
    if (Test-Path $dst) {
        $dstFiles = Get-ChildItem -Path $dst -Filter *.md -File -ErrorAction SilentlyContinue
    }

    # GUARD: source empty/missing but repo has notes -> confirm before deleting.
    if (($srcFiles.Count -eq 0) -and ($dstFiles.Count -gt 0)) {
        Write-Host "`n  WARNING: Published/$c is missing or empty, but the repo has $($dstFiles.Count) note(s)." -ForegroundColor Yellow
        Write-Host "  Proceeding would DELETE those note(s) from the site." -ForegroundColor Yellow
        Write-Host "  (If Drive is mid-sync, cancel and retry in a moment.)" -ForegroundColor Yellow
        $ans = Read-Host "  Delete them? Type 'yes' to confirm, anything else to skip"
        if ($ans -ne "yes") {
            Write-Host "  -> skipped '$c' (left repo notes intact)" -ForegroundColor DarkGray
            continue
        }
    }

    if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Path $dst | Out-Null }

    # Un-publish: remove repo notes no longer present in Published/.
    $dstFiles | Where-Object { $srcNames -notcontains $_.Name } | ForEach-Object {
        Write-Host "  - remove $c/$($_.Name) (unpublished)" -ForegroundColor Yellow
        Remove-Item $_.FullName
    }

    # Copy attachments wholesale: Published/<c>/Attachments/ -> public/<c>/attachments/
    $srcAtt = Join-Path $src "Attachments"
    $dstAtt = Join-Path $SitePublic (Join-Path $c "attachments")
    if (Test-Path $srcAtt) {
        if (-not (Test-Path $dstAtt)) { New-Item -ItemType Directory -Path $dstAtt -Force | Out-Null }
        Copy-Item (Join-Path $srcAtt "*") $dstAtt -Recurse -Force
        Write-Host "  ~ $c/attachments copied" -ForegroundColor DarkCyan
    }

    # Copy/overwrite notes; rewrite Obsidian embeds in the MIRRORED copy only.
    #   ![[file.png]]      -> ![](/<c>/attachments/file.png)
    #   ![[file.png|300]]  -> alias/width stripped (plain rewrite)
    #   spaces in filename -> %20 in emitted URL (file on disk keeps real name)
    # Explicit UTF-8 read/write preserves accented chars & smart punctuation.
    foreach ($f in $srcFiles) {
        $text = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
        $text = [regex]::Replace($text, '!\[\[([^\]\|]+?)(?:\|[^\]]*)?\]\]', {
            param($m)
            $fname = $m.Groups[1].Value.Trim() -replace ' ', '%20'
            "![](/$c/attachments/$fname)"
        })
        [System.IO.File]::WriteAllText((Join-Path $dst $f.Name), $text, $Utf8NoBom)
        Write-Host "  + $c/$($f.Name)" -ForegroundColor Green
    }
}

# --- COMMIT & PUSH ------------------------------------------------
Write-Host "`nStaging changes..." -ForegroundColor Cyan
git add src/content public

$changed = git status --porcelain src/content public
if ([string]::IsNullOrWhiteSpace($changed)) {
    Write-Host "No content changes to publish. Done." -ForegroundColor DarkGray
    exit 0
}

$stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "Publish content ($stamp)"
Write-Host "Pushing..." -ForegroundColor Cyan
git push

Write-Host "`nDone. GitHub Actions is rebuilding - live in ~2 min." -ForegroundColor Green