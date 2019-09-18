Pod::Spec.new do |s|
  s.name = "TuyaSmartBLEMeshKit"
<<<<<<< HEAD
  s.version = "2.12.48"
=======
  s.version = "3.12.0"
>>>>>>> feature/sig_mesh
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/TuyaSmartBLEMeshKit-2.12.47.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
<<<<<<< HEAD
  s.vendored_frameworks       = 'ios/*.framework'
=======
  s.source_files              = 'ios/TuyaSmartBLEMeshKit/*.h'
  s.vendored_frameworks       = 'ios/TuyaSmartBLEMeshKit.framework'
>>>>>>> feature/sig_mesh
  # s.vendored_libraries        = 'ios/*.a'

  s.frameworks = 'Foundation', 'CoreBluetooth'

  s.dependency 'TuyaSmartBaseKit'
  s.dependency 'TuyaSmartDeviceKit'
  s.dependency 'TYBluetooth'
<<<<<<< HEAD
  s.dependency 'TuyaSmartActivatorKit'
=======
  s.dependency 'OpenSSL-Universal', '1.0.2.17'
>>>>>>> feature/sig_mesh

end
