//
//  TYTimerDPSelectionViewController.m
//  TYTimerModule
//
//  Created by Kennaki Kai on 2019/8/26.
//

#import "TYTimerDPSelectionViewController.h"
#import "RepeatWeekView.h"

@interface TYTimerDPSelectionViewController ()

@property (nonatomic, strong) NSArray *values;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *itemViews;
@end

@implementation TYTimerDPSelectionViewController

- (instancetype)initWithValues:(NSArray *)values index:(NSInteger)index {
    if (self = [super init]) {
        self.itemViews = NSMutableArray.array;
        self.values = values;
        self.currentIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topBarView.leftItem = self.leftBackItem;
    NSInteger index = 0;
    CGFloat top = 0;
    UIScrollView *scrollPanel = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  100, TY_ScreenWidth(), [UIApplication sharedApplication].keyWindow.frame.size.height - 100)];
    [self.view addSubview:scrollPanel];

    for (NSString *v in self.values) {
        top = 16 + index * 44;
        RepeatWeekView *aV = [[RepeatWeekView alloc] initWithFrame:CGRectMake(0, top, TY_ScreenWidth(), 44) valueStr:v];
        [scrollPanel addSubview:aV];
        aV.tag = index;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = aV.bounds;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = index;
        [aV addSubview:btn];
        [self.itemViews addObject:aV];
        index ++;
    }
    scrollPanel.contentSize = CGSizeMake(0, top + 44);
    [self reloadItemViews];
}

- (void)buttonPressed:(UIButton *)sender {
    self.currentIndex = sender.tag;
    [self reloadItemViews];
}

- (void)reloadItemViews {
    for (RepeatWeekView *aV in self.itemViews) {
        [aV setSelected:(aV.tag == self.currentIndex)];
    }
    if ([self.delegate respondsToSelector:@selector(dpSelectionViewItemSelectedAtIndex:)]) {
        [self.delegate dpSelectionViewItemSelectedAtIndex:self.currentIndex];
    }
}

@end
