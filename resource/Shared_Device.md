### 设备共享 （基于设备维度的共享）

设备共享相关的所有功能对应`TuyaSmartHomeDeviceShare`类

#### 添加共享


```objc

- (void)addMemberShare {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
	
    [self.deviceShare addShareWithHomeId:homeId countryCode:@"your_country_code" userAccount:@"user_account" devIds:(NSArray<NSString *> *) success:^(TuyaSmartShareMemberModel *model) {
        NSLog(@"addShare success");
    } failure:^(NSError *error) {
        NSLog(@"addShare failure: %@", error);
    }];
}
	
```

#### 添加共享 （新增，不覆盖旧的分享）

```objc

- (void)addMemberShare {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
	
    [self.deviceShare addShareWithMemberId:memberId devIds:(NSArray<NSString *> *) success:^{
        NSLog(@"addShare success");
    } failure:^(NSError *error) {
        NSLog(@"addShare failure: %@", error);
    }];
}
	
```


#### 获取共享的用户列表

获取所有主动共享的用户列表

```objc

- (void)getShareMemberList {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
	[self.deviceShare getShareMemberListWithHomeId:homeId success:^(NSArray<TuyaSmartShareMemberModel *> *list)
	    
		NSLog(@"getShareMemberList success");
	
	} failure:^(NSError *error) {
	    
		NSLog(@"getShareMemberList failure: %@", error);

	}];
	
}
	
```

获取所有收到共享的用户列表

```objc

- (void)getReceiveMemberList {
	//self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
	[self.deviceShare getReceiveMemberListWithSuccess:^(NSArray<TuyaSmartShareMemberModel *> *list) {
	    
		NSLog(@"getReceiveMemberList success");
	
	} failure:^(NSError *error) {
	    
		NSLog(@"getReceiveMemberList failure: %@", error);

	}];
    
}
```

#### 获取用户共享数据

获取单个主动共享的用户共享数据

```objc

- (void)getShareMemberDetail {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare getShareMemberDetailWithMemberId:memberId success:^(TuyaSmartShareMemberDetailModel *model) {
    
    	NSLog(@"getShareMemberDetail success");
        
    } failure:^(NSError *error) {

    	NSLog(@"getShareMemberDetail failure: %@", error);

    }];
    
}
```


获取单个收到共享的用户共享数据

```objc

- (void)getReceiveMemberDetail {
    //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare getReceiveMemberDetailWithMemberId:memberId success:^(TuyaSmartReceiveMemberDetailModel *model) {
    
    	NSLog(@"getReceiveMemberDetail success");
        
    } failure:^(NSError *error) {

    	NSLog(@"getReceiveMemberDetail failure: %@", error);

    }];
    
}
```

#### 删除共享

删除主动共享者

```objc

- (void)removeShareMember {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeShareMemberWithMemberId:memberId success:^{
        
    	NSLog(@"removeShareMember success");

    } failure:^(NSError *error) {
    
    	NSLog(@"removeShareMember failure: %@", error);

    }];
    
}
     
```


删除收到共享者

```objc

- (void)removeReceiveMember {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeReceiveShareMemberWithMemberId:memberId success:^{
        
    	NSLog(@"removeReceiveMember success");

    } failure:^(NSError *error) {
    
    	NSLog(@"removeReceiveMember failure: %@", error);

    }];
    
} 
```

#### 修改昵称

修改主动共享者的昵称

```objc

- (void)updateShareMemberName {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare renameShareMemberNameWithMemberId:memberId name:@"new_name" success:^{
        
    	NSLog(@"updateShareMemberName success");
    	
    } failure:^(NSError *error) {
        
    	NSLog(@"updateShareMemberName failure: %@", error);

    }];
     
```

修改收到共享者的昵称

```objc

- (void)updateReceiveMemberName {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare renameReceiveShareMemberNameWithMemberId:memberId name:@"new_name" success:^{
        
    	NSLog(@"updateReceiveMemberName success");
    	
    } failure:^(NSError *error) {
        
    	NSLog(@"updateReceiveMemberName failure: %@", error);

    }];
     
}
```

#### 单设备共享操作

单设备添加共享

```objc

- (void)addDeviceShare {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare addDeviceShareWithHomeId:homeId countryCode:@"country_code" userAccount:@"user_account" devId:@"dev_id" success:^(TuyaSmartShareMemberModel *model) {
        
    	NSLog(@"addDeviceShare success");
            	
    } failure:^(NSError *error) {
        
		NSLog(@"addDeviceShare failure: %@", error);
        
    }];
    
}
     
```


单设备删除共享

```objc

- (void)removeDeviceShare {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeDeviceShareWithMemberId:memberId devId:@"dev_id" success:^{
        
    	NSLog(@"removeDeviceShare success");
            	
    } failure:^(NSError *error) {
        
		NSLog(@"removeDeviceShare failure: %@", error);
        
    }];
     
 }
```


删除收到的共享设备 

```objc

- (void)removeDeviceShare {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare removeReceiveDeviceShareWithDevId:@"dev_id" success:^{
        
    	NSLog(@"removeDeviceShare success");
            	
    } failure:^(NSError *error) {
        
		NSLog(@"removeDeviceShare failure: %@", error);
        
    }];
    
}
     
```


#### 获取设备共享用户列表

```objc

- (void)getDeviceShareMemberList {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
    [self.deviceShare getDeviceShareMemberListWithDevId:@"dev_id" success:^(NSArray<TuyaSmartShareMemberModel *> *list) {
        
        NSLog(@"getDeviceShareMemberList success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"getDeviceShareMemberList failure: %@", error);
	
    }];
    
}
         
```

#### 获取设备分享来自哪里

```objc

- (void)getShareInfo {
	 //self.deviceShare  = [[TuyaSmartHomeDeviceShare alloc] init];
		
	 [self.deviceShare getShareInfoWithDevId:@"dev_id" success:^(TuyaSmartReceivedShareUserModel *model) {
	         
        NSLog(@"get shareInfo success");
        
    } failure:^(NSError *error) {
        
        NSLog(@"get shareInfo failure: %@", error);
	
    }];
	 
}
         
```