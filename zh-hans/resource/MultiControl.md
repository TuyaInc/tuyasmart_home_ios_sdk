## 多控关联

### 概述

设备多控关联是指设备的某个 dp 与另一个设备的某个 dp 之间建立关联，生成一个多控组，当控制多控组内某个建立 dp 关联的设备，组内其他设备关联的 dp 点状态同步。

例如：三个二路 zigbee 子设备开关，每个开关的第一个 dp 点与另外两个开关的第一个 dp 点建立多控组，当控制其中一个开关的第一个 dp 状态为关闭状态，另外两个开关的第一个 dp 同步关闭。

**目前支持 zigbee 子设备、mesh 子设备类型的开关**

**支持跨 pid**

**注:** 目前限制 dpCode 是 `switch_数字` 、`sub_switch_数字`类型的 dp



### 业务流程图

```flow

api1=>operation: 获取设备的 dp 列表信息
api2=>operation: 查询设备下某个 dp 关联的多控和自动化信息
cond1=>condition: 是否已经关联自动化
api2_end=>operation: 不可再关联多控
api3=>operation: 查询支持多控的设备列表
api4=>operation: 选择某个设备后，获取该附属设备的 dp 点信息、已关联的多控、自动化信息
cond2=>condition: dp 点是否已关联其他多控组或自动化
api4_end=>operation: 不可再加入多控组
api5=>operation: 保存或更新多控组

api1->api2->cond1

cond1(no)->api3->api4->cond2
cond1(yes)->api2_end

cond2(no)->api5
cond2(yes)->api4_end

```



### 获取设备的 dp 信息

**接口说明**

从云端获取设备所有dp的名多语言称等信息

```objective-c
- (void)getDeviceDpi18InfoWithDevId:(NSString *)devId success:(void (^)(NSArray<TuyaSmartMultiControlDatapointModel *> *))success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                         |
| ------- | ------------------------------------------------------------ |
| devId   | 设备 id                                                      |
| success | 成功回调 （参数 `NSArray<TuyaSmartMultiControlDatapointModel *> *）` |
| failure | 失败回调                                                     |

**`TuyaSmartMultiControlDatapointModel`字段信息**


| 字段     | 类型     | 说明                       |
| -------- | -------- | -------------------------- |
| dpId     | NSString | 设备 dp id                 |
| name     | NSString | 设备 dp 名称               |
| code     | NSString | 设备 dp 标准名称（dpCode） |
| schemaId | NSString | 按键  dp 所属的 schema Id  |

**示例代码**

**Objc:**

```objective-c
TuyaSmartMultiControl *multiControl = [[TuyaSmartMultiControl alloc] init];
    [multiControl getDeviceDpi18InfoWithDevId:@"your_devId" success:^(NSArray<TuyaSmartMultiControlDatapointModel *> * list) {
        
    } failure:^(NSError *error) {
        
    }];
```

**Swift:**

```swift
let multiControl = TuyaSmartMultiControl.init()
        multiControl.getDeviceDpi18Info(withDevId: "your_devId", success: { (list) in
            
        }) { (error) in
            
        }
```



### 查询某个 dp 的关联信息

**接口说明**

查询当前的设备 dp 关联的多控和自动化详情，当前设备为主设备，关联的其他设备为附属设备

```objective-c
- (void)queryDeviceLinkInfoWithDevId:(NSString *)devId dpId:(NSString *)dpId success:(void (^)(TuyaSmartMultiControlLinkModel *))success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                |
| ------- | --------------------------------------------------- |
| devId   | 主设备 id                                           |
| dpId    | 主设备 dp id                                        |
| success | 成功回调（参数 `TuyaSmartMultiControlLinkModel *`） |
| failure | 失败回调                                            |

**`TuyaSmartMultiControlLinkModel` 字段信息**

| 字段        | 类型                                              | 说明                       |
| ----------- | ------------------------------------------------- | -------------------------- |
| multiGroup  | TuyaSmartMultiControlGroupModel                   | 已关联多控组数据结构       |
| parentRules | NSArray<`TuyaSmartMultiControlParentRuleModel *`> | 已关联的场景自动化数据结构 |

