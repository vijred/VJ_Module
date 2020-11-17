function New-FunctionName {
    <##################################################
    .SYNOPSIS
        This function ...
    
    .DESCRIPTION
        This function ...
    
    .PARAMETER xxxxxxxxxx
        This parameter ....
               
    .EXAMPLE
        New-FunctionName -Parameter xxxxxxxxxx
    
    .INPUTS
        None
    
    .OUTPUTS
        None
    
    .NOTES
        Author: Vijay Kundanagurthi
    
    .LINK
        https://xxxxxxxxxx.com
    ##################################################>
    [CmdletBinding()]
    param (   
        [Parameter(Mandatory=$false)][String]$xxxxxxxxxx
    )

    begin {
        Write-Verbose "xxxxxxxxxx ..."

        <##################################################
        Initializing Variables
        ##################################################>

        #region Initializing Variables

        #endregion Initializing Variables
    }

    process {
        try {
            Write-Host "xxxxxxxxxx" -ForegroundColor "Green"
        }
        catch {
            throw $_
        }
    }

    end {
        Write-Verbose "xxxxxxxxxx Complete."
    }
}