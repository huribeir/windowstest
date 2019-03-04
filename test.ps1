#$ErrorActionPreference = 'Stop'
#Get-ACMCertificate


#BeforeInstallWithTryCatch.PS1


# Define global variables. $errvar will be used to store error messages upon command failures. This variable will be used to output the error message to a log file.


$errvar


# Here is where we set up the Try, Catch, and Finally blocks. The Try block is where we add the code that we want to execute.


# The Catch block contains code that will execute if code in the Try block fails and generates an error.


# The Finally block is used in this example to write a time stamp and the contents of $errvar to the specified log file.


Try


{


        $ErrorActionPreference = ‘Stop’    # Change how PowerShell responds to non-terminating errors, this causes PowerShell to stop execution for all errors.


        Get-InstalledModule -ev errvar    # The -ev parameter (-ErrorVariable) captures and writes errors to the global variable. It is set on each command.


        Get-ACMCertificate -ev errvar    # This command will generate a missing parameter error


        Get-Module -ev errvar


        net user thiswillerror > c:\stderr.log 2>&1     # To handle the error outside of the try catch using a traditional DOS method


}


Catch


{


    Write-Warning $_


        if ($_ -ne "") {$errvar = $_}


        exit 1&    #This command instructs the session to exit and return an exit code value of 1, which causes CodeDeploy to fail the deployment.


}


Finally


{


    $time=Get-Date    # Defines a time variable with the current date and time.


    "Attempt to run the script was made at $time with error $errvar " | out-file C:\temp\scriptExec.log -Append    # Outputs string and error to designated file


}


# Append option will add to any existing content
