## Common interface

Invoke the api interface of server

```objc

- (void)load {
    //self.request = [TuyaSmartRequest alloc] init];

    /**
	 *  请求服务端接口
	 *
	 *  @param apiName	Name of interface
	 *  @param postData parameter value assigned from service
	 *  @param version  No. of interface.
	 *  @param success  Callback of successful operation
	 *  @param failure  Callback of failed operation
	 */
    [self.request requestWithApiName:@"api_name" postData:@"post_data" version:@"api_version" success:^(id result) {
        
    } failure:^(NSError *error) {
        
    }];
	
}


```