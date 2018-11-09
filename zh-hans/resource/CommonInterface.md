## 通用接口

服务端api调用功能对应`TuyaSmartRequest`类

接口示例：

| 接口名称 | 接口描述 | 接口版本 | 业务入参 |
| ------ | ------ | ------ | ------ |
| tuya.m.country.list | 获取国家列表 | 1.0 | - |

代码示例：

```objc
- (void)getCountryList {
  // self.request = [TuyaSmartRequest alloc] init];

  [self.request requestWithApiName:@"tuya.m.country.list" postData:nil version:@"1.0" success:^(id result) {

  } failure:^(NSError *error) {

  }];

}
```

**注意**

`TuyaSmartRequest`实例对象需要被持有，否则局部变量会被回收，导致网络请求被取消，出现以下错误：

`Error Domain=NSURLErrorDomain Code=-999 "已取消"`

参见：[ARC内存管理 - 苹果开发者文档](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)
