//
//  TYDemoConfiguration.m
//  Pods
//
//  Created by huangkai on 2020/6/2.
//

#import "TYDemoConfiguration.h"
#import "TPDemoNavigationController.h"

static NSMutableArray<Class> *TYTabBarClasses;
NSArray<Class> *TYGetTabBarClasses(void)
{
    return TYTabBarClasses;
}

void TYRegisterTabBar(Class);
void TYRegisterTabBar(Class vcClass)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TYTabBarClasses = [NSMutableArray new];
    });
    
    [TYTabBarClasses addObject:vcClass];
}

@interface TYDemoConfiguration ()

@property (nonatomic, strong) NSArray<UIViewController<TYTabBarVCProtocol> *> *tabBars;

@property (nonatomic, strong) NSMapTable<NSString *, id> *moduleMapping;
@end

@implementation TYDemoConfiguration

+ (instancetype)sharedInstance {
    static TYDemoConfiguration *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TYDemoConfiguration new];
    });
    return instance;
}

- (NSArray<__kindof UIViewController *> *)tabBars {
    if (!_tabBars) {
        
        NSMutableArray *vcs = [NSMutableArray array];
        for (Class cls in TYTabBarClasses) {
            id instance = [[cls alloc] init];
            
            if ([instance conformsToProtocol:@protocol(TYTabBarVCProtocol)] && [instance isKindOfClass:UIViewController.class]) {
                UIViewController<TYTabBarVCProtocol> *vc = (UIViewController<TYTabBarVCProtocol> *)instance;
                
                [vc setTitle:NSLocalizedString(@"Device", @"")];
                vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:vc.barTitle
                                                              image:vc.barImage
                                                      selectedImage:vc.barSelectedImage];
                
                if (vc.needNavigation) {
                    TPDemoNavigationController *nav = [[TPDemoNavigationController alloc] initWithRootViewController:vc];
                    [vcs addObject:nav];
                } else {
                    [vcs addObject:vc];
                }
            }
            
        }
        
        _tabBars = [vcs copy];
        
    }
    
    return _tabBars;
}

- (NSMapTable<NSString *,id> *)moduleMapping {
    if (!_moduleMapping) {
        _moduleMapping = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _moduleMapping;
}

- (BOOL)registService:(Protocol *)protocol withImpl:(id)impl {
    NSString *protocolStr = NSStringFromProtocol(protocol);
    if (protocolStr) {
        if (![self.moduleMapping objectForKey:protocolStr]) {
            [self.moduleMapping setObject:impl forKey:protocolStr];
            
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)unregistServiceOfProtocol:(Protocol *)protocol {
    if (NSStringFromProtocol(protocol)) {
        [self.moduleMapping removeObjectForKey:NSStringFromProtocol(protocol)];
    }
}

- (nullable id)serviceOfProtocol:(Protocol *)protocol {
    NSString *protocolStr = NSStringFromProtocol(protocol);
    if (protocolStr) {
        if ([self.moduleMapping objectForKey:protocolStr]) {
            return [self.moduleMapping objectForKey:protocolStr];
        }
    }
    return nil;
}

@end
