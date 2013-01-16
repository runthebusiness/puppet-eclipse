# Class: eclipse::plugin::pdt
#
# This class installs eclipse php pdt plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)
#  - checkforpluginfolders: an array of folders to check for in the eclipse/plugins directory, if they are all found then the plugins in pluginius will not install (Default: ['org.eclipse.php'])

# Sample Usage:
# 

define eclipse::plugin::pdt(
	$pluginrepositories='http://download.eclipse.org/releases/juno/',
	$suppresserrors=false,
	$checkforpluginfolders=['org.eclipse.php']
) {
	::eclipse::plugin{"eclipseinstallpdt":
		pluginrepositories=>$pluginrepositories,
		pluginius=>['org.eclipse.php.sdk.feature.group'],
		suppresserrors=>$suppresserrors,
		checkforpluginfolders=>$checkforpluginfolders
	}
}
