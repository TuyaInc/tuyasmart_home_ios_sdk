Pod::Spec.new do |s|
  s.name = "TuyaSmartBaseKit"
  s.version = "3.14.5"
  s.summary = "A short description of #{s.name}."
  s.license = "none"
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.static_framework = true

  s.ios.deployment_target = '8.0'
  s.ios.vendored_frameworks = 'ios/*.framework'
  # s.ios.vendored_libraries = 'ios/*.a'

  s.watchos.deployment_target = '2.0'
  s.watchos.vendored_frameworks = 'watchos/*.framework'
  s.watchos.frameworks = 'UIKit'
  # s.watchos.vendored_libraries = 'watchos/*.a'

  s.libraries = 'c++', 'z'

  s.dependency 'TuyaSmartUtil'
  s.dependency 'YYModel'

end
