### 家庭成员共享 

家庭成员共享相关的所有功能对应`TuyaSmartHomeMember`类

#### 添加家庭成员

```objc
- (void)addShare {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
	
	[self.homeMember addHomeMemberWithHomeId:homeId countryCode:@"your_country_code" account:@"account" name:@"name" isAdmin:YES success:^{
        NSLog(@"addNewMember success");
    } failure:^(NSError *error) {
        NSLog(@"addNewMember failure: %@", error);
    }];
}
```

####  获取家庭成员列表


```objc
- (void)initMemberList {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
	
	[self.homeMember getHomeMemberListWithHomeId:homeId success:^(NSArray<TuyaSmartHomeMemberModel *> *memberList) {
        NSLog(@"getMemberList success: %@", memberList);
    } failure:^(NSError *error) {
        NSLog(@"getMemberList failure");
    }];
}
```


#### 修改家庭成员的备注名称和是否是管理员

```objc
- (void)modifyMemberName:(TuyaSmartMemberModel *)memberModel name:(NSString *)name {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];

	[self.homeMember updateHomeMemberNameWithMemberId:memberModel.memberId name:name isAdmin:YES success:^{
        NSLog(@"modifyMemberName success");
    } failure:^(NSError *error) {
        NSLog(@"modifyMemberName failure: %@", error);
    }];
}
```

#### 删除家庭成员


```objc
- (void)removeMember:(TuyaSmartMemberModel *)memberModel {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];
	
	[self.homeMember removeHomeMemberWithMemberId:memberModel.memberId success:^{
        NSLog(@"removeMember success");
    } failure:^(NSError *error) {
        NSLog(@"removeMember failure: %@", error);
    }];
}
```