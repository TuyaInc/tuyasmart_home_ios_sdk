
Pod::Spec.new do |s|
  s.name             = 'TYBluetooth'
  s.version          = '2.10.96'
  s.summary          = 'Tuya bluetooth, less write and can use anywhere.'
  s.description      = '🚀Tuya bluetooth, less write and can use anywhere.'

  s.homepage         = 'https://tuya.com'
  s.license          = { :type => 'MIT' }
  s.author           = { 'huangdaxia' => 'huangkai@tuya.com' }
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.source_files              = 'ios/**/*.h'
  s.vendored_frameworks       = 'ios/*.framework'
  s.frameworks = 'Foundation', 'UIKit', 'CoreBluetooth'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'TUYA_PRIVACY_USAGE_DESCRIPTION': 'NSBluetoothPeripheralUsageDescription'
  }

end
