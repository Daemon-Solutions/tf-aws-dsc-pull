configuration SMTP_Server
{
Import-DscResource -ModuleName 'PSDesiredStateConfiguration'


Node localhost
{
    WindowsFeature SMTP
    {
        name ="smtp-server"
        Ensure = "Present"
    }

    WindowsFeature Web-WMI
    {
        name="Web-WMI"
        ensure="Present"
    }

    
}}
SMTP_Server -outputpath C:\dsc\configs
New-DscChecksum -Configurationpath C:\dsc\configs -outpath c:\dsc\configs -force
Move-Item C:\dsc\configs\localhost.mof 'C:\Program Files\WindowsPowerShell\DscService\Configuration\smtp_server.mof' -Force
Move-Item C:\dsc\configs\localhost.mof.checksum 'C:\Program Files\WindowsPowerShell\DscService\Configuration\smtp_server.mof.checksum' -Force
