
<#
    ...cd to my preferred PWD
    ...set up my prompt
    ...run code that doesn't work in the deferred scriptblock
          (i.e. setting [console]::OutputEncoding)
#>


$Deferred = {
    # . "/home/freddie/.local/share/chezmoi/PSHelpers/Console.ps1"
    # . "/home/freddie/.local/share/chezmoi/PSHelpers/git_helpers.ps1"
    # ...other slow code...

    Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete

    # Binds CTRL-W to delete the word to the left like bash does
    Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord

    # Import-Module Terminal-Icons

    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}


# https://seeminglyscience.github.io/powershell/2017/09/30/invocation-operators-states-and-scopes
$GlobalState = [psmoduleinfo]::new($false)
$GlobalState.SessionState = $ExecutionContext.SessionState

# to run our code asynchronously
$Runspace = [runspacefactory]::CreateRunspace($Host)
$Powershell = [powershell]::Create($Runspace)
$Runspace.Open()
$Runspace.SessionStateProxy.PSVariable.Set('GlobalState', $GlobalState)

# ArgumentCompleters are set on the ExecutionContext, not the SessionState
# Note that $ExecutionContext is not an ExecutionContext, it's an EngineIntrinsics 😡
$Private = [Reflection.BindingFlags]'Instance, NonPublic'
$ContextField = [Management.Automation.EngineIntrinsics].GetField('_context', $Private)
$Context = $ContextField.GetValue($ExecutionContext)

# Get the ArgumentCompleters. If null, initialise them.
$ContextCACProperty = $Context.GetType().GetProperty('CustomArgumentCompleters', $Private)
$ContextNACProperty = $Context.GetType().GetProperty('NativeArgumentCompleters', $Private)
$CAC = $ContextCACProperty.GetValue($Context)
$NAC = $ContextNACProperty.GetValue($Context)
if ($null -eq $CAC)
{
    $CAC = [Collections.Generic.Dictionary[string, scriptblock]]::new()
    $ContextCACProperty.SetValue($Context, $CAC)
}
if ($null -eq $NAC)
{
    $NAC = [Collections.Generic.Dictionary[string, scriptblock]]::new()
    $ContextNACProperty.SetValue($Context, $NAC)
}

# Get the AutomationEngine and ExecutionContext of the runspace
$RSEngineField = $Runspace.GetType().GetField('_engine', $Private)
$RSEngine = $RSEngineField.GetValue($Runspace)
$EngineContextField = $RSEngine.GetType().GetFields($Private) | Where-Object {$_.FieldType.Name -eq 'ExecutionContext'}
$RSContext = $EngineContextField.GetValue($RSEngine)

# Set the runspace to use the global ArgumentCompleters
$ContextCACProperty.SetValue($RSContext, $CAC)
$ContextNACProperty.SetValue($RSContext, $NAC)

$Wrapper = {
    # Without a sleep, you get issues:
    #   - occasional crashes
    #   - prompt not rendered
    #   - no highlighting
    # Assumption: this is related to PSReadLine.
    # 20ms seems to be enough on my machine, but let's be generous - this is non-blocking
    Start-Sleep -Milliseconds 200

    . $GlobalState {. $Deferred; Remove-Variable Deferred}
}

$null = $Powershell.AddScript($Wrapper.ToString()).BeginInvoke()




# https://github.com/devblackops/Terminal-Icons/issues/150#issuecomment-2678944455
# Helps deal with slow terminal startups due to this module.
# Register-EngineEvent -SourceIdentifier 'PowerShell.OnIdle' -MaxTriggerCount 1 -Action {
#     Import-Module -Name Terminal-Icons -Global
#     Import-Module posh-git
# } | Out-Null


# $env:STAR

# Set-PSReadLineOption -PredictionSource History
# Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete

# # Binds CTRL-W to delete the word to the left like bash does
# Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord


# Set-PsFzfOption -TabExpansion
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'



# Import-Module -Name Terminal-Icons
# Import-Module -Name Terminal-Icons

# Oh my posh stuff
# Import-Module oh-my-posh
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/theme.omp.json" | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
# Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# PSfzf
Import-Module PSFzf
# Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                -PSReadlineChordReverseHistory 'Ctrl+r'
# Override default tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Import-Module -Name Terminal-Icons

# eza - ls alternative with icons
function lsa() {
    eza -1l --icons always  --group-directories-first --show-symlinks
}
Set-Alias -Name ls -Value lsa

function Invoke-Starship-PreCommand {
  $host.ui.RawUI.WindowTitle = "$pwd"
}

Invoke-Expression (&starship init powershell)


# Invoke-Expression (& { (zoxide init powershell | Out-String) })
