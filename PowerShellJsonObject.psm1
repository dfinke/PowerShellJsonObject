function psjo {
    [CmdletBinding()]
    param(
        [Switch] $a,
        [Switch] $c <#,
        [Parameter(Mandatory = $false)] $depth = 5 #>
    )
    <#
        .Example
        psjo name=Jane
        {"name":"Jane"}

        .Example
        psjo point=$(psjo x=10 y=20)

        {
            "point":  {
                        "x":  10,
                        "y":  20
                    }
        }
    #>
    $depth = 5

    if ($a) {
        $p = @{compress = $c; AsArray = $true }
        ConvertTo-Json -InputObject ($args) @p
        
        return
    }

    $dict = [ordered]@{ }
    foreach ($item in $args) {
        $key, $value = $item.split('=')
        try {
            $value = ConvertFrom-Json $value
        }
        catch {
        }
        $dict.$key = $value
    }

    try {
        ConvertTo-Json $dict -Depth $depth
    }
    catch {

    }
    
}

psjo number=123 float=123.12 string="this is a string" otherstring=foobar object= { \"a\":true } array=[1, 2, 3] boolean=true -verbose
