Pod::Spec.new do |s|
  s.name             = 'TuyaSmartHomeKit'
  s.version          = '2.8.43'
  s.summary          = 'A short description of TuyaSmartHomeKit.'
  s.homepage         = 'https://tuya.com'
  s.license          = { :type => 'MIT' }
  s.author           = { '0x5e' => 'gaosen@tuya.com' }
  s.source           = { :git => "https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git", :tag => "#{s.version}" }

  s.ios.deployment_target = '8.0'
  s.default_subspecs = 'All'
  s.static_framework          = true
  
  s.source_files = 'TuyaSmartKit.h'

  s.subspec 'All' do |ss|

    ss.dependency 'TuyaSmartBaseKit'

    ss.dependency 'TuyaSmartDeviceKit'
    ss.dependency 'TuyaSmartBLEKit'
    ss.dependency 'TuyaSmartBLEMeshKit'

    ss.dependency 'TuyaSmartSceneKit'
    ss.dependency 'TuyaSmartTimerKit'
    ss.dependency 'TuyaSmartMessageKit'
    ss.dependency 'TuyaSmartFeedbackKit'
  end

end
