# Class: eclipse::plugin::aws
#
# This class installs eclipse amazone aws plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)

# Sample Usage:
# 
define eclipse::plugin::aws(
	$pluginrepositories=['http://download.eclipse.org/releases/indigo/', 'http://aws.amazon.com/eclipse/'],
	$suppresserrors=false,
) {
	::eclipse::plugin{"eclipseinstallaws":
		pluginrepositories=>$pluginrepositories,
		pluginius=>['org.eclipse.datatools.connectivity.feature.feature.group', 'com.amazonaws.eclipse.ec2.feature.group', 'com.amazonaws.eclipse.rds.feature.feature.group', 'com.amazonaws.eclipse.simpleworkflow.feature.feature.group', 'com.amazonaws.eclipse.core.feature.feature.group'],
	  suppresserrors=>$suppresserrors
	}
}
