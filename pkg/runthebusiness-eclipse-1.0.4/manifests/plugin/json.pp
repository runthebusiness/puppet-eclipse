# Class: eclipse::plugin::json
#
# This class installs eclipse php json plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)
#  - checkforpluginfolders: an array of folders to check for in the eclipse/plugins directory, if they are all found then the plugins in pluginius will not install (Default: ['json.editor.plugin'])

# Sample Usage:

# 
define eclipse::plugin::json(
  $pluginrepositories='http://eclipsejsonedit.svn.sourceforge.net/viewvc/eclipsejsonedit/trunk/Json Editor Plugin',
  $suppresserrors=false,
  $checkforpluginfolders=['json.editor.plugin']
) {
  ::eclipse::plugin{"eclipseinstalljson":
    pluginrepositories=>$pluginrepositories,
    pluginius=>['json.editor.plugin.feature.feature.group'],
    suppresserrors=>$suppresserrors,
    checkforpluginfolders=>$checkforpluginfolders
  }
}
