Pod::Spec.new do |s|
  s.name = "TuyaSmartDeviceKit"
  s.version = "2.8.44"
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.source_files              = 'ios/**/*.h'
  s.vendored_frameworks       = 'ios/*.framework'
  # s.vendored_libraries        = 'ios/*.a'

  s.dependency 'TuyaSmartBaseKit'

  s.dependency 'CocoaAsyncSocket'
  s.dependency 'MQTTClient', '0.14.0'

end
