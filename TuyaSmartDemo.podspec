Pod::Spec.new do |s|
  s.name             = 'TuyaSmartDemo'
  s.version          = '0.8.3'
  s.summary          = 'Tuya common base demo.'

  s.description      = 'Tuya common base demo support quick to test some feature.'

  s.homepage         = 'https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huangdaxia' => 'huangkai@tuya.com' }
  s.source           = { :git => 'https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git', :branch => 'master' }

  s.ios.deployment_target = '8.0'

  s.default_subspec = 'Base'
  s.static_framework = true
  
  s.subspec 'Base' do |ss|
    ss.source_files = 'TuyaSmartDemo/Classes/Base/**/*.{h,m}', 'TuyaSmartDemo/Classes/Manager/**/*.{h,m}'

    ss.resource_bundles = {
      'TuyaSmartDemoBaseBundle' => 'TuyaSmartDemo/Classes/Base/Assets/**/*'
    }
    
    ss.prefix_header_contents = '#ifdef __OBJC__',
    '#import "TYDemoTheme.h"',
    '#import "TPDemoViewConstants.h"',
    '#import "UIView+TPDemoAdditions.h"',
    '#import "TPDemoUtils.h"',
    '#endif'
    
    ss.dependency 'MBProgressHUD'
    ss.dependency 'Reachability'
    ss.dependency 'YYModel'
    
    ss.dependency 'TuyaSmartBaseKit'
  end
  
  s.subspec 'Login' do |ss|
    ss.source_files = 'TuyaSmartDemo/Classes/Login/**/*.{h,m}'
    ss.dependency 'TuyaSmartDemo/Base'
    
    ss.dependency 'TuyaSmartBaseKit'
  end
  
  s.subspec 'SmartScene' do |ss|
    ss.source_files = 'TuyaSmartDemo/Classes/SmartScene/**/*.{h,m}'
    ss.resource_bundles = {
      'TuyaSmartDemoSceneBundle' => 'TuyaSmartDemo/Classes/SmartScene/Assets/**/*'
    }
    
    ss.prefix_header_contents = '#ifdef __OBJC__',
    '#import "TYDemoSmartSceneUtil.h"',
    '#endif'
    
    ss.dependency 'TuyaSmartDemo/Base'
    
    ss.dependency 'SDWebImage'
    ss.dependency 'TuyaSmartSceneKit'
  end
  
  s.subspec 'DeviceList' do |ss|
    ss.source_files = 'TuyaSmartDemo/Classes/DeviceList/**/*.{h,m,mm}'
    
    ss.resource_bundles = {
      'TuyaSmartDemoDeviceListBundle' => 'TuyaSmartDemo/Classes/DeviceList/Assets/**/*'
    }
    
    ss.prefix_header_contents = '#ifdef __OBJC__',
    '#import "TYDemoDeviceListUtil.h"',
    '#endif'
    
    ss.dependency 'TuyaSmartDemo/Base'
    
    ss.dependency 'SDWebImage'
    ss.dependency 'TuyaSmartDeviceKit'
  end
  
  s.subspec 'AddDevice' do |ss|
    ss.source_files = 'TuyaSmartDemo/Classes/AddDevice/**/*.{h,m}'
    ss.dependency 'TuyaSmartDemo/Base'
    
    ss.dependency 'SDWebImage'
    ss.dependency 'Masonry'
    ss.dependency 'TuyaSmartActivatorKit'
  end
  
  s.subspec 'UserInfo' do |ss|
    ss.source_files = 'TuyaSmartDemo/Classes/UserInfo/**/*.{h,m}'
    ss.dependency 'TuyaSmartDemo/Base'
  end
end