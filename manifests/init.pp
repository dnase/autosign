class autosign (
	String $shared_secret = $::autosign_shared_secret,
) {

  file { '/etc/puppetlabs/puppet/autosign.rb' :
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0700',
    content => epp('autosign/autosign.rb.epp', {shared_secret => $shared_secret}),
    notify  => Service['pe-puppetserver'],
  }

  ini_setting { 'autosign script setting':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'master',
    setting => 'autosign',
    value   => '/etc/puppetlabs/puppet/autosign.rb',
    notify  => Service['pe-puppetserver'],
  }

}
