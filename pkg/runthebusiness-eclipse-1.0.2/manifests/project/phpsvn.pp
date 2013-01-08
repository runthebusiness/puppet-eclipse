# Class: eclipse::project::phpsvn
#
# This class creates and imports a php and svn project
#
# Parameters:
#  - workspacepath: workspace location (Default: '/home/workspace/')
#  - projectname: the name of the project to build (Default: $name)
#  - path: the path to the project (Default: undef)
#  - group: the group that owns the project folder. (Default: undef)
#  - owner: the owner of the project folder. (Default: undef)
#  - mode: the permissions mode of the project folder. (Default: 775)
#  - rebuild: whether or not rebuild the project (Default: false)

# Sample Usage:

# 
define eclipse::project::phpsvn(
  $workspacepath = undef,
  $projectname = $name,
  $path = undef,
  $group=undef,
  $owner=undef,
  $mode=undef,
  $rebuild = undef,
) {
  ::eclipse::project{"${name}_phpsvnproject":
    workspacepath=> $workspacepath,
    projectname=> $projectname,
    path=> $path,
    group=>$group,
    owner=>$owner,
    mode=>$mode,
    makeproject=>true,
    rebuild=>$rebuild,
    buildcommands=>[
      'org.eclipse.wst.common.project.facet.core.builder', 
      'org.eclipse.wst.validation.validationbuilder', 
      'org.eclipse.dltk.core.scriptbuilder', 
      'org.eclipse.xtext.ui.shared.xtextBuilder'
     ],
    natures=>[
      'org.eclipse.xtext.ui.shared.xtextNature',
      'org.eclipse.php.core.PHPNature',
      'org.eclipse.wst.common.project.facet.core.nature',
    ]
  }
}