**`TuyaSmartMultiControlGroupModel`字段信息**

| 字段           | 类型                                               | 说明           |
| -------------- | -------------------------------------------------- | -------------- |
| multiControlId | NSString                                           | 多控组id       |
| groupName      | NSString                                           | 多控组名称     |
| groupType      | NSInteger                                          | 多控组类型     |
| groupDetail    | NSArray<`TuyaSmartMultiControlGroupDetailModel *`> | 多控组信息     |
| enabled        | BOOL                                               | 是否开启多控组 |
| multiRuleId    | NSString                                           |                |
| ownerId        | NSString                                           | 家庭 id        |
| uid            | NSString                                           | 用户 id        |

**`TuyaSmartMultiControlGroupDetailModel`字段信息**

| 字段           | 类型                                             | 说明                                     |
| -------------- | ------------------------------------------------ | ---------------------------------------- |
| detailId       | NSString                                         |                                          |
| multiControlId | NSString                                         | 多控组id                                 |
| devId          | NSString                                         | 附属设备 id                              |
| devName        | NSString                                         | 附属设备名称                             |
| dpId           | NSString                                         | 已关联的附属设备的 dp id                 |
| dpName         | NSString                                         | 已关联的附属设备的 dp 名称               |
| enabled        | BOOL                                             | 已关联的附属设备是否可以通过多控功能控制 |
| datapoints     | NSArray<`TuyaSmartMultiControlDatapointModel *`> | dp 点信息                                |

**`TuyaSmartMultiControlParentRuleModel`字段信息**

| 字段   | 类型     | 说明       |
| ------ | -------- | ---------- |
| ruleId | NSString | 自动化 id  |
| name   | NSString | 自动化名称 |

**示例代码**

**Objc:**

```objective-c
TuyaSmartMultiControl *multiControl = [[TuyaSmartMultiControl alloc] init];
    [multiControl queryDeviceLinkInfoWithDevId:@"your_devId" dpId:@"your_dpId" success:^(TuyaSmartMultiControlLinkModel * model) {
        
    } failure:^(NSError *error) {
        
    }];
```

**Swift:**

```swift
let multiControl = TuyaSmartMultiControl.init()
        multiControl.queryDeviceLinkInfo(withDevId: "your_devId", dpId: "your_dpId", success: { (linkModel) in
            
        }) { (error) in
            
        }
```



### 添加、更新、删除多控组

**接口说明**

提供两个方法，可以通过 json 格式数据更新多控组，也可以使用 `TuyaSmartMultiControlModel`。通过此接口可实现为主设备添加其他设备进入多控组，可以更新多控组名称，更新多控组的设备，删除多控组的设备

