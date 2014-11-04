Apt::Pin <| |> -> Package <| |>
Apt::Source <| |> -> Package <| |>


group { "puppet":
     ensure => "present",
}

node 'nexus' {
  include cc_java
	include role_nexus_server
}

class cc_java { 
               
    include apt
    apt::ppa { "ppa:webupd8team/java": }
 
    package { 'oracle-java7-installer':
        ensure   => installed,
        require  => Apt::Ppa['ppa:webupd8team/java'],
    }
 
    exec {
 
        "accept_license":
 
        command => "echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections",
        cwd  => "/home",
        user => "root",
        path => "/usr/bin/:/bin/",
        before => Package["oracle-java7-installer"],
        logoutput => true,
     }
}

class role_nexus_server {

  class{ '::nexus':
    version    => '2.10.0',
    revision   => '02',
    nexus_root => '/srv', # All directories and files will be relative to this
  }

}
