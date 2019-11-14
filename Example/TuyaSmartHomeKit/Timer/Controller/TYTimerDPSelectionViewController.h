//
//  TYTimerDPSelectionViewController.h
//  TYTimerModule
//
//  Created by Kennaki Kai on 2019/8/26.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TYTimerDPSelectionViewControllerDelegate <NSObject>

- (void)dpSelectionViewItemSelectedAtIndex:(NSInteger)index;

@end
@interface TYTimerDPSelectionViewController : TPBaseViewController

@property (nonatomic, assign) id<TYTimerDPSelectionViewControllerDelegate> delegate;
- (instancetype)initWithValues:(NSArray *)values index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