```objective-c
- (void)updateMultiControlWithDevId:(NSString *)devId requestJSON:(NSDictionary *)json success:(void (^)(TuyaSmartMultiControlModel *))success failure:(TYFailureError)failure;

- (void)updateMultiControlWithDevId:(NSString *)devId requestModel:(TuyaSmartMultiControlModel *)model success:(void (^)(TuyaSmartMultiControlModel *))success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明             |
| ------- | ---------------- |
| devId   | 主设备 id        |
| json    | 多控组的数据结构 |
| model   | 多控组的数据结构 |
| success | 成功回调         |
| failure | 失败回调         |

**json 数据结构：**

```json
{
    "groupName":"多控组1",
    "groupType":1,
    "groupDetail":[{"devId":"adadwfw3e234ferf41","dpId":2, "id":22, "enable":true}],
    "id":122
}
```

**`TuyaSmartMultiControlModel`字段信息**

| 字段           | 类型                                          | 说明                 |
| -------------- | --------------------------------------------- | -------------------- |
| multiControlId | NSString                                      | 多控组 id            |
| groupName      | NSString                                      | 多控组名称           |
| groupType      | NSInteger                                     | 多控组类型。默认为 1 |
| groupDetail    | NSArray<`TuyaSmartMultiControlDetailModel *`> | 多控组信息           |

**`TuyaSmartMultiControlDetailModel`字段信息**

| 字段     | 类型     | 说明                                     |
| -------- | -------- | ---------------------------------------- |
| detailId | NSString |                                          |
| devId    | NSString | 附属设备 id                              |
| dpId     | NSString | 已关联的附属设备的 dp id                 |
| enable   | BOOL     | 已关联的附属设备是否可以通过多控功能控制 |

**示例代码**

**Objc:**

```objective-c
TuyaSmartMultiControl *multiControl = [[TuyaSmartMultiControl alloc] init];
    NSDictionary *requestJSON = @{
        @"groupName" : @"",
        @"groupType" : @(1),
        @"id" : @"",
        @"groupDetail" : @[
                @{
                    @"id" : @"",
                    @"dpId" : @"",
                    @"devId" : @"",
                    @"enable" : @(true),
                }
        ],
    };
    [multiControl updateMultiControlWithDevId:@"your_devId" requestJSON:requestJSON success:^(TuyaSmartMultiControlModel * model) {
        
    } failure:^(NSError *error) {
        
    }];


    TuyaSmartMultiControlDetailModel *detailModel = [[TuyaSmartMultiControlDetailModel alloc] init];
    detailModel.detailId = @"";
    detailModel.dpId = @"";
    detailModel.devId = @"";
    detailModel.enable = true;
    
    TuyaSmartMultiControlModel *model = [[TuyaSmartMultiControlModel alloc] init];
    model.multiControlId = @"";
    model.groupName = @"";
    model.groupType = 1;
    model.groupDetail = @[detailModel];
    [multiControl updateMultiControlWithDevId:@"your_devId" requestModel:model success:^(TuyaSmartMultiControlModel * model) {
        
    } failure:^(NSError *error) {
        
    }];
```

**Swift:**

```swift
let multiControl = TuyaSmartMultiControl.init()
        var json : Dictionary<String, Any>
        json = [
            "groupName" : "",
            "groupType" : 1,
            "id" : "",
            "groupDetail" : [
                    [
                        "id" : "",
                        "dpId" : "",
                        "devId" : "",
                        "enable" : true,
                    ]
            ],
        ]
        multiControl.update(withDevId: "your_devId", requestJSON: json, success: { (model) in
            
        }) { (error) in
            
        }
        
        var detailModel : TuyaSmartMultiControlDetailModel
        detailModel = TuyaSmartMultiControlDetailModel.init()
        detailModel.detailId = ""
        detailModel.dpId = ""
        detailModel.devId = ""
        detailModel.enable = true
        
        var model : TuyaSmartMultiControlModel
        model = TuyaSmartMultiControlModel.init()
        model.multiControlId = ""
        model.groupName = ""
        model.groupType = 1
        model.groupDetail = [detailModel]
        multiControl.update(withDevId: "your_devId", request: model, success: { (model) in
            
        }) { (error) in
            
        }
```



### 启用或禁用多控组

**接口说明**

```objective-c
- (void)setMultiControlEnable:(BOOL)enabled multiControlId:(NSString *)multiControlId success:(TYSuccessBOOL)success failure:(TYFailureError)failure;
```

**参数说明**

| 参数           | 说明       |
| -------------- | ---------- |
| enabled        | 启用或停用 |
| multiControlId | 多控组 Id  |
| success        | 成功回调   |
| failure        | 失败回调   |

**示例代码**

**Objc:**

```objective-c
TuyaSmartMultiControl *multiControl = [[TuyaSmartMultiControl alloc] init];
    [multiControl setMultiControlEnable:true/false multiControlId:@"multiControlId" success:^(BOOL result) {
        
    } failure:^(NSError *error) {
        
    }];
```

**Swift:**

```swift
let multiControl = TuyaSmartMultiControl.init()
        multiControl.setMultiControlEnable(true/false, multiControlId: "multiControlId", success: { (result) in
            
        }) { (error) in
            
        }
```



### 查询支持多控的设备列表

**接口说明**

查询支持多控的设备列表（包括用户的和家庭的）

```objective-c
- (void)getMultiControlDeviceListWithHomeId:(long long)homeId success:(void (^)(NSArray<TuyaSmartMultiControlDeviceModel *> *))success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                         |
| ------- | ------------------------------------------------------------ |
| homeId  | 家庭 id                                                      |
| success | 成功回调（参数 `NSArray<TuyaSmartMultiControlDeviceModel *> *）` |
| failure | 失败回调                                                     |

