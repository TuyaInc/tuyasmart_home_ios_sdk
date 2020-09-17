Pod::Spec.new do |s|
  s.name = "TuyaSmartQUIC"
  s.version = '1.1.1'
  s.summary = "A short description of #{s.name}."
  s.license = {"type"=>"MIT"}
  s.authors = {"0x5e"=>"gaosen@tuya.com"}
  s.homepage = "https://tuya.com"
  s.source = { :http => "https://images.tuyacn.com/smart/app/package/sdk/ios/#{s.name}-#{s.version}.zip", :type => "zip" }

  s.ios.deployment_target     = '8.0'

  s.ios.vendored_frameworks   = 'Carthage/Build/iOS/*.framework'
  s.ios.frameworks            = 'UIKit', 'Security'

end
