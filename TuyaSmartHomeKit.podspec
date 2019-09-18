Pod::Spec.new do |s|
<<<<<<< HEAD
  s.name = "TuyaSmartHomeKit"
  s.version = "2.12.46"
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }
=======
  s.name             = 'TuyaSmartHomeKit'
  s.version          = '3.12.0'
  s.summary          = 'A short description of TuyaSmartHomeKit.'
  s.homepage         = 'https://tuya.com'
  s.license          = { :type => 'MIT' }
  s.author           = { '0x5e' => 'gaosen@tuya.com' }
  s.source           = { :git => "https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git", :tag => "#{s.version}" }
>>>>>>> feature/sig_mesh

  s.static_framework = true
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Headers/**/*.h'

  s.dependency 'TuyaSmartBaseKit'
  s.dependency 'TuyaSmartDeviceKit'
  
  s.ios.dependency 'TuyaSmartActivatorKit'
  s.ios.dependency 'TuyaSmartMQTTChannelKit'
  s.ios.dependency 'TuyaSmartSocketChannelKit'
  s.ios.dependency 'TuyaSmartBLEKit'
  s.ios.dependency 'TuyaSmartBLEMeshKit'

  s.dependency 'TuyaSmartSceneKit'
  s.dependency 'TuyaSmartTimerKit'
  s.dependency 'TuyaSmartMessageKit'
  s.dependency 'TuyaSmartFeedbackKit'

end
