## Common interface

Server api invoke can be found in `TuyaSmartRequest` class.

**API Description**

Invoke cloud API

```objc
- (void)requestWithApiName:(NSString *)apiName
                  postData:(nullable NSDictionary *)postData
                   getData:(nullable NSDictionary *)getData
                   version:(NSString *)version
                   success:(nullable TYSuccessID)success
                   failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param    | Description      |
| -------- | ---------------- |
| apiName  | API Name         |
| postData | Business Params  |
| getData  | Common Params    |
| version  | API Version      |
| success  | Success Callback |
| failure  | Failure Callback |



**Api example**

| name | description | version | params |
| ------ | ------ | ------ | ------ |
| tuya.m.country.list | get country list | 1.0 | - |

**Code example**

```objc
- (void)getCountryList {
  // self.request = [TuyaSmartRequest alloc] init];

  [self.request requestWithApiName:@"tuya.m.country.list" postData:nil version:@"1.0" success:^(id result) {

  } failure:^(NSError *error) {

  }];

}
```



### Merge interface

**API Description**

Merge multiple api request to one request. Use two api together.

```objc
- (void)addMergeRequestWithApiName:(NSString *)apiName
                          postData:(nullable NSDictionary *)postData
                           version:(NSString *)version
                           success:(nullable TYSuccessID)success
                           failure:(nullable TYFailureError)failure;

- (void)sendMergeRequestWithGetData:(nullable NSDictionary *)getData
                            success:(nullable TYSuccessList)success
                            failure:(nullable TYFailureError)failure;
```

**Param Description**

| Param    | Description      |
| -------- | ---------------- |
| apiName  | API Name         |
| postData | Business Params  |
| version  | API Version      |
| getData  | Common Params    |
| success  | Success Callback |
| failure  | Failure Callback |

**Code example**

```objective-c
- (void)loadHomeDataWithHomeId:(long long)homeId {
  // self.request = [TuyaSmartRequest alloc] init];

  [self.request addMergeRequestWithApiName:@"tuya.m.my.group.mesh.list" postData:@{} version:@"1.0" success:nil failure:nil];
  [self.request addApiRequest:@"tuya.m.location.get" postData:@{@"gid": @(homeId)} version:@"2.0" success:nil failure:nil];

  [self.request sendMergeRequestWithGetData:@{@"gid": @(homeId)} success:success failure:failure];
}

```

