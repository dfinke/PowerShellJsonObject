function psjo {
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
        try {
            $key, $value = $item.split('=')
        }
        catch {
            $value = $("'" + $item + "'" | ConvertFrom-Json)
        }

        try {
            $value = $( $value | ConvertFrom-Json)
        }
        catch {
            try {
                $value = $( '{' + $value + '}'| ConvertFrom-Json)
            } catch {
                if ( "$key" -eq "") {
                    $key, $value = $value.split('=')
                } elseif ($value -like "*=*") {
                    $value = $( '{' + $($value -replace "="; ":") + '}' | ConvertFrom-Json | ConvertTo-Json)
                }
            }
        }
        $dict.$key = $value
    }

    try {
        ConvertTo-Json $dict -Depth $depth
    }
    catch {
        $dict
    }
    
}

psjo number=123
psjo float=123.12
psjo string="this is a string"
psjo otherstring=foobar
psjo object={\"a\":true}
psjo array=[1, 2, 3]
psjo boolean=true

psjo number=123 float=123.12 string="this is a string" otherstring=foobar object='{"a":true}' array='[1, 2, 3]' boolean=true

psjo number=123 float=123.12 string="this is a string" otherstring=foobar object={\"a\":true} array=[1, 2, 3] boolean=true
