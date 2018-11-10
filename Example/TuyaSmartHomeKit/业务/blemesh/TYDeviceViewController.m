//
//  TYDeviceViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 黄凯 on 2018/11/10.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYDeviceViewController.h"

@interface TYDeviceViewController ()

@property (nonatomic, assign) int r;
@property (nonatomic, assign) int g;
@property (nonatomic, assign) int b;
@property (nonatomic, assign) int w;
@property (nonatomic, assign) int c;

@property (nonatomic, assign) BOOL isWhiteModel;

@end

@implementation TYDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    NSInteger tag = sender.tag;
    switch (tag) {
        case 10:
            // r
            _r = sender.value;
            break;
            
        case 11:
            // g
            _g = sender.value;
            break;
        case 12:
            // b
            _b = sender.value;
            break;
        case 15:
            // wc
            _w = sender.value;
            _c = 255 - sender.value;
            break;
        default:
            break;
    }
    
    
    NSDictionary *command;
    
    
    if (_isWhiteModel) {
        command = @{@"104" : @(_w), @"105" : @(_c)};
    } else {
        command = @{@"101" : @(_r), @"102" : @(_g), @"103" : @(_b)};
    }
    
    int address = [self.deviceModel.nodeId intValue] << 8;
    
    [[TuyaSmartUser sharedInstance].mesh publishNodeId:[NSString stringWithFormat:@"%d", address]  pcc:self.deviceModel.pcc dps:command success:^{
        
        NSLog(@"success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
    
}

- (IBAction)segValueChange:(UISegmentedControl *)sender {
    _isWhiteModel = sender.selectedSegmentIndex == 0;
    
    NSDictionary *command;
    
    if (_isWhiteModel) {
        command = @{@"109" : @"white"};
    } else {
        command = @{@"109" : @"colour"};
    }
    
    int address = [self.deviceModel.nodeId intValue] << 8;
    
    [[TuyaSmartUser sharedInstance].mesh publishNodeId:[NSString stringWithFormat:@"%d", address]  pcc:self.deviceModel.pcc dps:command success:^{
        
        NSLog(@"success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}

- (IBAction)on:(id)sender {
    NSDictionary *command = @{@"1" : @(YES)};
    
    int address = [self.deviceModel.nodeId intValue] << 8;
    
    [[TuyaSmartUser sharedInstance].mesh publishNodeId:[NSString stringWithFormat:@"%d", address]  pcc:self.deviceModel.pcc dps:command success:^{
        
        NSLog(@"success");
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}

- (IBAction)off:(id)sender {
    NSDictionary *command = @{@"1" : @(NO)};
    
    int address = [self.deviceModel.nodeId intValue] << 8;
    
    [[TuyaSmartUser sharedInstance].mesh publishNodeId:[NSString stringWithFormat:@"%d", address]  pcc:self.deviceModel.pcc dps:command success:^{
       
        NSLog(@"success");
    } failure:^(NSError *error) {
         NSLog(@"error %@", error);
    }];
}

@end
