# Class: eclipse::params
#
# Params for eclipse based on flavor of system
#
# Parameters:
#  - downloadpath: where the wget file downloads to
#  - installpath: where the installed package should go
#  - desktopfilepath: if set this is the desktop file which will be modified wo include a link to eclipse
#  - simlinkto: where to copy a simlink to

# Actions:
#
# Requires:
#
# Sample Usage:
#
class eclipse::params {

	case $::operatingsystem {
		'centos', 'redhat', 'fedora': {
				#TODO: used the debian defaults -- verify in other flavors:
				$downloadpath='/usr/src/'
				$installpath='/usr/lib/'
				$desktopfilepath='/usr/share/applications/'
				$simlinkto='/usr/bin/'
	    }
	    'ubuntu', 'debian': {
				$downloadpath='/usr/src/'
				$installpath='/usr/lib/'
				$desktopfilepath='/usr/share/applications/'
				$simlinkto='/usr/bin/'
	    }
		'Archlinux': {
				$downloadpath='/tmp/'
				$installpath='/opt/'
				$desktopfilepath='/usr/share/applications/'
				$simlinkto='/usr/bin/'
		}
	    default: {
		    #TODO: used the debian defaults -- verify in other flavors:
				$downloadpath='/usr/src/'
				$installpath='/usr/lib/'
				$desktopfilepath='/usr/share/applications/'
				$simlinkto='/usr/bin/'
		}
	}
	$execlaunchpaths = ["/usr/bin", "/usr/sbin", "/bin", "/sbin", "/etc"]
	$executefrom = "/tmp/"
}
