
Pod::Spec.new do |s|
  s.name             = 'TYBluetooth'
  s.version          = '0.2.0'
  s.summary          = 'Tuya bluetooth, less write and can use anywhere.'
  s.description      = '🚀Tuya bluetooth, less write and can use anywhere.'

  s.homepage         = 'https://tuya.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangdaxia' => 'huangkai@tuya.com' }
  s.source = { :git => "https://registry.code.tuya-inc.top/tuyaIOSSDK/TuyaSmartSDK_iOS.git", :tag => "#{s.version}" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/TYBluetooth.framework'
  s.frameworks = 'Foundation', 'UIKit', 'CoreBluetooth'
  
end
