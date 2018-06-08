//
//  TYPeoplePickerController.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 2016/11/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCountryService.h"


@class TYPeoplePickerController;

@protocol TYPeoplePickerControllerDelegate <NSObject>

- (void)peoplePickerController:(TYPeoplePickerController *)controller didselectCountryModel:(TPCountryModel *)model phoneNumber:(NSString *)phoneNumber;

@end

@interface TYPeoplePickerController : NSObject


@property (nonatomic, weak) id <TYPeoplePickerControllerDelegate> delegate;

- (void)show;

@end
