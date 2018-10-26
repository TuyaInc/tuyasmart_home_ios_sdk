### Share with home members 

All functions related to the share with home members are realized by using the `TuyaSmartHomeMember` Class.

#### Add home member

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

####  Obtain home member list


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


#### Change member name and administrator identity

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

#### Remove home member


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