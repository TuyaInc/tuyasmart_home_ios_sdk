Pod::Spec.new do |s|
<<<<<<< HEAD
  s.name = "TuyaSmartMQTTChannelKit"
  s.version = "2.12.46"
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/*.framework'
  # s.vendored_libraries        = 'ios/*.a'

  s.dependency 'TuyaSmartBaseKit'
  s.dependency 'MQTTClient', '0.14.0'

=======
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
>>>>>>> feature/sig_mesh
end
