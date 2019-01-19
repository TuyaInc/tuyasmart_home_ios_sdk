Pod::Spec.new do |s|
  s.name = "TuyaSmartDeviceKit"
  s.version = '0.2.2'
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :git => "https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git", :tag => "#{s.version}" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/TuyaSmartDeviceKit.framework'

  s.dependency 'TuyaSmartBaseKit'

  s.dependency 'CocoaAsyncSocket'
  s.dependency 'MQTTClient', '0.14.0'

end
