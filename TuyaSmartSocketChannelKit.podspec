Pod::Spec.new do |s|
  s.name = "TuyaSmartSocketChannelKit"
  s.version = "3.14.0"
  s.summary = "A short description of #{s.name}."
  s.license = "none"
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://airtake-public-data.oss-cn-hangzhou.aliyuncs.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.static_framework          = true
  s.vendored_frameworks       = 'ios/*.framework'
  # s.vendored_libraries        = 'ios/*.a'

  s.dependency 'TuyaSmartBaseKit'
  s.dependency 'CocoaAsyncSocket'
end
