## 集成SDK

### 使用CocoaPods快速集成（SDK最低支持系统版本8.0）

在`Podfile`文件中添加以下内容：

```ruby
platform :ios, '8.0'

target 'Your_Project_Name' do
	pod "TuyaSmartHomeKit"
end
```

然后在项目根目录下执行`pod update`命令进行集成。

_CocoaPods的使用请参考：[CocoaPods Guides](https://guides.cocoapods.org/)_
_CocoaPods建议更新至最新版本_