//
//  TYLoginRegionModel.h
//  Bolts
//
//  Created by lan on 2019/2/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYRegionModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, assign) BOOL isDefault;

@end

NS_ASSUME_NONNULL_END
