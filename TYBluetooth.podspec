
Pod::Spec.new do |s|
  s.name             = 'TYBluetooth'
  s.version          = '2.8.43'
  s.summary          = 'Tuya bluetooth, less write and can use anywhere.'
  s.description      = '🚀Tuya bluetooth, less write and can use anywhere.'

  s.homepage         = 'https://tuya.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangdaxia' => 'huangkai@tuya.com' }
  s.source           = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'TYBluetooth.framework'
  s.frameworks = 'Foundation', 'UIKit', 'CoreBluetooth'
  
end
