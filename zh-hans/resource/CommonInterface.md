## 通用接口

服务端 API 调用功能对应 `TuyaSmartRequest` 类

**接口说明**

调用服务端 API

```objc
- (void)requestWithApiName:(NSString *)apiName
                  postData:(nullable NSDictionary *)postData
                   getData:(nullable NSDictionary *)getData
                   version:(NSString *)version
                   success:(nullable TYSuccessID)success
                   failure:(nullable TYFailureError)failure;
```



**参数说明**

| 参数     | 说明       |
| -------- | ---------- |
| apiName  | API 名称   |
| postData | 业务参数   |
| getData  | 公共参数   |
| version  | API 版本号 |
| success  | 成功回调   |
| failure  | 失败回调   |



**代码示例**

```objc
- (void)getCountryList {
  // self.request = [TuyaSmartRequest alloc] init];

  [self.request requestWithApiName:@"tuya.m.country.list" postData:nil version:@"1.0" success:^(id result) {

  } failure:^(NSError *error) {

  }];

}
```



### 组合接口

**接口说明**

用于多个业务接口一块请求，两个方法需要一起使用。

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



**参数说明**

| 参数     | 说明      |
| -------- | --------- |
| apiName  | API名称   |
| postData | 业务参数  |
| version  | API版本号 |
| getData  | 公共参数  |
| success  | 成功回调  |
| failure  | 失败回调  |



**代码示例**

```objective-c
- (void)loadHomeDataWithHomeId:(long long)homeId {
  // self.request = [TuyaSmartRequest alloc] init];

  [self.request addMergeRequestWithApiName:@"tuya.m.my.group.mesh.list" postData:@{} version:@"1.0" success:nil failure:nil];
  [self.request addApiRequest:@"tuya.m.location.get" postData:@{@"gid": @(homeId)} version:@"2.0" success:nil failure:nil];

  [self.request sendMergeRequestWithGetData:@{@"gid": @(homeId)} success:success failure:failure];
}

```
