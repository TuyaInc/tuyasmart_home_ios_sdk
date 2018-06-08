//
//  TPScheduledLocationManager.h
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/17.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol TPScheduledLocationManagerDelegate <NSObject>

- (void)scheduledLocationManageDidFailWithError:(NSError *)error;
- (void)scheduledLocationManageDidUpdateLocations:(CLLocation *)location;

@end


@interface TPScheduledLocationManager : NSObject

@property (nonatomic,weak) id<TPScheduledLocationManagerDelegate> delegate;

- (void)getUserLocationWithInterval:(int)interval;

- (void)stopAllLocation;


@end
