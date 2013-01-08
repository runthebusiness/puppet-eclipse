# Class: eclipse::plugin::jsdt
#
# This class installs eclipse php jsdt plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)

# Sample Usage:

# 
define eclipse::plugin::jsdt(
	$pluginrepositories='http://download.eclipse.org/releases/juno/',
	$suppresserrors=false,
) {
	::eclipse::plugin{"eclipseinstalljsdt":
		pluginrepositories=>$pluginrepositories,
		pluginius=>['org.eclipse.wst.jsdt.feature.feature.group'],
		suppresserrors=>$suppresserrors
	}
}
