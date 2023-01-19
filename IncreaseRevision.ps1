param (
    $csprojpath # path to the file i.e. 'C:\Users\...\Code\csproj powershell\MySmallLibrary.csproj'
)



$xml = [Xml] (Get-Content $csprojPath)
$version = [Version] $xml.Project.PropertyGroup.Version
$revision = $version.Revision+1 
$Field = $PSVersionTable.PSVersion.GetType().GetField('_Revision','static,nonpublic,instance')
$Field.SetValue($version,$revision)
$xml.Project.PropertyGroup.Version = [string] $version
$xml.Save($csprojpath)

