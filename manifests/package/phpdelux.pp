# Class: eclipse::package::phpdelux
#
# This class installs the eclipse and all the plugins we use in our own internal deployments
#
# Parameters:
#  - suppresserrors: whether or not to supress errors when adding the plugin (Default: false)

define eclipse::package::phpdelux (
  $suppresserrors=false,
) {
	
	# install eclipse php
	$eclipsename = "${name}_eclipse"
	$samplename = "${name}_sampleproject"
	$collaborationname = "${name}_eclipsecollaboration"
	$geppettoname = "${name}_eclipsegeppetto"
	$pdtname = "${name}_eclipsepdt"
	$jsonname = "${name}_eclipsejson"
	
	eclipse{$eclipsename:
		downloadurl=>'http://www.eclipse.org/downloads/download.php?file=/eclipse/downloads/drops/R-3.7.2-201202080800/eclipse-SDK-3.7.2-linux-gtk-x86_64.tar.gz&url=http://mirrors.xmission.com/eclipse/eclipse/downloads/drops/R-3.7.2-201202080800/eclipse-SDK-3.7.2-linux-gtk-x86_64.tar.gz&mirror_id=518',
		downloadfile=>'eclipse-SDK-3.7.2-linux-gtk-x86_64.tar.gz'
	}
	
	# install collaboration plugins for ecplipse
  eclipse::plugin::collaboration{$collaborationname:
    pluginrepositories=>'http://download.eclipse.org/releases/indigo/',
    suppresserrors=>$suppresserrors,
    require=>eclipse[$eclipsename]
  }

	# install geppetto plugins for ecplipse
	eclipse::plugin::geppetto{$geppettoname:
	  suppresserrors=>$suppresserrors,
	  require=>eclipse[$eclipsename]
	}
	
	# install pdt plugins for ecplipse
  eclipse::plugin::pdt{$pdtname:
    pluginrepositories=>'http://download.eclipse.org/releases/indigo/',
    suppresserrors=>$suppresserrors,
    require=>eclipse[$eclipsename]
  }
  
  # install json plugins for ecplipse
  eclipse::plugin::json{$jsonname:
    suppresserrors=>$suppresserrors,
    require=>eclipse[$eclipsename]
  }
  
  # install json plugins for ecplipse
  eclipse::plugin::aws{$jsonname:
    suppresserrors=>$suppresserrors,
    require=>eclipse[$eclipsename]
  }
	
}