**`TuyaSmartMultiControlDeviceModel`字段信息**

| 字段            | 类型                                             | 说明                         |
| --------------- | ------------------------------------------------ | ---------------------------- |
| devId           | NSString                                         | 设备 id                      |
| productId       | NSString                                         | 产品 id                      |
| name            | NSString                                         | 设备名称                     |
| iconUrl         | NSString                                         | 设备图标下载链接             |
| roomName        | NSString                                         | 所在房间名                   |
| inRule          | BOOL                                             | 该设备是否在自动化的条件中   |
| datapoints      | NSArray<`TuyaSmartMultiControlDatapointModel *`> | dp 点信息                    |
| multiControlIds | NSArray<`NSString *`>                            | 设备已被关联的多控组 id 数组 |

**示例代码**

**Objc:**

```objective-c
TuyaSmartMultiControl *multiControl = [[TuyaSmartMultiControl alloc] init];
    [multiControl getMultiControlDeviceListWithHomeId:123 success:^(NSArray<TuyaSmartMultiControlDeviceModel *> * list) {
        
    } failure:^(NSError *error) {
        
    }];
```

**Swift:**

```swift
let multiControl = TuyaSmartMultiControl.init()
        multiControl.getDeviceList(withHomeId: 123, success: { (list) in
            
        }) { (error) in
            
        }
```



### 获取附属设备的关联详情

**接口说明**

获取附属设备的 dp 点信息、已关联的多控、自动化信息

```objective-c
- (void)queryDeviceDpRelationWithDevId:(NSString *)devId success:(void (^)(TuyaSmartMultiControlDpRelationModel *))success failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                                                      |
| ------- | --------------------------------------------------------- |
| devId   | 设备 id                                                   |
| success | 成功回调（参数 `TuyaSmartMultiControlDpRelationModel *`） |
| failure | 失败回调                                                  |

**`TuyaSmartMultiControlDpRelationModel`字段说明**

| 字段        | 类型                                              | 说明               |
| ----------- | ------------------------------------------------- | ------------------ |
| datapoints  | NSArray<`TuyaSmartMultiControlDatapointModel *`>  | dp 点信息          |
| mcGroups    | NSArray<`TuyaSmartMcGroupModel *`>                | 已关联的多控组信息 |
| parentRules | NSArray<`TuyaSmartMultiControlParentRuleModel *`> | 已关联的自动化信息 |

**`TuyaSmartMcGroupModel`字段信息**

| 字段           | 类型                                     | 说明           |
| -------------- | ---------------------------------------- | -------------- |
| multiControlId | NSString                                 | 多控组id       |
| groupName      | NSString                                 | 多控组名称     |
| groupDetail    | NSArray<`TuyaSmartMcGroupDetailModel *`> | 多控组关联详情 |
| enabled        | BOOL                                     | 多控组是否可用 |
| groupType      | NSInteger                                | 多控组类型     |
| multiRuleId    | NSString                                 |                |
| ownerId        | NSString                                 | 家庭 id        |
| uid            | NSString                                 | 用户 id        |

**`TuyaSmartMcGroupDetailModel`字段信息**

| 字段           | 类型     | 说明      |
| -------------- | -------- | --------- |
| detailId       | NSString |           |
| dpId           | NSString | dp id     |
| dpName         | NSString | dp 名称   |
| devId          | NSString | 设备 id   |
| devName        | NSString | 设备名称  |
| enabled        | BOOL     | 是否可用  |
| multiControlId | NSString | 多控组 id |

**示例代码**

**Objc:**

```objective-c
TuyaSmartMultiControl *multiControl = [[TuyaSmartMultiControl alloc] init];
    [multiControl queryDeviceDpRelationWithDevId:@"your_devId" success:^(TuyaSmartMultiControlDpRelationModel * model) {
        
    } failure:^(NSError *error) {
        
    }];
```

**Swift:**

```swift
let multiControl = TuyaSmartMultiControl.init()
        multiControl.queryDeviceDpRelation(withDevId: "your_devId", success: { (model) in
            
        }) { (error) in
            
        }
```