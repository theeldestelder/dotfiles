# taken from https://stackoverflow.com/a/44411205

function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)" -ForegroundColor "blue"
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)" -ForegroundColor "yellow"
    }
}

function prompt {
    # set title to the current folder
    $host.ui.RawUI.WindowTitle = "$pwd"	

    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('>' * ($nestedPromptLevel + 1)) "

    if (Test-Path .git) {
        Write-Host ""
        Write-Host $path -NoNewline -ForegroundColor "green"
        Write-BranchName
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        # $(Get-Date -format 'HH:mm:ss') - use for timestamps
        Write-Host ""
        Write-Host $path -ForegroundColor "green"
    }

    return $userPrompt
}

Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete

# Binds CTRL-W to delete the word to the left like bash does
Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord
Import-Module posh-git

Import-Module -Name Terminal-Icons

# Oh my posh stuff
# Import-Module oh-my-posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/theme.omp.json" | Invoke-Expression