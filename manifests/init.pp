# Class: eclipse
#
# This class installs eclipse and some useful components
#
# Parameters:
#  - method: the method by which to get the package. If 'wget' then the download paremeters below will be used, if 'package' then the package paremeter will be used, if 'file' then file path parmater will be used  (Default: wget)
#  - downloadurl: where to download the package from (Default: http://www.eclipse.org/downloads/download.php?file=/eclipse/downloads/drops4/R-4.2-201206081400/eclipse-SDK-4.2-linux-gtk-x86_64.tar.gz&url=http://eclipse.mirrorcatalogs.com/eclipse/downloads/drops4/R-4.2-201206081400/eclipse-SDK-4.2-linux-gtk-x86_64.tar.gz&mirror_id=1119)
#  - downloadfile: the file the wget or local file makes (Default: 'eclipse-SDK-4.2-linux-gtk-x86_64.tar')
#  - package: the package to use if downloading eclipse from a package manager (Default: 'eclipse')
#  - filesource: the path to use if it using a method of file (Default: undef)
#  - owner: the owner to use if it using a method of file (Default: 'root')
#  - group: the group to use if it using a method of file (Default: 'root')
#  - mode: the mode to use if it using a method of file (Default: 'root')
#  - wgettimeout: how longer to wait for the wget command to time out (Default: 1800)
#  - pluginrepositories: repositories of plugins to search in (Default: ['http://download.eclipse.org/releases/juno/'])
#  - pluginius: the ius to install (Default: [])

# Sample Usage:
#  # Get php eclipse package:
#  ::eclipse{"eclipsephp":
#  		downloadurl=>'http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/helios/SR2/eclipse-php-helios-SR2-linux-gtk-x86_64.tar.gz&url=http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/helios/SR2/eclipse-php-helios-SR2-linux-gtk-x86_64.tar.gz&mirror_id=272',
#		downloadfile=>'eclipse-php-helios-SR2-linux-gtk-x86_64.tar.gz'
#  }
#
define eclipse(
	$method='wget',
	$downloadurl='http://www.eclipse.org/downloads/download.php?file=/eclipse/downloads/drops4/R-4.2-201206081400/eclipse-SDK-4.2-linux-gtk-x86_64.tar.gz&url=http://eclipse.mirrorcatalogs.com/eclipse/downloads/drops4/R-4.2-201206081400/eclipse-SDK-4.2-linux-gtk-x86_64.tar.gz&mirror_id=1119',
	$downloadfile='eclipse-SDK-4.2-linux-gtk-x86_64.tar.gz',
	$package='eclipse',
	$filesource=undef,
	$owner = 'root',
	$group = 'root',
	$mode = '0644',
	$wgettimeout=1800,
	$pluginrepositories = ['http://download.eclipse.org/releases/juno/'],
	$timeout=900,
	$pluginius = []
) {
	include eclipse::params
	#creates tests for commandline execution
	$wgetcreates = "${eclipse::params::downloadpath}${downloadfile}"
	$finalcreates = "${eclipse::params::installpath}eclipse"
	$simlinkcreates = "${eclipse::params::simlinkto}/eclipse"
	$applicationpath = "${eclipse::params::installpath}/eclipse/eclipse"
	
	# commands to be run by exec
	$wgetcommand ="wget -O '${wgetcreates}' '${downloadurl}'"
	$unpackcommand = "tar -C '${eclipse::params::installpath}' -zxvf '${wgetcreates}'"
	$modeclipse = "chmod -R 775 '${finalcreates}'"
	$simlinktobin = "ln -s '${applicationpath}' '${simlinkcreates}'"
    
	if $method == 'wget' {
		# Downloads eclipse package
		exec {"geteclipse":
			command=>$wgetcommand,
			cwd=> $eclipse::params::executefrom,
			path=> $eclipse::params::execlaunchpaths,
			creates=>$wgetcreates,
			logoutput=> on_failure,
			timeout     => $wgettimeout,
			#require=>file["installersdirectory"]
		}
		
		 # Decompresses eclipse
	    exec {"upackeclipse":
	      command=>$unpackcommand,
	      cwd=> $eclipse::params::executefrom,
	      path=> $eclipse::params::execlaunchpaths,
	      creates=>$finalcreates,
	      logoutput=> on_failure,
	      require=>Exec["geteclipse"]
	    }
    
	    # Mod eclipse
	    exec {"modeclipse":
	      command=>$modeclipse,
	      cwd=> $eclipse::params::executefrom,
	      path=> $eclipse::params::execlaunchpaths,
	      logoutput=> on_failure,
	      require=>Exec["upackeclipse"]
	    }
    
	    # Make a simlink in bin
	    exec {"simlinkeclipse":
	      command=>$simlinktobin,
	      cwd=> $eclipse::params::executefrom,
	      path=> $eclipse::params::execlaunchpaths,
	      creates=>$simlinkcreates,
	      logoutput=> on_failure,
	      require=>Exec["modeclipse"]
	    }
	
	} elsif $method == 'file' {
	    file {"eclipsefile":
		    path => $wgetcreates,
			owner => $owner,
			group => $group,
			mode => $mode,
			source => $filesource;
		}
			
		# Mod eclipse
		exec {"modeclipse":
			command=>$modeclipse,
			cwd=> $eclipse::params::executefrom,
			path=> $eclipse::params::execlaunchpaths,
			logoutput=> on_failure,
			require=>Exec["upackeclipse"]
		}
			
		# Make a simlink in bin
		exec {"simlinkeclipse":
			command=>$simlinktobin,
			cwd=> $eclipse::params::executefrom,
			path=> $eclipse::params::execlaunchpaths,
			creates=>$simlinkcreates,
			logoutput=> on_failure,
			require=>Exec["modeclipse"]
		}
		
	} elsif $method == 'package' {
		package {"eclipse":
			name=>"eclipse",
			ensure=>$method
		}
	}
	
	
	if ($method == 'file') or ($method == 'wget') {
	    # Put the eclipse icon on the desktop
	    file{"eclipse.desktop":
	      path=>"${eclipse::params::desktopfilepath}/eclipse.desktop",
	      ensure=>"present",
	      content=>template("eclipse/eclipse.desktop.erb")
	    }
  	}
	
	if pluginius != undef {
		::eclipse::plugin{"eclipseinstallplugins":
			timeout=>$timeout,
			pluginrepositories=>$pluginrepositories,
			pluginius=>$pluginius
		}
	}
}
