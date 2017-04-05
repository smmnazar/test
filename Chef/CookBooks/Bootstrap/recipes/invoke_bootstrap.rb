powershell_script 'bootstrap_process' do
  code <<-EOH
	$computer_name= "#{node['ComputerName']}"
	$OUPath = "#{node['OUPath']}"
	$Username = "#{node['Username']}"
	$Password = '#{node['Password']}'
	$DomainName = "#{node['DomainName']}"
	$svc_pwd = "#{node['svc_pwd']}"
	$serviceou = "#{node['serviceou']}"
	$prod_svc_user = "#{node['prod_svc_user']}"
	$prod_svc_pwd = '#{node['prod_svc_pwd']}'
	$lite_key = "#{node['lite_key']}"
	$lite_msg = "#{node['lite_msg']}"
	$base_folder = "#{node['base_folder']}"
	
	cd $base_folder
	###############################
	# Include file
	###
	. .\\Common\\SimpleLogger.ps1
	#################################
	# Call DB server script
	echo "Call DB server script"
	If($computer_name -like '*-DBS4W-*' -or $computer_name -like '*-JSS4W-*' -or $computer_name -like '*-DBA4W-*') { 
	    Write-Log -Message "Call Database PS"
		if ($computer_name -like '*-DBS4W-*') {
			C:\\0InstallFiles\\SQL2014\\setup.exe /ConfigurationFile=C:\\0DBSInstallFiles\\ConfigurationFile.DBS.complete_image.ini
			#Instead of restarting server, only restaring service to proceed further with Phase1 and Phase2 scripts....
			Stop-Service -Name 'MSSQLSERVER' -Force
			Start-Service -Name 'MSSQLSERVER'		
			Stop-Service -Name 'SQLSERVERAGENT' -Force
			Start-Service -Name 'SQLSERVERAGENT'
		}
		elseif ($computer_name -like '*-DBA4W-*') {
			C:\\0InstallFiles\\SQL2014\\setup.exe /ConfigurationFile=C:\\0DBAInstallFiles\\ConfigurationFile.DBA.complete_image.ini
			#Instead of restarting server, only restaring service to proceed further with Phase1 and Phase2 scripts....
			Stop-Service -Name 'mssqlserverolapservice' -Force
			Start-Service -Name 'mssqlserverolapservice'			
		}
		elseif ($computer_name -like '*-JSS4W-*') {
			C:\\0InstallFilesSE\\setup.exe /ConfigurationFile=C:\\0JSSInstallFiles\\ConfigurationFile.JSS.complete_image.ini
			Stop-Service -Name 'MSSQLSERVER' -Force
			Start-Service -Name 'MSSQLSERVER'		
			Stop-Service -Name 'SQLSERVERAGENT' -Force
			Start-Service -Name 'SQLSERVERAGENT'
		}
	    powershell -file "$base_folder\\DBServer\\Phase1\\DB-server-interface-phase1.ps1" -serviceou $serviceou -domain_name $DomainName -username $Username -password $Password -prodsvcuser $prod_svc_user -prodsvcpwd $prod_svc_pwd >> $base_folder\\Log\\DBServer-phase1.txt
		powershell -file "$base_folder\\DBServer\\Phase2\\DB-server-interface-phase2.ps1" -domain_name $DomainName -litekey $lite_key -litemsg $lite_msg >> $base_folder\\Log\\DBServer-phase2.txt
		powershell -file "$base_folder\\DBServer\\AdHocs\\AdHocs-Interface.ps1" >> $base_folder\\Log\\AdHocs.txt
	    Write-Log -Message "Done Database PS"
	}
	Else{
	    Write-Log -Message "$computer_name is not matching with Web server nor DB Server"
	}
  EOH
  guard_interpreter :powershell_script
end