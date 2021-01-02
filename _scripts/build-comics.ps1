# $var = 42
# $var
# Verb-Substantiv
# Get-Content
# ConvertFrom-Json

<#
Set-Content
$zb = 'abc {0} def'
$zb -f "xxx"
#>
$comicTable = get-content -Path "$PSScriptRoot\..\_database\comics.json" | ConvertFrom-Json
$comic = get-content -Path "$PSScriptRoot\..\_templates\comic.md" -Raw
$comics = get-content -Path "$PSScriptRoot\..\_templates\comics.md" -Raw

Remove-Item -Path "$PSScriptRoot\..\Comics\*"
$indexEntries = foreach ($comicEntry in $comicTable | Sort-Object Name) {
	$comic -f $comicEntry.Name, $comicEntry.Description ,$comicEntry.Author,$comicEntry.Released,$comicEntry.Concluded,$comicEntry.Volumes,$comicEntry.ID | 
	Set-Content -path "$PSScriptRoot\..\Comics\$($comicEntry.ID).md"
	"+ [$($comicEntry.Name)](Comics/$($comicEntry.ID).html)"
}

$comics -f ($indexEntries -join "`n") | Set-Content -path "$PSScriptRoot\..\comics.md"