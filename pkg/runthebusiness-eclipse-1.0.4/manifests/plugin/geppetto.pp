# Class: eclipse::plugin::geppetto
#
# This class installs eclipse geppetto plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.cloudsmith.com/geppetto/updates')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)
#  - checkforpluginfolders: an array of folders to check for in the eclipse/plugins directory, if they are all found then the plugins in pluginius will not install (Default: ['org.cloudsmith.geppetto'])

# Sample Usage:

# 
define eclipse::plugin::geppetto(
	$pluginrepositories='http://download.cloudsmith.com/geppetto/updates',
  $suppresserrors=false,
  $checkforpluginfolders=['org.cloudsmith.geppetto']
) {
  ::eclipse::plugin{"eclipseinstallgeppetto":
    pluginrepositories=>$pluginrepositories,
    pluginius=>['org.cloudsmith.geppetto.feature.group'],
    suppresserrors=>$suppresserrors,
    checkforpluginfolders=>$checkforpluginfolders
  }
}
