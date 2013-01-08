# Class: eclipse::plugin::json
#
# This class installs eclipse php json plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)

# Sample Usage:

# 
define eclipse::plugin::json(
  $pluginrepositories='http://eclipsejsonedit.svn.sourceforge.net/viewvc/eclipsejsonedit/trunk/Json Editor Plugin',
  $suppresserrors=false,
) {
  ::eclipse::plugin{"eclipseinstalljson":
    pluginrepositories=>$pluginrepositories,
    pluginius=>['json.editor.plugin.feature.feature.group'],
    suppresserrors=>$suppresserrors
  }
}
