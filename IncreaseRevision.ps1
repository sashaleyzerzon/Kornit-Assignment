param (
    $csprojpath # path to the file i.e. 'C:\Users\...\Code\csproj powershell\MySmallLibrary.csproj'
)


Write-Host "CsprojPath: " $csprojpath
$xml = [Xml] (Get-Content $csprojPath)
$version = [Version] $xml.Project.PropertyGroup.Version
Write-Host "Current Version: " $version
$revision = $version.Revision+1 
$Field = $PSVersionTable.PSVersion.GetType().GetField('_Revision','static,nonpublic,instance')
$Field.SetValue($version,$revision)
Write-Host "New Version: " $version
$xml.Project.PropertyGroup.Version = [string] $version
$xml.Save($csprojpath)

