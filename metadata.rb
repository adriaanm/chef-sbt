name              'chef-sbt'
maintainer        'Matt Farmer'
maintainer_email  'matt@frmr.me'
license           'Apache 2.0'
description       'Installs the sbt version you request from manual download.'
version            '0.1.0'

recipe 'sbt', 'Downloads and installs sbt in your path.'

%w{ubuntu debian windows}.each do |os|
  supports os
end
