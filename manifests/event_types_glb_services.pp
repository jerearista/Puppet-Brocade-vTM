# === Class: brocadevtm::event_types_glb_services
#
# This class is a direct implementation of brocadvtm::event_types
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::event_types_glb_services (
  $ensure                       = present,
  $basic__actions               = '[]',
  $basic__built_in              = true,
  $basic__note                  = 'Events relating to GLB Services and locations.',
  $cloudcredentials__event_tags = '[]',
  $cloudcredentials__objects    = '[]',
  $config__event_tags           = '[]',
  $faulttolerance__event_tags   = '[]',
  $general__event_tags          = '[]',
  $glb__event_tags              = '["glbnewmaster","glbserviceok","glbmanualfailback","glbdeadlocmissingips","glbmissingips","glbnolocations","glbtoomanylocations","glbactivedcmismatch","glbfailalter","glblogwritefail","glbservicedied"]',
  $glb__objects                 = '["*"]',
  $java__event_tags             = '[]',
  $licensekeys__event_tags      = '[]',
  $licensekeys__objects         = '[]',
  $locations__event_tags        = '["locationmonitorok","locationsoapok","locationunavailable","locationdisabled","locationenabled","locationdraining","locationnotdraining","locationavailable","locationok","locempty","locmovemachine","locationmonitorfail","locationsoapfail","locationfail"]',
  $locations__objects           = '["*"]',
  $monitors__event_tags         = '[]',
  $monitors__objects            = '[]',
  $pools__event_tags            = '[]',
  $pools__objects               = '[]',
  $protection__event_tags       = '[]',
  $protection__objects          = '[]',
  $rules__event_tags            = '[]',
  $rules__objects               = '[]',
  $slm__event_tags              = '[]',
  $slm__objects                 = '[]',
  $ssl__event_tags              = '[]',
  $sslhw__event_tags            = '[]',
  $trafficscript__event_tags    = '[]',
  $vservers__event_tags         = '[]',
  $vservers__objects            = '[]',
  $zxtms__event_tags            = '[]',
  $zxtms__objects               = '[]',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring event_types_glb_services ${name}")
  vtmrest { 'event_types/GLB%20Services':
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/3.9/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/event_types.erb'),
    type     => 'application/json',
    internal => 'event_types_glb_services',
    failfast => $brocadevtm::failfast,
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/event_types", {ensure => present})
    file_line { 'event_types/GLB%20Services':
      line => 'event_types/GLB%20Services',
      path => "${purge_state_dir}/event_types",
    }
  }
}
