### 第三方登录
需要在 `涂鸦开发者平台` - `应用开发` - `第三方登录` 配置对应的`AppID`和`AppSecret`; 
客户端按照各平台要求进行开发，获取到对应的code之后，调用tuyaSDK对应的登录接口。

#### 微信登录
```objc
- (void)loginByWechat {
  	/**
	 *  微信登录
	 *
	 *  @param countryCode 国家区号
	 *  @param code 微信授权登录获取的code
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    [[TuyaSmartUser sharedInstance] loginByWechat:@"your_country_code" code:@"wechat_code" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
		NSLog(@"login failure: %@", error);
    }];
}

```

#### QQ登录
```objc
- (void)loginByQQ {
    /**
	 *  QQ登录
	 *
	 *  @param countryCode 国家区号
	 *  @param userId QQ授权登录获取的userId
	 *  @param accessToken QQ授权登录获取的accessToken
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    [[TuyaSmartUser sharedInstance] loginByQQ:@"your_country_code" openId:@"qq_open_id" accessToken:@"access_token" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
        NSLog(@"login failure: %@", error);
    }];
 
}

```


#### Facebook登录
```objc
- (void)loginByFacebook {
	/**
	 *  facebook登录
	 *
	 *  @param countryCode 国家区号
	 *  @param token facebook授权登录获取的token
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    [[TuyaSmartUser sharedInstance] loginByFacebook:@"your_country_code" token:@"facebook_token" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
        NSLog(@"login failure: %@", error);
    }];
}

```


#### Twitter登录
```objc

- (void)loginByTwitter {
	/**
	 *  twitter登录
	 *
	 *  @param countryCode 国家区号
	 *  @param key twitter授权登录获取的key
	 *  @param secret twitter授权登录获取的secret
	 *  @param success 操作成功回调
	 *  @param failure 操作失败回调
	 */
    [[TuyaSmartUser sharedInstance] loginByTwitter:@"your_country_code" key:@"twitter_key" secret:@"twitter_secret" success:^{
        NSLog(@"login success");
    } failure:^(NSError *error) {
        NSLog(@"login failure: %@", error);
    }];
   
}
```