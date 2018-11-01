## Shared devices

Two sharing modes are provided.
- Home member based sharing. If you want share all your devices with you families. You can set them to the `TuyaSmartHomeMember` of the home `TuyaSmartHome` so that they can share your devices `TuyaSmartDevice`. Then all members of your home have the permission to control your devices. If one of your home members is set to be the administrator, he will have all permissions to all devices in your home. If your home member is not the administrator, he will only be granted the control permission of devices.
- Device-based sharing. Sometimes, you need to share some devices with your families, and they will solely have control permission to devices you have shared and cannot change names, remove devices, perform firmware upgrade and restore factory setting, etc. but send device control instructions and obtain status updating.

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
