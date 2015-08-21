# === Class: brocadevtm::event_types_Service_Failed
#

class brocadevtm::event_types_Service_Failed (
  $ensure = present,
  $basic__actions               = [],
  $basic__built_in              = true,
  $basic__note                  = "Problems with services (virtual servers, pools, classes and related files).",
  $cloudcredentials__event_tags = [],
  $cloudcredentials__objects    = [],
  $config__event_tags           = [],
  $faulttolerance__event_tags   = [],
  $general__event_tags          = [],
  $glb__event_tags              = [],
  $glb__objects                 = [],
  $java__event_tags             = ["javanotfound", "servleterror"],
  $licensekeys__event_tags      = [],
  $licensekeys__objects         = [],
  $locations__event_tags        = [],
  $locations__objects           = [],
  $monitors__event_tags         = ["monitorfail"],
  $monitors__objects            = ["*"],
  $pools__event_tags            = ["pooldied", "noderesolvefailure", "noderesolvemultiple", "nodefail", "ehloinvalid", "starttlsinvalid", "nostarttls"],
  $pools__objects               = ["*"],
  $protection__event_tags       = ["triggersummary"],
  $protection__objects          = ["*"],
  $rules__event_tags            = ["datastorefull", "ruleabort", "rulexmlerr", "rulebodycomperror", "rulebufferlarge", "rulelogmsgwarn", "poolactivenodesunknown", "pooluseunknown", "norate", "rulenopersistence", "forwardproxybadhost", "invalidemit", "rulelogmsgserious"],
  $rules__objects               = ["*"],
  $slm__event_tags              = ["slmfallenbelowserious", "slmnodeinfo"],
  $slm__objects                 = ["*"],
  $ssl__event_tags              = [],
  $sslhw__event_tags            = [],
  $trafficscript__event_tags    = [],
  $vservers__event_tags         = ["vslogwritefail", "respcompfail", "responsetoolarge", "rtspstreamnoports", "sipstreamnoports", "vscacertexpired", "vscacerttoexpire", "vscrloutofdate", "vssslcertexpired", "vssslcerttoexpire"],
  $vservers__objects            = ["*"],
  $zxtms__event_tags            = [],
  $zxtms__objects               = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring event_types_Service_Failed ${name}")
  vtmrest { "event_types/Service%20Failed":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/event_types_Service_Failed.erb'),
    internal => 'event_types_Service_Failed',
    debug => 0,
  }
}