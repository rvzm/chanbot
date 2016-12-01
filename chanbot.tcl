# chanbot.tcl
# version 0.1

putlog "loading chanbot..."

namespace eval chanbot {
	namespace eval settings {
		variable pubtrig "-"
	}
	namespace eval bind {
		bind pub o ${chanbot::settings::pubtrig}op chanbot::procs::op
		bind pub o ${chanbot::settings::pubtrig}deop chanbot::procs::deop
		bind pub o ${chanbot::settings::pubtrig}topic chanbot::procs::topic
	}
	namespace eval procs {
		proc version {nick uhost hand chan text} {
			putserv "PRIVMSG $chan :I am chanbot v[chanbot::util::version]"
		}
		proc op {nick uhost hand chan text} {
			set v1 [lindex [split $text] 0]
			if {$v1 != ""} { putserv "MODE $chan +o $v1"; return  } else { putserv "MODE $chan +o $nick"; return }
		}
		proc deop {nick uhost hand chan text} {
			set v1 [lindex [split $text] 0]
			if {$v1 != ""} { putserv "MODE $chan -o $v1"; return  } else { putserv "MODE $chan -o $nick"; return }
		}
		proc topic {nick uhost hand chan text} {
			putserv "TOPIC $chan :$text"
			return
		}
	}
	namespace eval util {
		proc version {} { return "0.1" }
	}

}
putlog "chanbot loaded."
