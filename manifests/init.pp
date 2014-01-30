# == class rkhunter
#
# Install and confgure rkhunter
#
# require postfix
#
# === Params
#
# [*ensure*]
#   Decide if package should or should not be installed (default: present)
#
# [*conffile*]
#   Conf file to be managed (default: /etc/default/rkhunter)
#
# [*conffil2*]
#   Conf file to be managed (default: /etc/rkhunter.conf)
#
# [*mailaddress*]
#   email address to notify (default:notifiche@softecspa.it)
#
class rkhunter (
  $ensure = present,
  $conffile = "/etc/default/rkhunter",
  $conffile2 = "/etc/rkhunter.conf",
  $mailaddress = "notifiche@softecspa.it",
) 
{
  package { 'rkhunter':
    ensure => $ensure;
  }

  softec::lib::line { 'notify-disable-default':
    ensure          => absent,
    file            => "${conffile}",
    line            => 'REPORT_EMAIL="root"',
    require         => [ Package['rkhunter'], Package['cron'] ]
  }

  softec::lib::line { 'notify-enable-custom':
    ensure          => present,
    file            => "${conffile}",
    line            => "REPORT_EMAIL=\"${mailaddress}\"",
    require         => [ Package['rkhunter'], Package['cron'] ]
  }

  softec::lib::line { 'allowhiddendir-static':
    ensure          => present,
    file            => "${conffile2}",
    line            => 'ALLOWHIDDENDIR=/dev/.static',
    require         => [ Package['rkhunter'], Package['cron'] ]
  }

  softec::lib::line { 'allowhiddendir-udev':
    ensure          => present,
    file            => "${conffile2}",
    line            => 'ALLOWHIDDENDIR=/dev/.udev',
    require         => [ Package['rkhunter'], Package['cron'] ]
  }

  softec::lib::line { 'allowhiddendir-initramfs':
    ensure          => present,
    file            => "${conffile2}",
    line            => 'ALLOWHIDDENDIR=/dev/.initramfs',
    require         => [ Package['rkhunter'], Package['cron'] ]
  }

}
