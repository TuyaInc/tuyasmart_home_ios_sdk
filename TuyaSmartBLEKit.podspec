Pod::Spec.new do |s|
  s.name = "TuyaSmartBLEKit"
  s.version = '0.2.1'
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :git => "https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git", :tag => "#{s.version}" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/TuyaSmartBLEKit.framework'

  s.frameworks = 'Foundation', 'CoreBluetooth'

  s.dependency 'TuyaSmartBaseKit'
  s.dependency 'TuyaSmartDeviceKit'
  s.dependency 'TYBluetooth'

end
