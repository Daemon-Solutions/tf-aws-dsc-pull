configuration Sample_xDscPullServer
{ 
    param  
    ( 
            [string[]]$NodeName = 'localhost', 

            [ValidateNotNullOrEmpty()] 
            [string] $certificateThumbPrint,

            [Parameter(Mandatory)]
            [ValidateNotNullOrEmpty()]
            [string] $RegistrationKey 
     ) 


     Import-DSCResource -ModuleName xPSDesiredStateConfiguration
     Import-DSCResource -ModuleName PSDesiredStateConfiguration

     Node $NodeName 
     { 
         WindowsFeature DSCServiceFeature 
         { 
             Ensure = 'Present'
             Name   = 'DSC-Service'             
         } 

         WindowsFeature WebTools {
         Ensure = "Present"
         Name = "Web-Mgmt-Tools"
     }

         xDscWebService PSDSCPullServer 
         { 
             Ensure                   = 'Present' 
             EndpointName             = 'PSDSCPullServer' 
             Port                     = 8080 
             PhysicalPath             = "$env:SystemDrive\inetpub\PSDSCPullServer" 
             CertificateThumbPrint    = $certificateThumbPrint          
             ModulePath               = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules" 
             ConfigurationPath        = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration" 
             State                    = 'Started'
             DependsOn                = '[WindowsFeature]DSCServiceFeature'     
             UseSecurityBestPractices = $false
         } 

        File RegistrationKeyFile
        {
            Ensure          = 'Present'
            Type            = 'File'
            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
            Contents        = $RegistrationKey
        }
    }
}


$guid=(Get-SSMParameterValue -Name "dsc-registrationkey" -WithDecryption $true).Parameters.value

$ThumbPrint=Get-Content C:\dsc\cert_thumprint.txt
Sample_xDSCPullServer -certificateThumbprint $ThumbPrint -RegistrationKey $guid -OutputPath c:\dsc\server_config

# Run the compiled configuration to make the target node a DSC Pull Server
Start-DscConfiguration -Path c:\dsc\server_config -Wait -Verbose