Pod::Spec.new do |s|
  s.name             = 'TuyaSmartMQTTChannelKit'
  s.version          = '3.12.0'
  s.summary          = 'A short description of TuyaSmartMQTTChannelKit.'
  s.homepage         = 'https://tuya.com'
  s.license          = { :type => 'MIT' }
  s.author           = { 'xcc' => 'xucheng@tuya.com' }
  s.source           = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target = '8.0'

  s.static_framework          = true
  s.source_files              = 'ios/**/*.h'
  s.vendored_frameworks       = 'ios/*.framework'
  

  s.dependency 'TuyaSmartBaseKit'
  s.dependency 'MQTTClient', '0.14.0'
end
