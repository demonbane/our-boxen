class people::demonbane {
#  include alfred
  include bash
  include bash::completion
#  include chrome
  include emacs
#  include fantastical
#  include fitbit
#  include skype

  $home      = '/Users/alexmalinovich'
  $helpers   = "${home}/dev/helpers"
  $dotfiles  = "${home}/dev/dotfiles"
  #  $alfredlib = "${home}/Library/Application Support/Alfred 2"

  repository {
    $helpers:
      source  => 'demonbane/helpers';
    $dotfiles:
      source  => 'demonbane/dotfiles';
  }

  package {
    'bwm-ng': ;
    'coreutils': ;
    'dwdiff': ;
    'gawk': ;
    'gnupg': ;
    'pigz': ;
    'wget': ;
  }

  # Dotfiles
  file {
    "${home}/.bashrc":
      ensure  => link,
      target  => "${dotfiles}/bashrc";
    "${home}/.bash_profile":
      ensure  => link,
      target  => "${dotfiles}/bash_profile";
    "${home}/.bwm-ng.conf":
      ensure  => link,
      target  => "${dotfiles}/bwm-ng.conf";
    "${home}/.digrc":
      ensure  => link,
      target  => "${dotfiles}/digrc";
    "${home}/.gitconfig":
      ensure  => link,
      target  => "${dotfiles}/gitconfig",
      require => Repository[$dotfiles];
    "${home}/.vim":
      ensure  => link,
      target  => "${dotfiles}/vim";
    "${home}/.vimrc":
      ensure  => link,
      target  => "${dotfiles}/vimrc";
  }

  # Licenses
  #file {
  #  $alfredlib:
  #    ensure => directory;
  #}
  #file {
  #  "${alfredlib}/license.plist":
  #    replace => false,
  #    source  => "${dotfiles}/licenses/Alfred/license.plist",
  #    #require => [ Package['Alfred'], File[$alfredlib] ];
  #    require => File[$alfredlib];
  #}

  # Misc
  file {
    '/usr/local/bin/dusize':
      ensure  => link,
      target  => "${helpers}/dusize",
      require => [ Package['gawk'], Package['coreutils'] ];
  }

  boxen::osx_defaults {
    'hot corner bl to launchpad':
      domain => 'com.apple.dock',
      key    => 'wvous-bl-corner',
      value  => 11;
    'hot corner br to desktop':
      domain => 'com.apple.dock',
      key    => 'wvous-br-corner',
      value  => 4;
    'hot corner tl to dashboard':
      domain => 'com.apple.dock',
      key    => 'wvous-tl-corner',
      value  => 7;
    'hot corner tr to mission control':
      domain => 'com.apple.dock',
      key    => 'wvous-tr-corner',
      value  => 2;
  }
}
