Pod::Spec.new do |s|
  s.name             = 'Salad'
  s.version          = '0.0.1'
  s.summary          = 'Lightweight cucumber style UI tests for iOS.'

  s.homepage         = 'https://github.com/Q42/Salad'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mathijs Kadijk' => 'mathijs@q42.nl' }
  s.source           = { :git => 'https://github.com/Q42/Salad.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Q42'

  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target  = '10.11'

  s.source_files = 'Sources/Salad/**/*'
  
  s.frameworks = 'XCTest', 'GameplayKit'
end
