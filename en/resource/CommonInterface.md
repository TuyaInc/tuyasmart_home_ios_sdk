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
