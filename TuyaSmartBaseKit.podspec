Pod::Spec.new do |s|
  s.name = "TuyaSmartBaseKit"
  s.version = "2.8.43"
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'
  s.frameworks                = 'SystemConfiguration', 'CoreData', 'CoreTelephony'
  s.libraries                 = 'c++', 'z'

  s.static_framework          = true
  s.source_files              = 'Headers/**/*.h', 'ios/**/*.h'
  s.vendored_frameworks       = 'ios/*.framework'
  # s.vendored_libraries        = 'ios/*.a'

  s.dependency 'TuyaSmartUtil'

  s.dependency 'YYModel'
  s.dependency 'Reachability'

  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

end
