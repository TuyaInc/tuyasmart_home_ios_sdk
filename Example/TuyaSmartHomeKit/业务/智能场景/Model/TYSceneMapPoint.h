//
//  TYSceneMapPoint.h
//  Pods
//
//  Created by 冯晓 on 2017/8/16.
//
//

#import <MapKit/MapKit.h>

@interface TYSceneMapPoint : NSObject  <MKAnnotation>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c;

@end
