configuration LAMPServer {
   Import-DSCResource -module nx
   #import module before executing this
   #https://docs.microsoft.com/en-us/powershell/dsc/lnxbuiltinresources

   Node localhost {

        $requiredPackages = @("apache2","apache2-utils","php","php-mysql","libapache2-mod-php","mysql-server")
        $enabledServices = @("apache2","mysql")

        #Ensure packages are installed
        ForEach ($package in $requiredPackages){
            nxPackage $Package{
                Ensure = "Present"
                Name = $Package
                PackageManager = "apt"
            }
        }

        #Ensure daemons are enabled
        ForEach ($service in $enabledServices){
            nxService $service{
                Enabled = $true
                Name = $service
                Controller = "SystemD"
                State = "running"
            }
        }
   }
}
