Pod::Spec.new do |s|
  s.name = "TuyaSmartBaseKit"
  s.version = '0.2.0'
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :git => "https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git", :tag => "#{s.version}" }

  s.ios.deployment_target     = '8.0'
  s.frameworks                = 'SystemConfiguration', 'CoreData', 'CoreTelephony'
  s.libraries                 = 'c++', 'z'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/TuyaSmartBaseKit.framework'

  s.dependency 'TuyaSmartUtil'

  s.dependency 'YYModel'
  s.dependency 'Reachability'

  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

end
