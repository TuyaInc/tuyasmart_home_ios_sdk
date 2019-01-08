Pod::Spec.new do |s|
  s.name = "TuyaSmartSceneKit"
  s.version = '0.2.0'
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :git => "https://registry.code.tuya-inc.top/tuyaIOSSDK/TuyaSmartSDK_iOS.git", :tag => "#{s.version}" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/TuyaSmartMessageKit.framework'

  s.dependency 'TuyaSmartBaseKit'
  s.dependency 'TuyaSmartDeviceKit'

end
