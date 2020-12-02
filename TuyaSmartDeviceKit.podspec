Pod::Spec.new do |s|
  s.name = "TuyaSmartDeviceKit"
  s.version = "3.20.3"
  s.summary = "A short description of #{s.name}."
  s.license = "none"
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://images.tuyacn.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.static_framework          = true

  s.ios.deployment_target = '8.0'
  s.ios.vendored_frameworks = 'ios/*.framework'
  # s.ios.vendored_libraries = 'ios/*.a'

  s.watchos.deployment_target = '2.0'
  s.watchos.vendored_frameworks = 'watchos/*.framework'
  # s.watchos.vendored_libraries = 'watchos/*.a'

  s.dependency 'TuyaSmartBaseKit', '>= 3.19.0'
  s.dependency 'TuyaSmartDeviceCoreKit', '>= 3.19.0'

end
