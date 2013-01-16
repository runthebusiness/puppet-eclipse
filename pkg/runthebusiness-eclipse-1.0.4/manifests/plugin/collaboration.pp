# Class: eclipse::plugin::collaboration
#
# This class installs eclipse collaboration plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)
#  - checkforpluginfolders: an array of folders to check for in the eclipse/plugins directory, if they are all found then the plugins in pluginius will not install (Default: ['org.eclipse.dltk.mylyn', 'org.eclipse.ecf', 'org.eclipse.cvs', 'org.eclipse.egit', 'org.eclipse.jgit', 'org.eclipse.cdt', 'org.eclipse.mylyn', 'org.eclipse.cdt.mylyn', 'org.eclipse.cdt.mylyn.java', 'org.eclipse.mylyn.pde', 'org.eclipse.mylyn.team', 'org.eclipse.mylyn.bugzilla', 'org.eclipse.mylyn.trac', 'org.eclipse.mylyn.context', 'org.eclipse.mylyn.wikitext', 'org.eclipse.team.svn.revision.graph', 'org.eclipse.team.svn.mylyn', 'org.eclipse.team.svn.resource.ignore.rules.jdt', 'org.eclipse.team.svn'])

# Sample Usage:

# 
define eclipse::plugin::collaboration(
	$pluginrepositories='http://download.eclipse.org/releases/juno/',
	$suppresserrors=false,
	$checkforpluginfolders=['org.eclipse.dltk.mylyn', 'org.eclipse.ecf', 'org.eclipse.cvs', 'org.eclipse.egit', 'org.eclipse.jgit', 'org.eclipse.cdt', 'org.eclipse.mylyn', 'org.eclipse.cdt.mylyn', 'org.eclipse.mylyn.pde', 'org.eclipse.mylyn.team', 'org.eclipse.mylyn.bugzilla', 'org.eclipse.mylyn.trac', 'org.eclipse.mylyn.context', 'org.eclipse.mylyn.wikitext', 'org.eclipse.team.svn.revision.graph', 'org.eclipse.team.svn.mylyn', 'org.eclipse.team.svn.resource.ignore.rules.jdt', 'org.eclipse.team.svn']
) {
	# Note: I can not get the connectors to auto install: , 'org.polarion.eclipse.team.svn.connector.javahl15.feature.group', 'org.polarion.eclipse.team.svn.connector.javahl16.feature.group', 'org.polarion.eclipse.team.svn.connector.feature.group', 'org.polarion.eclipse.team.svn.connector.svnkit15.feature.group', 'org.polarion.eclipse.team.svn.connector.svnkit16.feature.group'
	::eclipse::plugin{"eclipseinstallcollaboration":
		pluginrepositories=>$pluginrepositories,
		pluginius=>['org.eclipse.dltk.mylyn.feature.group', 'org.eclipse.ecf.core.feature.group', 'org.eclipse.cvs.feature.group', 'org.eclipse.egit.feature.group', 'org.eclipse.jgit.feature.group', 'org.eclipse.cdt.mylyn.feature.group', 'org.eclipse.mylyn.ide_feature.feature.group', 'org.eclipse.mylyn.java_feature.feature.group', 'org.eclipse.mylyn.pde_feature.feature.group', 'org.eclipse.mylyn.team_feature.feature.group', 'org.eclipse.mylyn.bugzilla_feature.feature.group', 'org.eclipse.mylyn.trac_feature.feature.group', 'org.eclipse.mylyn_feature.feature.group', 'org.eclipse.mylyn.context_feature.feature.group', 'org.eclipse.mylyn.wikitext_feature.feature.group', 'org.eclipse.team.svn.revision.graph.feature.group', 'org.eclipse.team.svn.mylyn.feature.group', 'org.eclipse.team.svn.resource.ignore.rules.jdt.feature.group', 'org.eclipse.team.svn.feature.group'],
	  suppresserrors=>$suppresserrors,
    checkforpluginfolders=>$checkforpluginfolders
	}
}
