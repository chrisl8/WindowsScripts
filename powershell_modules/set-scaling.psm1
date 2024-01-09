# https://stackoverflow.com/a/68215326/4982408
function Set-Scaling {
    # Posted by IanXue-MSFT on
    # https://learn.microsoft.com/en-us/answers/questions/197944/batch-file-or-tool-like-powertoy-to-change-the-res.html
    # $scaling = 0 : 100% (default)
    # $scaling = 1 : 125%
    # $scaling = 2 : 150%
    # $scaling = 3 : 175%
    # Note on some systems 0 may be 125% or higher and you will need to use negatives to get 100%
    # but this is a uint so you cannot.
    # https://learn.microsoft.com/en-us/answers/questions/197944/batch-file-or-tool-like-powertoy-to-change-the-res
    # In such cases -1 would be 4294967295, -2 would be 4294967294, etc.
    param($scaling)
    $source = @'
    [DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
    public static extern bool SystemParametersInfo(
                      uint uiAction,
                      uint uiParam,
                      uint pvParam,
                      uint fWinIni);
'@
    $apicall = Add-Type -MemberDefinition $source -Name WinAPICall -Namespace SystemParamInfo -PassThru
    $apicall::SystemParametersInfo(0x009F, $scaling, $null, 1) | Out-Null
}
