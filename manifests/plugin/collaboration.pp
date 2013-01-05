# Class: eclipse::plugin::collaboration
#
# This class installs eclipse collaboration plugin set
#
# Parameters:
#  - pluginrepositories: repositories of plugins to search in (Default: 'http://download.eclipse.org/releases/juno/')
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)

# Sample Usage:

# 
define eclipse::plugin::collaboration(
	$pluginrepositories='http://download.eclipse.org/releases/juno/',
	$suppresserrors=false,
) {
	# Note: I can not get the connectors to auto install: , 'org.polarion.eclipse.team.svn.connector.javahl15.feature.group', 'org.polarion.eclipse.team.svn.connector.javahl16.feature.group', 'org.polarion.eclipse.team.svn.connector.feature.group', 'org.polarion.eclipse.team.svn.connector.svnkit15.feature.group', 'org.polarion.eclipse.team.svn.connector.svnkit16.feature.group'
	::eclipse::plugin{"eclipseinstallcollaboration":
		pluginrepositories=>$pluginrepositories,
		pluginius=>['org.eclipse.dltk.mylyn.feature.group', 'org.eclipse.ecf.core.feature.group', 'org.eclipse.cvs.feature.group', 'org.eclipse.egit.feature.group', 'org.eclipse.jgit.feature.group', 'org.eclipse.cdt.mylyn.feature.group', 'org.eclipse.mylyn.ide_feature.feature.group', 'org.eclipse.mylyn.java_feature.feature.group', 'org.eclipse.mylyn.pde_feature.feature.group', 'org.eclipse.mylyn.team_feature.feature.group', 'org.eclipse.mylyn.bugzilla_feature.feature.group', 'org.eclipse.mylyn.trac_feature.feature.group', 'org.eclipse.mylyn_feature.feature.group', 'org.eclipse.mylyn.context_feature.feature.group', 'org.eclipse.mylyn.wikitext_feature.feature.group', 'org.eclipse.team.svn.revision.graph.feature.group', 'org.eclipse.team.svn.mylyn.feature.group', 'org.eclipse.team.svn.resource.ignore.rules.jdt.feature.group', 'org.eclipse.team.svn.feature.group'],
	  suppresserrors=>$suppresserrors
	}
}
