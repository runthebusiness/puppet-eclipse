# Class: eclipse::fixworkspace
#
# When projects are imported the .metadata folder for the workspace some times has the wrong ownerships and ends up with a lock file, this class fixs that.
#
# Parameters:
#  - workspacepath: the work space to fix (Default: '/home/workspace/')
#  - group: the group that owns the project folder. (Default: undef)
#  - owner: the owner of the project folder. (Default: undef)
#  - mode: the permissions mode of the project folder. (Default: 775)


# Sample Usage:
#  Create a sample project:
#  eclipse::fixworkspace{"sampleproject":
#		workspacepath=>'/home/sample-user/workspace/',
#		group=>'sample-group',
#		owner=>'sample-user',
#  }
define eclipse::fixworkspace (
	$workspacepath = '/home/workspace/',
	$group=undef,
	$owner=undef,
	$mode='775',
) {
	include eclipse::params
	
	
	$chowncommand = "chown -R ${owner}:${group} ${workspacepath}/.metadata"

  $filelockfilename = "${name}_ecplipseprojectfilelock"
  
  $filelockpath = "${workspacepath}/.metadata/.lock"
  
  $chownexecname = "${name}_ecplipseprojectchown"
	
	# fix ownership of that pesky metadata folder
  exec {$chownexecname:
    command=>$chowncommand,
    cwd=> $eclipse::params::executefrom,
    path=> $eclipse::params::execlaunchpaths,
    logoutput=> on_failure,
  }
	

	# Fix any locks that come about from adding the project
	file{$filelockfilename:
      path=>$filelockpath,
      ensure=>"absent",
      replace=>false,
      require=>exec[$chownexecname]
    }
}
