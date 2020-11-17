function vj-Get-SQLAgentLatestJobStatus{
    <##################################################
    .SYNOPSIS
        This function is to find Latest SQL Agent Job status
    
    .DESCRIPTION
        This function is to find Latest SQL Agent Job status
    
    .PARAMETER SQLInstanceName
        SQL Instance where Server needs to be searched        
               
    .EXAMPLE
        vj-Get-SQLAgentLatestJobStatus -SQLInstanceName .
    
    .INPUTS
        None
    
    .OUTPUTS
        List of servers in Grid view
    
    .NOTES
        Author: Vijay Kundanagurthi
    
    .LINK
        https://notdocumented.paychex
    ##################################################>
    [CmdletBinding()]
    param (   
        [Parameter(Mandatory=$false)][String]$SQLInstanceName=''
    )

    begin {
        Write-Verbose "SQL Server Name - $SQLInstanceName"

        <##################################################
        Initializing Variables
        ##################################################>

        #region Initializing Variables
		$Servername=$SQLInstanceName

		 $tsql=";WITH CTE as 
        (select name, run_date,run_time,run_duration 

        , RIGHT('0' + RTRIM((run_duration/10000)%60), 2)
        + ':' + RIGHT('0' + RTRIM((run_duration/100)%100), 2)
        + ':' + RIGHT('0' + RTRIM((run_duration)%100), 2) AS Run_duration_2 

        ,ROW_NUMBER() OVER (PARTITION BY name order by run_date+run_time desc) as myrank
        ,case 
        when run_status =1 then 'Success'
        when run_status =0 then  'Fail'
        when run_status =3  then 'Cancelled'
        when run_status =2  then 'Retry'
        when run_status =4  then 'InProgress'
        else 'unknown'
        end as ExecutionStatus

        from msdb..sysjobs sj
        join msdb..sysjobhistory sjh on sjh.job_id = sj.job_id 
        where 1=1
        and step_id = 0
        )
        select @@SERVERNAME as Servername, name, run_date, run_time, run_duration, Run_duration_2, ExecutionStatus from CTE where myrank = 1 
        order by 1 desc 
        "
		 
        #endregion Initializing Variables
    }

    process {
		try {
			$results=Invoke-Sqlcmd -ServerInstance $Servername -Query $tsql
			if ($results -ne $null)
			{
                #$results | Out-GridView
                return $results
			}
			else
			{
				Write-Host "Unable to find any servers with name - $($SearchServerName)"  -ForegroundColor Red
			}
        }
        catch {
            throw $_
        }
    }


    end {
        Write-Verbose "vj-Get-SQLAgentLatestJobStatus function Complete."
        }
}
