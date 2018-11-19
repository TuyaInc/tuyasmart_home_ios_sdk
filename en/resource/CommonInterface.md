## Common interface

Server api invoke can be found in `TuyaSmartRequest` class.

Api example:

| name | description | version | params |
| ------ | ------ | ------ | ------ |
| tuya.m.country.list | get country list | 1.0 | - |

Code example:

```objc
- (void)getCountryList {
  // self.request = [TuyaSmartRequest alloc] init];

  [self.request requestWithApiName:@"tuya.m.country.list" postData:nil version:@"1.0" success:^(id result) {

  } failure:^(NSError *error) {

  }];

}
```

**Attention**

`TuyaSmartRequest` instance should be retained, otherwise, the local object will be released, api request will be canceled, and response with following error:

`Error Domain=NSURLErrorDomain Code=-999 "Canceled"`

See: [ARC Memory Management - Apple Developer Documentation](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)


### Merge interface

Merge multiple api request to one request.

Usage:

Subclass `TYApiMergeService`, then add the requests you want to merge and send.

Example:

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
