## Shared devices

Two sharing modes are provided.
- Home member based sharing. If you want share all your devices with you families. You can set them to the `TuyaSmartHomeMember` of the home `TuyaSmartHome` so that they can share your devices `TuyaSmartDevice`. Then all members of your home have the permission to control your devices. If one of your home members is set to be the administrator, he will have all permissions to all devices in your home. If your home member is not the administrator, he will only be granted the control permission of devices.
- Device-based sharing. Sometimes, you need to share some devices with your families, and they will solely have control permission to devices you have shared and cannot change names, remove devices, perform firmware upgrade and restore factory setting, etc. but send device control instructions and obtain status updating.

### Share with home members

All functions related to the share with home members are realized by using the `TuyaSmartHomeMember` Class.

#### Add home member

Objc:

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

Swift:

```swift
func addShare() {
    homeMember?.add(withHomeId: homeId, countryCode: "your_country_code", account: "account", name: "name", isAdmin: true, success: {
        print("addNewMember success")
    }, failure: { (error) in
        if let e = error {
            print("addNewMember failure: \(e)")
        }
    })
}
```

####  Obtain home member list

Objc:


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

Swift:

```swift
func initMemberList() {
    homeMember?.getListWithHomeId(homeId, success: { (memberList) in
        print("getMemberList success: \(memberList)")
    }, failure: { (error) in
        if let e = error {
            print("getMemberList failure: \(e)")
        }
    })
}
```

#### Change member name and administrator identity

Objc:

```objc
- (void)modifyMemberName:(TuyaSmartHomeMemberModel *)memberModel name:(NSString *)name {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];

	[self.homeMember updateHomeMemberNameWithMemberId:memberModel.memberId name:name isAdmin:YES success:^{
        NSLog(@"modifyMemberName success");
    } failure:^(NSError *error) {
        NSLog(@"modifyMemberName failure: %@", error);
    }];
}
```

Swift:

```swift
func modifyMember(_ memberModel: TuyaSmartHomeMemberModel, name: String) {
    homeMember?.updateHomeMemberName(withMemberId: memberModel.memberId, name: name, isAdmin: true, success: {
        print("modifyMemberName success")
    }, failure: { (error) in
        if let e = error {
            print("modifyMemberName failure: \(e)")
        }
    })
}
```

#### Remove home member

Objc:


```objc
- (void)removeMember:(TuyaSmartHomeMemberModel *)memberModel {
	// self.homeMember = [[TuyaSmartHomeMember alloc] init];

	[self.homeMember removeHomeMemberWithMemberId:memberModel.memberId success:^{
        NSLog(@"removeMember success");
    } failure:^(NSError *error) {
        NSLog(@"removeMember failure: %@", error);
    }];
}
```

Swift:

```swift
func removeMember(_ memberModel: TuyaSmartHomeMemberModel) {
    homeMember?.removeHomeMember(withMemberId: memberModel.memberId, success: {
        print("removeMember success")
    }, failure: { (error) in
        if let e = error {
            print("removeMember failure: \(e)")
        }
    })
}
```
