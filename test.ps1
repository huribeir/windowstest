#$ErrorActionPreference = 'Stop'
#Get-ACMCertificate


#BeforeInstallWithTryCatch.PS1
$errvar # Define global variable $errvar for storage of all error messages.
# Create Try, Catch, and Finally blocks.
# The Try block typically contains the deployment lifecycle event code
# The Catch block runs if the Try block fails and sets the script exit code to 1.
# The Finally block writes a time stamp and the contents of the global error variable to the specified log file.
Try
{
  $ErrorActionPreference = 'Stop' # Causes PowerShell to stop execution for both terminating and non-terminating errors.
  Get-InstalledModule -ev errvar # invoke -ev to write errors to the global error variable.
  Get-ACMCertificate -ev errvar # Cause a missing parameter error and invoke -ev
  Get-Module -ev errvar
  net user thiswillerror > c:\stderr.log 2>&1 # Use legacy error logging and pass the ErrOut channel to stdout.
}
Catch # The Catch block runs if an error occurs in the Try block.
{
  Write-Warning $_
    if ($_ -ne "") {$errvar = $_} # If $_ is not an empty string, set the value of the global error variable to the contents of $_.
    exit 1 # Exit the session and return an exit code of 1, which causes the CodeDeploy lifecycle event to fail
}
Finally
{
  $time=Get-Date # Create a timestamp variable and set value to the current date and time.
  "Attempted to run script at $time with error $errvar " | out-file C:\temp\scriptExec.log -Append    
  # Appends string and error to designated file.
}
