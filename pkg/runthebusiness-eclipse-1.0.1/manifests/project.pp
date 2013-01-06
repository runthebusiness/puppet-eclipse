# Class: eclipse::project
#
# This class imports eclipse projects. 
#
# Parameters:
#  - workspacepath: location of workspace (Default: '/home/workspace/')
#  - projectname: the name of the project to build (Default: $name)
#  - path: the path to the project (Default: undef)
#  - makeproject: whether or not to generate a project file (Default: false)
#  - group: the group that owns the project folder.  (Default: undef)
#  - owner: the owner of the project folder.  (Default: undef)
#  - mode: the permissions mode of the project folder.  (Default: 775)
#  - rebuild: whether or not rebuild the project (Default: false)
#  - buildcommands: build commands to put in the generated project file (Default: [])
#  - natures: natures to put in the generated project file (Default: [])


# Sample Usage:
#  Create a sample project:
#  eclipse::project{"sampleproject":
#		workspacepath=>'/home/sample-user/workspace/',
#		group=>'sample-group',
#		owner=>'sample-user',
#		makeproject=>true
#  }
define eclipse::project (
	$workspacepath = '/home/workspace/',
	$projectname = $name,
	$path = undef,
	$group=undef,
	$owner=undef,
	$mode='775',
	$makeproject = true,
	$rebuild = false,
	$buildcommands=[],
	$natures=[]
) {
	include eclipse::params
	
	
	# Build the commands
	$importprojectcmd = template("eclipse/addproject.erb")
	$chowncommand = "chown -R ${owner}:${group} ${workspacepath}/.metadata"
	
	# Choose unique name for file resource
	$fileprojectfilename = "${name}_ecplipseprojectfile"
  $filelockfilename = "${name}_ecplipseprojectfilelock"
  
  $lockfilepath = "${workspacepath}/.metadata/.lock"
  
  $importexecname = "${name}_ecplipseprojectexec"
  
  $chownexecname = "${name}_ecplipseprojectchown"

	$projectfilepath = "${path}/.project"
	$fileprojectdirtemplate = "eclipse/project.erb"
	$projectfilecontents = template($fileprojectdirtemplate)
	
	if $makeproject != false {
		#make the new project file
		file{$fileprojectfilename:
			path=>$projectfilepath,
			group=>$group,
			owner=>$owner,
			mode=>$mode,
			ensure=>"present",
			replace=>false,
			content=>$projectfilecontents,
			#require=>file[$fileprojectdirname]
		}
	} else {
		# Make sure the project file exists
		file{$fileprojectfilename:
			path=>$projectfilepath,
			ensure=>"present",
			replace=>false,
			#require=>file[$fileprojectdirname]
		}
	}
	
	# run the command
	exec {$importexecname:
		command=>$importprojectcmd,
		cwd=> $eclipse::params::executefrom,
		path=> $eclipse::params::execlaunchpaths,
		logoutput=> on_failure,
		timeout => 900,
		require=>file[$fileprojectfilename]
	}
	
}
