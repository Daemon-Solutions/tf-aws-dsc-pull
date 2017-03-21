configuration web_server
{



Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Node localhost
{
    
    WindowsFeature Web-Asp-Net45 { Ensure = 'Present'; Name = 'Web-Asp-Net45' }
    WindowsFeature Web-Mgmt-Service { Ensure = 'Present'; Name = 'Web-Mgmt-Service' }
    WindowsFeature Web-Server { Ensure = 'Present'; Name = 'Web-Server' }
    WindowsFeature Web-Default-Doc { Ensure = 'Present'; Name = 'Web-Default-Doc' }
    WindowsFeature Web-Dir-Browsing { Ensure = 'Present'; Name = 'Web-Dir-Browsing' }
    WindowsFeature Web-Http-Errors { Ensure = 'Present'; Name = 'Web-Http-Errors' }
    WindowsFeature Web-Static-Content { Ensure = 'Present'; Name = 'Web-Static-Content' }
    WindowsFeature Web-Dyn-Compression { Ensure = 'Present'; Name = 'Web-Dyn-Compression' }
    WindowsFeature Web-Stat-Compression { Ensure = 'Present'; Name = 'Web-Stat-Compression' }
    WindowsFeature Web-Filtering { Ensure = 'Present'; Name = 'Web-Filtering' }
    WindowsFeature Web-ISAPI-Ext { Ensure = 'Present'; Name = 'Web-ISAPI-Ext' }
    WindowsFeature Web-ISAPI-Filter { Ensure = 'Present'; Name = 'Web-ISAPI-Filter' }
    WindowsFeature Web-HTTP-Redirect { Ensure = 'Present'; Name = 'Web-HTTP-Redirect' }
    WindowsFeature Web-HTTP-Logging { Ensure = 'Present'; Name = 'Web-HTTP-Logging' }
    WindowsFeature Web-Mgmt-Console { Ensure = 'Present'; Name = 'Web-Mgmt-Console' }
    WindowsFeature Telnet-Client  { Ensure = 'Present'; Name = 'Telnet-Client' }
    
}
}
web_server -outputpath C:\dsc\configs
New-DscChecksum -Configurationpath C:\dsc\configs -outpath c:\dsc\configs -force
Move-Item C:\dsc\configs\localhost.mof 'C:\Program Files\WindowsPowerShell\DscService\Configuration\web_server.mof' -Force
Move-Item C:\dsc\configs\localhost.mof.checksum 'C:\Program Files\WindowsPowerShell\DscService\Configuration\web_server.mof.checksum' -Force