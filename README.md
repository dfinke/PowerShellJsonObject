# PowerShell Json Object (psjo)

JSON output from PowerShell.

Modelled after https://github.com/jpmens/jo

One way in attempting to get PowerShell scripts to produce valid JSON. You’ve likely seen something like this before:

```powershell
'{"name":"Jane"}'
```

Or

```powershell
'{{"name":"{0}"}}' -f 'Jane'
```

Another way

```ps
PS C:\> ConvertTo-Json @{name='Jane'}
```

```powershell
'{"name":"Jane"}'
```

## Enter psjo

```ps
PS C:\> psjo name=Jane
```

```powershell
{"name":"Jane"}
```

```ps
PS C:\> psjo name=Jane b=1 c d=$(get-date) e=$($env:ComSpec)
```

```powershell
{
    "name":  "Jane",
    "b":  "1",
    "c":  null,
    "d":  "02/13/2020 18:49:44",
    "e":  "C:\\WINDOWS\\system32\\cmd.exe"
}
```

```powershell
PS C:\> psjo name=Jane b=1 c d=$(get-date) e=$($env:ComSpec)

{
    "name":  "Jane",
    "b":  "1",
    "c":  null,
    "d":  "02/13/2020 18:49:44",
    "e":  "C:\\WINDOWS\\system32\\cmd.exe"
}
```

## Handles Nested JSON

```ps
PS C:\> psjo point=$(psjo x=10 y=20)
```

```powershell
{
    "point":  {
                "x":  10,
                "y":  20
            }
}
```

### Very nested

```ps
PS C:\> psjo glossary=$(
    psjo title="example glossary" GlossDiv=$(
        psjo title=S GlossEntry=$(
            psjo ID=SGML SortAs=SGML GlossTerm='Standard Generalized Markup Language' Acronym=SGML Abbrev='ISO 8879:1986' GlossDef=$(
                psjo para='A meta-markup language, used to create markup languages such as DocBook.'
            ) GlossSee=markup
        )
    )
)
```

```powershell
{
    "glossary": {
        "title": "example glossary",
        "GlossDiv": {
            "title": "S",
            "GlossEntry": {
                "ID": "SGML",
                "SortAs": "SGML",
                "GlossTerm": "Standard Generalized Markup Language",
                "Acronym": "SGML",
                "Abbrev": "ISO 8879:1986",
                "GlossDef": {
                    "para": "A meta-markup language, used to create markup languages such as DocBook."
                },
                "GlossSee": "markup"
            }
        }
    }
}
```

## Arrays

```powershell
psjo -a summer spring winter

[
  "summer",
  "spring",
  "winter"
]
```