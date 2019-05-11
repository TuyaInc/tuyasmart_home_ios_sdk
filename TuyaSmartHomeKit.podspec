Pod::Spec.new do |s|
  s.name = "TuyaSmartHomeKit"
  s.version = "2.10.96"
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.static_framework = true

  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Headers/**/*.h'

  ss.dependency 'TuyaSmartBaseKit'
  ss.dependency 'TuyaSmartDeviceKit'
  
  ss.ios.dependency 'TuyaSmartActivatorKit'
  ss.ios.dependency 'TuyaSmartMQTTChannelKit'
  ss.ios.dependency 'TuyaSmartSocketChannelKit'
  ss.ios.dependency 'TuyaSmartBLEKit'
  ss.ios.dependency 'TuyaSmartBLEMeshKit'

  ss.dependency 'TuyaSmartSceneKit'
  ss.dependency 'TuyaSmartTimerKit'
  ss.dependency 'TuyaSmartMessageKit'
  ss.dependency 'TuyaSmartFeedbackKit'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

end
