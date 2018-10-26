### Session过期的处理

长期未登录的账号，在访问服务端接口的时候会返回Session过期的错误，需要监听`TuyaSmartUserNotificationUserSessionInvalid`通知，跳转至登录页面重新登录。

```objc

- (void)loadNotification {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInvalid) name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}

- (void)sessionInvalid {
	if ([[TuyaSmartUser sharedInstance] isLogin]) {
		NSLog(@"sessionInvalid");
		// 注销用户
		[[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
		
		//跳转至登录页面
		MyLoginViewController *vc = [[MyLoginViewController alloc] init];
		self.window.rootViewController = vc;
	    [self.window makeKeyAndVisible];
	}
}
```