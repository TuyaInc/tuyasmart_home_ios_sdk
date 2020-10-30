Pod::Spec.new do |s|
  s.name = "TuyaSmartBLEMeshKit"
  s.version = "3.20.3"
  s.summary = "A short description of #{s.name}."
  s.license = "none"
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data-1254153901.cos.ap-shanghai.myqcloud.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/*.framework'
  # s.vendored_libraries        = 'ios/*.a'

  s.frameworks = 'Foundation', 'CoreBluetooth'

  s.dependency 'TuyaSmartBaseKit', '>= 3.20.0'
  s.dependency 'TuyaSmartDeviceKit', '>= 3.20.0'
  s.dependency 'TYBluetooth'
  s.dependency 'TuyaSmartActivatorKit', '>= 3.20.0'
  s.dependency 'OpenSSL-Universal', '1.0.2.17'
  s.dependency 'TuyaSmartBLEKit', '>= 3.20.0'

end
