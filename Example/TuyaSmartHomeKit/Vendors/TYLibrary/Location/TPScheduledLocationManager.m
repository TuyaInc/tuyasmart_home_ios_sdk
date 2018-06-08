//
//  TPScheduledLocationManager.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/17.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPScheduledLocationManager.h"
#import <UIKit/UIKit.h>

@interface TPScheduledLocationManager() <CLLocationManagerDelegate>

@end

int const kMaxBGTime = 170; // 3 min - 10 seconds (as bg task is killed faster)
int const kTimeToGetLocations = 3; // time to wait for locations

@implementation TPScheduledLocationManager
{
    UIBackgroundTaskIdentifier bgTask;
    CLLocationManager *locationManager;
    NSTimer *checkLocationTimer;
    int checkLocationInterval;
    NSTimer *waitForLocationUpdatesTimer;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动00再通知委托处理更新;
        locationManager.distanceFilter = 200.f;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

-(void)getUserLocationWithInterval:(int)interval
{
    if ([self isLocationServiceAvailable] == YES) {
        checkLocationInterval = (interval > kMaxBGTime)? kMaxBGTime : interval;
        if (checkLocationInterval < 1) {
            checkLocationInterval = 1;
        }
        
        [locationManager startUpdatingLocation];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [locationManager requestWhenInUseAuthorization];
            //            [locationManager requestAlwaysAuthorization];
        }
    }
}

- (void)timerEvent:(NSTimer*)theTimer
{
    [self stopCheckLocationTimer];
    [locationManager startUpdatingLocation];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [locationManager requestWhenInUseAuthorization];
        //        [locationManager requestAlwaysAuthorization];
    }
    
    // in iOS 7 we need to stop background task with delay, otherwise location service won't start
    [self performSelector:@selector(stopBackgroundTask) withObject:nil afterDelay:1];
}

-(void)startCheckLocationTimer
{
    [self stopCheckLocationTimer];
    checkLocationTimer = [NSTimer scheduledTimerWithTimeInterval:checkLocationInterval target:self selector:@selector(timerEvent:) userInfo:NULL repeats:NO];
}

-(void)stopCheckLocationTimer
{
    if(checkLocationTimer){
        [checkLocationTimer invalidate];
        checkLocationTimer=nil;
    }
}

-(void)startBackgroundTask
{
    [self stopBackgroundTask];
    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        //in case bg task is killed faster than expected, try to start Location Service
        [self timerEvent:checkLocationTimer];
    }];
}

-(void)stopBackgroundTask
{
    if(bgTask!=UIBackgroundTaskInvalid){
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }
}

-(void)stopWaitForLocationUpdatesTimer
{
    if(waitForLocationUpdatesTimer){
        [waitForLocationUpdatesTimer invalidate];
        waitForLocationUpdatesTimer =nil;
    }
}

-(void)startWaitForLocationUpdatesTimer
{
    [self stopWaitForLocationUpdatesTimer];
    
    [locationManager stopUpdatingLocation];
    
    waitForLocationUpdatesTimer = [NSTimer scheduledTimerWithTimeInterval:kTimeToGetLocations target:self selector:@selector(waitForLoactions:) userInfo:NULL repeats:NO];
}

- (void)waitForLoactions:(NSTimer*)theTimer
{
    [self stopWaitForLocationUpdatesTimer];
    
    if(([[UIApplication sharedApplication ]applicationState]==UIApplicationStateBackground ||
        [[UIApplication sharedApplication ]applicationState]==UIApplicationStateInactive) &&
       bgTask==UIBackgroundTaskInvalid){
        [self startBackgroundTask];
    }
    
    [self startCheckLocationTimer];
    //    NSLog(@"stop location");
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(checkLocationTimer) {
        return;
    }
    
    CLLocation *currLocation = [locations lastObject];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scheduledLocationManageDidUpdateLocations:)]) {
        [self.delegate scheduledLocationManageDidUpdateLocations:currLocation];
    }
    
    if(waitForLocationUpdatesTimer==nil){
        [self startWaitForLocationUpdatesTimer];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scheduledLocationManageDidFailWithError:)]) {
        [self.delegate scheduledLocationManageDidFailWithError:error];
    }
}

//- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
//{
//    NSLog(@"visit : %@", visit);
//
//
//    if (self.delegate && [self.delegate respondsToSelector:@selector(scheduledLocationManageDidVisit:)]) {
//        [self.delegate scheduledLocationManageDidVisit:visit];
//    }
//
//    if ([visit.departureDate isEqualToDate:[NSDate distantFuture]]) {
//
//    } else {
//
//    }
//}

#pragma mark - UIAplicatin notifications

- (void)applicationDidEnterBackground:(NSNotification *) notification
{
    if([self isLocationServiceAvailable]==YES){
        [self startBackgroundTask];
    }
}

- (void)applicationDidBecomeActive:(NSNotification *) notification
{
    [self stopBackgroundTask];
    
    if ([self isLocationServiceAvailable]==NO){
        NSError *error = [NSError errorWithDomain:@"com.tuya.www"
                                             code:1501
                                         userInfo:@{NSLocalizedDescriptionKey : @"Authorization status denied"}];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(scheduledLocationManageDidFailWithError:)]) {
            [self.delegate scheduledLocationManageDidFailWithError:error];
        }
    }
}

#pragma mark - Helpers

-(BOOL)isLocationServiceAvailable
{
    if([CLLocationManager locationServicesEnabled]==NO ||
       [CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied ||
       [CLLocationManager authorizationStatus]==kCLAuthorizationStatusRestricted){
        return NO;
    }else{
        return YES;
    }
}

-(void)stopAllLocation{
    NSLog(@"stop all location");
    [locationManager stopUpdatingLocation];
    [self stopWaitForLocationUpdatesTimer];
    [self stopBackgroundTask];
    [self stopCheckLocationTimer];
    
}

@end
