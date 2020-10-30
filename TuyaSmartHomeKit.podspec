Pod::Spec.new do |s|
  s.name = "TuyaSmartHomeKit"
  s.version = "3.20.0"
  s.summary = "A short description of #{s.name}."
  s.license = "none"
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://images.tuyacn.com/smart/app/package/sdk/ios/TuyaSmartHomeKit-2.10.96.zip" }

  s.static_framework = true
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Headers/**/*.h'

  s.dependency 'TuyaSmartBaseKit', '>= 3.20.0'
  s.dependency 'TuyaSmartDeviceCoreKit', '>= 3.20.0'
  s.dependency 'TuyaSmartDeviceKit', '>= 3.20.0'
  
  s.ios.dependency 'TuyaSmartActivatorKit', '>= 3.20.0'
  s.ios.dependency 'TuyaSmartMQTTChannelKit', '>= 3.20.0'
  s.ios.dependency 'TuyaSmartSocketChannelKit', '>= 3.20.0'
  s.ios.dependency 'TuyaSmartBLEKit', '>= 3.20.0'
  s.ios.dependency 'TuyaSmartBLEMeshKit', '>= 3.20.0'

  s.dependency 'TuyaSmartSceneKit', '>= 3.20.0'
  s.dependency 'TuyaSmartTimerKit'
  s.dependency 'TuyaSmartMessageKit'
  s.dependency 'TuyaSmartFeedbackKit'

end
