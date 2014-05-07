# Class: eclipse::plugin
#
# This class installs eclipse plugins
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: ['http://download.eclipse.org/releases/juno/'])
#  - pluginius: the ius to install (Default: [])
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)
#  - checkforpluginfolders: an array of folders to check for in the eclipse/plugins directory, if they are all found then the plugins in pluginius will not install (Default: undef)

# Sample Usage:
#  Get SVN
#  eclipse::plugin{"eclipsecollaboration":
#		pluginrepositories=>'http://download.eclipse.org/releases/helios/',
#		pluginius=>['org.eclipse.dltk.mylyn.feature.group', 'org.eclipse.efc.core.feature.group', 'org.eclipse.cvs.feature.group', 'org.eclipse.egit.feature.group', 'org.eclipse.jgit.feature.group', 'org.eclipse.cdt.mylyn.feature.group', 'org.eclipse.mylyn.ide_feature.feature.group', 'org.eclipse.mylyn.java_feature.feature.group', 'org.eclipse.mylyn.pde_feature.feature.group', 'org.eclipse.mylyn.team_feature.feature.group', 'org.eclipse.mylyn.bugzilla_feature.feature.group', 'org.eclipse.mylyn.trac_feature.feature.group', 'org.eclipse.mylyn_feature.feature.group', 'org.eclipse.mylyn.context_feature.feature.group', 'org.eclipse.mylyn.wikitext_feature.feature.group', 'org.eclipse.team.svn.revision.graph.feature.group', 'org.eclipse.team.svn.mylyn.feature.group', 'org.eclipse.team.svn.resource.ignore.rules.jdt.feature.group', 'org.eclipse.team.svn.feature.group']
#  }
define eclipse::plugin (
	$pluginrepositories = ['http://download.eclipse.org/releases/juno/'],
	$pluginius = [],
	$suppresserrors=false,
	$checkforpluginfolders=undef,
	$timeout=900,
) {
	include eclipse::params
	$addpluginscmd = template("eclipse/addplugins.erb")

  if $checkforpluginfolders == undef {
    $unless = undef
  } else {
    $unless = template('eclipse/checkplugininstalled.erb')
  }

	exec {"${name}_ecplipseplugins":
		command=>$addpluginscmd,
		cwd=> $eclipse::params::executefrom,
		path=> $eclipse::params::execlaunchpaths,
		timeout => $timeout,
		unless=>$unless,
		logoutput=> on_failure,
	}
}
