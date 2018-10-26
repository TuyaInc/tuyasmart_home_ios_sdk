调用服务端的api接口

```objc

- (void)load {
    //self.request = [TuyaSmartRequest alloc] init];

    /**
	 *  请求服务端接口
	 *
	 *  @param apiName	接口名称
	 *  @param postData 业务入参
	 *  @param version  接口版本号
	 *  @param success  操作成功回调
	 *  @param failure  操作失败回调
	 */
    [self.request requestWithApiName:@"api_name" postData:@"post_data" version:@"api_version" success:^(id result) {
        
    } failure:^(NSError *error) {
        
    }];
	
}


```