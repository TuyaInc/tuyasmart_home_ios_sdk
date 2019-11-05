//
//  TYPanelBaseViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by 温明妍 on 2019/11/4.
//  Copyright © 2019 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"

@interface TYPanelBaseViewController : TPBaseViewController

// 子类重写
- (BOOL)isOfflineLabelNeedShow;
// 子类重写
- (NSArray<TuyaSmartSchemaModel *> *)schemaArray;
// 子类重写
- (NSDictionary *)dps;
// 子类重写
- (void)publishDps:(NSDictionary *)dictionary success:(nullable TYSuccessHandler)success failure:(nullable TYFailureError)failure;

- (void)updateOfflineView;

- (void)reloadDatas;

@end
