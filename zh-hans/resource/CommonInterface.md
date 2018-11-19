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



### 组合接口

用于多个业务接口一块请求。

需要写一个继承于 `TYApiMergeService` 的请求接口类，然后把需要请求的多个接口放在一块，然后请求的结果也会一块返回。

调用实例：

```objective-c
  // @property (nonatomic, strong) ExampleMergeRequest *service;

  _service = [[ExampleMergeRequest alloc] init];
  [_service loadHomeDataWithHomeId:homeId success:^(NSArray<TYApiMergeModel *> *list) {

  } failure:^(NSError *error) {

  }];
```



ExampleMergeRequest.h

```objective-c
#import <TuyaSmartHomeKit/TYApiMergeService.h>

@interface ExampleMergeRequest : TYApiMergeService

- (void)loadHomeDataWithHomeId:(long long)homeId success:(void (^)(NSArray <TYApiMergeModel *> *list))success failure:(TYFailureError)failure;

@end
```

ExampleMergeRequest.m

```objective-c
#import "ExampleMergeRequest.h"

@implementation ExampleMergeRequest

- (void)loadHomeDataWithHomeId:(long long)homeId success:(void (^)(NSArray <TYApiMergeModel *> *list))success failure:(TYFailureError)failure {

  self.requestList = [NSMutableArray array];

  [self addApiRequest:@"tuya.m.my.group.mesh.list" postData:@{} version:@"1.0"];
  [self addApiRequest:@"tuya.m.location.get" postData:@{@"gid": @(homeId)} version:@"2.0"];

  [self sendRequest:@{@"gid": @(homeId)} success:success failure:failure];
}

@end
```
