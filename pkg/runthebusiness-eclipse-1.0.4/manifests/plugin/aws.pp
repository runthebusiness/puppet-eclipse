# Class: eclipse::plugin::aws
#
# This class installs eclipse amazone aws plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)
#  - checkforpluginfolders: an array of folders to check for in the eclipse/plugins directory, if they are all found then the plugins in pluginius will not install (Default: ['org.eclipse.datatools.connectivity', 'com.amazonaws.eclipse.ec2', 'com.amazonaws.eclipse.rds', 'com.amazonaws.eclipse.simpleworkflow', 'com.amazonaws.eclipse.core'])

# Sample Usage:
# 
define eclipse::plugin::aws(
	$pluginrepositories=['http://download.eclipse.org/releases/indigo/', 'http://aws.amazon.com/eclipse/'],
	$suppresserrors=false,
	$checkforpluginfolders=['org.eclipse.datatools.connectivity', 'com.amazonaws.eclipse.ec2', 'com.amazonaws.eclipse.rds', 'com.amazonaws.eclipse.simpleworkflow', 'com.amazonaws.eclipse.core']
) {
	::eclipse::plugin{"eclipseinstallaws":
		pluginrepositories=>$pluginrepositories,
		pluginius=>['org.eclipse.datatools.connectivity.feature.feature.group', 'com.amazonaws.eclipse.ec2.feature.group', 'com.amazonaws.eclipse.rds.feature.feature.group', 'com.amazonaws.eclipse.simpleworkflow.feature.feature.group', 'com.amazonaws.eclipse.core.feature.feature.group'],
	  suppresserrors=>$suppresserrors,
    checkforpluginfolders=>$checkforpluginfolders
	}
}
