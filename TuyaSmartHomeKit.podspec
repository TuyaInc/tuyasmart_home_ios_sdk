Pod::Spec.new do |s|
  s.name             = 'TuyaSmartHomeKit'
  s.version          = '2.8.43'
  s.summary          = 'A short description of TuyaSmartHomeKit.'
  s.homepage         = 'https://tuya.com'
  s.license          = { :type => 'MIT' }
  s.author           = { '0x5e' => 'gaosen@tuya.com' }
  s.source           = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TuyaSmartKit.h'


  s.dependency 'TuyaSmartBaseKit'

  s.dependency 'TuyaSmartDeviceKit'
  s.dependency 'TuyaSmartBLEKit'
  s.dependency 'TuyaSmartBLEMeshKit'

  s.dependency 'TuyaSmartSceneKit'
  s.dependency 'TuyaSmartTimerKit'
  s.dependency 'TuyaSmartMessageKit'
  s.dependency 'TuyaSmartFeedbackKit'

end
