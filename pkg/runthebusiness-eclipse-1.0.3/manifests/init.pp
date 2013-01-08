# Class: eclipse
#
# This class installs eclipse and some useful components
#
# Parameters:
#  - method: the method by which to get the package. if not to "wget" it will be the "ensure" value for downloading the package from services such as apt (Default: wget)
#  - downloadurl: where to download the package from (Default: http://www.eclipse.org/downloads/download.php?file=/eclipse/downloads/drops4/R-4.2-201206081400/eclipse-SDK-4.2-linux-gtk-x86_64.tar.gz&url=http://eclipse.mirrorcatalogs.com/eclipse/downloads/drops4/R-4.2-201206081400/eclipse-SDK-4.2-linux-gtk-x86_64.tar.gz&mirror_id=1119)
#  - downloadfile: the file the wget makes (Default: 'eclipse-SDK-4.2-linux-gtk-x86_64.tar')
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
	$pluginrepositories = ['http://download.eclipse.org/releases/juno/'],
	$pluginius = []
) {
	include eclipse::params
	if $method == 'wget' {
		
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
	
		# Downloads eclipse package
		exec {"geteclipse":
			command=>$wgetcommand,
			cwd=> $eclipse::params::executefrom,
			path=> $eclipse::params::execlaunchpaths,
			creates=>$wgetcreates,
			logoutput=> on_failure,
			#require=>file["installersdirectory"]
		}
	
		# Decompresses eclipse
		exec {"upackeclipse":
			command=>$unpackcommand,
			cwd=> $eclipse::params::executefrom,
			path=> $eclipse::params::execlaunchpaths,
			creates=>$finalcreates,
			logoutput=> on_failure,
			require=>exec["geteclipse"]
		}
		
		# Mod eclipse
		exec {"modeclipse":
			command=>$modeclipse,
			cwd=> $eclipse::params::executefrom,
			path=> $eclipse::params::execlaunchpaths,
			logoutput=> on_failure,
			require=>exec["upackeclipse"]
		}
		
		# Make a simlink in bin
		exec {"simlinkeclipse":
			command=>$simlinktobin,
			cwd=> $eclipse::params::executefrom,
			path=> $eclipse::params::execlaunchpaths,
			creates=>$simlinkcreates,
			logoutput=> on_failure,
			require=>exec["modeclipse"]
		}
		
		# Put the eclipse icon on the desktop
		file{"eclipse.desktop":
			path=>"${eclipse::params::desktopfilepath}/eclipse.desktop",
			ensure=>"present",
			content=>template("eclipse/eclipse.desktop.erb")
		}
		
	} else {
		package {"eclipse":
			name=>"eclipse",
			ensure=>$method
		}
	}
	
	if pluginius != undef {
		::eclipse::plugin{"eclipseinstallplugins":
			pluginrepositories=>$pluginrepositories,
			pluginius=>$pluginius
		}
	}
}
