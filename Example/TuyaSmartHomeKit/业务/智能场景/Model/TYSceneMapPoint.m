//
//  TYSceneMapPoint.m
//  Pods
//
//  Created by 冯晓 on 2017/8/16.
//
//

#import "TYSceneMapPoint.h"

@implementation TYSceneMapPoint



- (id)initWithCoordinate:(CLLocationCoordinate2D)c {
    self = [super init];
    if(self){
        _coordinate = c;
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
