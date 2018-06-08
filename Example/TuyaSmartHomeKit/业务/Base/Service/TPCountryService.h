//
//  TPCountryService.h
//  Pods
//
//  Created by 冯晓 on 2017/7/26.
//
//

#import <TuyaSmartHomeKit/TYModel.h>


@interface TPCountryModel : TYModel

@property (nonatomic, strong) NSString *countryCode;//国家码
@property (nonatomic, strong) NSString *countryAbb;//国家缩写
@property (nonatomic, strong) NSString *countryName;//国家名
@property (nonatomic, strong) NSString *firstLetter;//名称首字母


@end


@interface TPCountryService : TuyaSmartRequest


- (void)getCountryList:(void(^)(NSArray<TPCountryModel *> *list))success
               failure:(TYFailureError)failure;


+ (TPCountryModel *)getCurrentCountryModel;

+ (TPCountryModel *)getCountryModel:(NSString *)countryCode;

+ (NSArray *)getDefaultPhoneCodeList;

@end
