Import-Module Pode.Web

Start-PodeServer {
    Add-PodeEndpoint -Address localhost -Port 8083 -Protocol Http
    Use-PodeWebTemplates -Title 'My Form' -Theme Light
    Add-PodeWebPage -Name 'Form' -Displayname 'Form' -ScriptBlock {
        New-PodeWebForm -Name "myForm" -Content @(
            New-PodeWebTextbox -Name "user" -Displayname "Username"
            New-PodeWebRange -Name 'Days' -Max 120 -Value 1 -ShowValue
            ) -ScriptBlock {
            $data = $Webevent.data['user']
            $data += "&Days=$($Webevent.data['Days'])"
            Move-PodeWebPage -Name 'Result' -DataValue $data
        }
    }
    Add-PodeWebPage -Name 'Result' -Displayname 'Result' -Scriptblock {
        if ( $WebEvent.Query['value']) {
            New-PodeWebTextbox -Name "Username" -Value $WebEvent.Query['value'] -ReadOnly
            New-PodeWebTextbox -Name "Days" -Value $WebEvent.Query.Days -ReadOnly
        } else { }
    }
}