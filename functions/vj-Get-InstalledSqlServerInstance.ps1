function vj-Get-InstalledSqlServerInstance {
    <##################################################
    .SYNOPSIS
        This function returns the installed SQL Server instance(s) for a given host or array of hosts.
    
    .DESCRIPTION
        This function returns the installed SQL Server instance(s) for a given host or array of hosts.
    
    .PARAMETER ComputerName
        The computer name or computer names to evaluate.  Default is localhost.
               
    .EXAMPLE
        This will return the installed SQL Server instances on a given computer or array of computers.

        Get-InstalledSqlServerInstance -ComputerName (<computer_name>)

    .EXAMPLE
        This will return the installed SQL Server instances on localhost.
        
        Get-InstalledSqlServerInstance
       
    .NOTES
        Author: James Burnside

    .LINK
        https://www.sqlshack.com/six-methods-to-automatically-discover-sql-server-instances/
    ##################################################>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false,Position=0)][String[]]$ComputerName
    )

    begin {
        Write-Verbose "Getting Install SQL Server Instances ..."
        $Results = @()
    }

    process {
        if ($ComputerName) {
            $RegistryResults = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server'
            }
            $PSComputerName = $RegistryResults.PSComputerName
            $InstalledSqlServerInstances = $RegistryResults.InstalledInstances
        }
        else {
            $InstalledSqlServerInstances = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances
            $PSComputerName = $env:COMPUTERNAME
        }

        foreach ($SqlInstance in $InstalledSqlServerInstances) {
            $Results += [PSCustomObject]@{
                ComputerName = $PSComputerName 
                InstanceName = $SqlInstance
                ServerInstance = ($PSComputerName, $SqlInstance.Replace("MSSQLSERVER", "DEFAULT")) -join ("\")
            }
        }

        return $Results

    }

    end {
        Write-Verbose "Getting Install SQL Server Instances Complete."
    }
}