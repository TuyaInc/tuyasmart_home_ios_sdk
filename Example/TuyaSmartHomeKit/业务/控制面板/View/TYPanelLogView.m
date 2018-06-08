//
//  TYPanelLogView.m
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelLogView.h"
#import "TYPanelLogViewCell.h"


@interface TYPanelLogView() <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSArray     *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TYPanelLogView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    
        [self addSubview:self.tableView];
     
    }
    return self;
}




- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width,self.height)
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = NO;
        
        _tableView.tableHeaderView = [self tableHeaderView];
        
    }
    return _tableView;
}


- (UIView *)tableHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    
    //todo
    UILabel *textLabel = [TPViewUtil simpleLabel:CGRectMake(15, 0, 200, 44) f:14 tc:HEXCOLOR(0x303030) t:@"操作日志"];
    [view addSubview:textLabel];
    
    UILabel *clearLabel = [TPViewUtil simpleLabel:CGRectMake(0, 7, 54 ,28) f:12 tc:HEXCOLOR(0xFF6600) t:@"CLEAR"];
    clearLabel.right = APP_CONTENT_WIDTH - 15;
    clearLabel.textAlignment = NSTextAlignmentCenter;
    clearLabel.layer.borderWidth = 1;
    clearLabel.layer.borderColor = HEXCOLOR(0xFF6600).CGColor;
    clearLabel.layer.cornerRadius = 4;
    [view addSubview:clearLabel];
    
    
    
    return view;
    
    
}



#pragma mark UITableViewDataSource  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSDictionary *item = [_dataSource objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"panelLogCell";
    TYPanelLogViewCell *cell = (TYPanelLogViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TYPanelLogViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.titleLabel.text = @"DpSend Success";
    
    cell.contentLabel.text = @"sadfdsfdsafdsfdsfsd\nsadfdsfdsafdsfdsfsd\nsadfdsfdsafdsfdsfsd\nsadfdsfdsafdsfdsfsd\nsadfdsfdsafdsfdsfsd\nsadfdsfdsafdsfdsfsd\n";
    
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}






@end
