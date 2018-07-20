#
# Be sure to run `pod lib lint TuyaSmartKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TuyaSmartHomeKit'
  s.version          = '0.0.12'
  s.summary          = '涂鸦全屋智能iOS SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
涂鸦全屋智能APP SDK提供了与硬件设备、涂鸦云通讯的接口封装，加速应用开发过程。
                       DESC
                       
  s.homepage         = 'http://www.tuya.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xcc' => 'xucheng@tuya.com' }
  s.source           = { :git => 'https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  # s.resource_bundles = {
  #   'TuyaSmartKit' => ['TuyaSmartKit/Assets/*.png']
  # }

  s.vendored_frameworks = 'TuyaSmartHomeKit.framework'
  s.preserve_paths      = 'TuyaSmartHomeKit.framework'

  s.frameworks = 'Foundation'
  s.libraries  = 'c++', 'z'

  s.dependency 'CocoaAsyncSocket'
  s.dependency 'MQTTClient','0.14.0'
  s.dependency 'Mantle'
  s.dependency 'UICKeyChainStore'
  s.dependency 'Reachability'

  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

end
