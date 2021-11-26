<#
    Create header snippet file
#>
function headerFile {
    param(
        [String] $name,
        [String] $snippetFile
    )
    "{" > $snippetFile
    '   "' + $name + '": {' >> $snippetFile
    '       "prefix": "' + $name + '",' >> $snippetFile
    '       "body": [' >> $snippetFile
}

<#
    Create body snippet file
#>
function bodyFile {
    param(
        [String] $file,
        [String] $snippetFile
    )

    $text = Get-Content -Path $file

    foreach($line in $text) {
        $newLine = $line -replace '    ', '\t'
        $newLine = $newLine -replace '"', '\"'

        '           "' + $newLine + '",' >> $snippetFile
    }
}

<#
    Create footer snippet file
#>
function footerFile {
    param(
        [String] $snippetFile
    )
    "       ]" >> $snippetFile
    "   }" >> $snippetFile
    "}" >> $snippetFile
}

Write-Host "Iniciando criacao de snippets..."
Write-Host ""

$folder = pwd
$files = Get-ChildItem -file .\models\*

foreach($file in $files) {
    $filename = $file.Basename
    $snippetFile = "snippets\${filename}.code-snippets"

    headerFile $filename $snippetFile
    bodyFile $file $snippetFile
    footerFile $snippetFile

	$fileRaw = Get-Content -Raw $snippetFile
	$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
	[System.IO.File]::WriteAllLines("${folder}\${snippetFile}", $fileRaw, $Utf8NoBomEncoding)

    Write-Host "Snippet ${file} criado!"
}

Write-Host ""
Write-Host "Copiando snippets para pasta do VSCode..."
Copy-Item .\snippets\* -Destination $HOME\AppData\Roaming\Code\User\snippets\

Write-Host ""
Write-Host "Finalizado!"
