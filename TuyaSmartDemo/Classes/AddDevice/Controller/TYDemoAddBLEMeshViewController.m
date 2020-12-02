//
//  TYAddBLEMeshViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by milong on 2020/7/21.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYDemoAddBLEMeshViewController.h"
#import "TYDemoAddDeviceUtils.h"
#import "TYDemoSmartHomeManager.h"
#import "TYDemoBleDeviceListViewController.h"
#import "TPDemoProgressUtils.h"

@interface TYDemoAddBLEMeshViewController () <TuyaSmartSIGMeshManagerDelegate>

@property (nonatomic, strong) UILabel     *productIdLabel;
@property (nonatomic, strong) UITextField *productIdTextField;
@property (nonatomic, strong) UILabel     *consoleLabel;
@property (nonatomic, strong) UITextView  *consoleTextView;
@property (nonatomic, strong) UIButton    *scanButton;
@property (nonatomic, strong) UIButton    *stopScanButton;
@property (nonatomic, strong) UIAlertController *actionSheet;
//扫描到的ble mesh设备
@property (nonatomic, strong) NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *meshModelArray;
//配网成功设备node Id 集合
@property (nonatomic, strong) NSMutableArray *nodeIdArray;
//配网成功设备 device id集合
@property (nonatomic, strong) NSMutableArray *devIdArray;

@property (nonatomic, strong) TYAlertMessgeView *alertMessageView;
@end

@implementation TYDemoAddBLEMeshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.topBarView.leftItem = self.leftBackItem;
    self.centerTitleItem.title = @"Add BLE Mesh";
    self.topBarView.centerItem = self.centerTitleItem;
    
    CGFloat currentY = self.topBarView.height;
    currentY += 10;
    CGFloat labelWidth = 75;
    CGFloat textFieldWidth = APP_SCREEN_WIDTH - labelWidth - 30;
    CGFloat labelHeight = 44;
    
    //init product id
    self.productIdLabel.frame = CGRectMake(10, currentY, labelWidth, labelHeight);
    [self.view addSubview:self.productIdLabel];
    self.productIdTextField.frame = CGRectMake(labelWidth + 20, currentY, textFieldWidth, labelHeight);
    [self.view addSubview:self.productIdTextField];
    currentY += labelHeight;
    
    //init console
    currentY += 10;
    self.consoleLabel.frame = CGRectMake(10, currentY, labelWidth, labelHeight);
    [self.view addSubview:self.consoleLabel];
    currentY += labelHeight;
    self.consoleTextView.frame = CGRectMake(10, currentY, APP_SCREEN_WIDTH - 20, 220);
    [self.view addSubview:self.consoleTextView];
    currentY += self.consoleTextView.frame.size.height;
    
    //init button
    currentY += 10;
    self.scanButton.frame = CGRectMake(10, currentY, APP_SCREEN_WIDTH - 20, labelHeight);
    [self.view addSubview:self.scanButton];
    currentY += labelHeight;
    
    currentY += 10;
    self.stopScanButton.frame = CGRectMake(10, currentY, APP_SCREEN_WIDTH - 20, labelHeight);
    [self.view addSubview:self.stopScanButton];
    
}

- (void)appendConsoleLog:(NSString *)logString {
    if (!logString) {
        logString = [NSString stringWithFormat:@"%@ : param error",NSStringFromSelector(_cmd)];
    }
    NSString *result = self.consoleTextView.text?:@"";
    result = [[result stringByAppendingString:logString] stringByAppendingString:@"\n"];
    self.consoleTextView.text = result;
    [self.consoleTextView scrollRangeToVisible:NSMakeRange(result.length, 1)];
}

/// 扫描蓝牙设备
- (void)scanMeshDevice {
    [self appendConsoleLog:@"start listening mesh devices ..."];
    [self.meshModelArray removeAllObjects];
    [self.devIdArray removeAllObjects];
    TuyaSmartBleMeshModel *sigMeshModel = [TuyaSmartHome homeWithHomeId:[TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId].sigMeshModel;
    [[TuyaSmartSIGMeshManager sharedInstance] startScanWithScanType:ScanForUnprovision meshModel:sigMeshModel];
    [TuyaSmartSIGMeshManager sharedInstance].delegate = self;
}


- (void)stopScanMeshDeviceClick {
    [TuyaSmartSIGMeshManager.sharedInstance stopActiveDevice];
}

- (void)showAllMessDevice {
    WEAKSELF_AT
    if (!self.alertMessageView) {
        self.alertMessageView = [[TYAlertMessgeView alloc] initWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT - 210, APP_SCREEN_WIDTH, 200)];
        [self.view addSubview:self.alertMessageView];
        [self.alertMessageView showTtile:@"扫描设备" Message:[NSString stringWithFormat:@"共扫描到 %lu mesh设备",(unsigned long)self.meshModelArray.count] completeBlock:^{
            //跳转到下个展示页面
            [weakSelf_AT meshListView];
        } cancelBlock:^{
            [weakSelf_AT.meshModelArray removeAllObjects];
            [TuyaSmartSIGMeshManager.sharedInstance stopActiveDevice];
        }];
    } else {
        [self.alertMessageView updateMessage:[NSString stringWithFormat:@"共扫描到 %lu mesh设备",(unsigned long)self.meshModelArray.count]];
    }
    
    
}

- (void)meshListView {
    WEAKSELF_AT
    TYDemoBleDeviceListViewController *deviceListVC = [[TYDemoBleDeviceListViewController alloc] init];
    deviceListVC.meshModelArray = [NSArray arrayWithArray:self.meshModelArray];
    [deviceListVC setSelectedDeviceBlock:^(NSMutableArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> * _Nonnull selectedDevices) {
        [weakSelf_AT activeBleMesh:selectedDevices];
    }];
    [self.navigationController pushViewController:deviceListVC animated:YES];
}

- (void)activeBleMesh:(NSArray<TuyaSmartSIGMeshDiscoverDeviceInfo *> *)messArray {
    TuyaSmartBleMeshModel *sigMeshModel = [TuyaSmartHome homeWithHomeId:[TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId].sigMeshModel;
    [[TuyaSmartSIGMeshManager sharedInstance] startActive:self.meshModelArray meshModel:sigMeshModel];
    
    [TPDemoProgressUtils showMessag:@"start activate" toView:self.view];
    
    WEAKSELF_AT
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TPDemoProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
    });
}


#pragma mark -- TuyaSmartSIGMeshManager delegate

/// 扫描到待配网的设备
/// @param manager  mesh manager
/// @param device  待配网设备信息
- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didScanedDevice:(TuyaSmartSIGMeshDiscoverDeviceInfo *)device  {
    [self.meshModelArray addObject:device];
    [self appendConsoleLog:[NSString stringWithFormat:@"find device,device id is: %@",device.mac]];
    [self showAllMessDevice];
}

/**
 激活设备成功回调

 @param manager mesh manager
 @param device 设备
 @param devId 设备 Id
 @param error 激活中的错误，若发生错误，`name` 以及 `deviceId` 为空
*/

- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didActiveSubDevice:(nonnull TuyaSmartSIGMeshDiscoverDeviceInfo *)device devId:(nonnull NSString *)devId error:(nonnull NSError *)error {
    [self appendConsoleLog:[NSString stringWithFormat:@"activate success! mac:%@",device.mac]];
    [self.devIdArray addObject:device];
    [TPDemoProgressUtils showMessag:[NSString stringWithFormat:@"finish activate count of devices:%ld/%ld",self.devIdArray.count,self.meshModelArray.count] toView:self.view];
    
}

- (void)sigMeshManager:(TuyaSmartSIGMeshManager *)manager didFailToActiveDevice:(nonnull TuyaSmartSIGMeshDiscoverDeviceInfo *)device error:(nonnull NSError *)error {
    [self appendConsoleLog:[NSString stringWithFormat:@"activate failed! devId Id:%@",device.mac]];
}

- (void)didFinishToActiveDevList {
    
   
    [self performSelector:@selector(hideHudView) withObject:nil afterDelay:2.0];
    [self appendConsoleLog:@"activate finish"];
}

- (void)hideHudView {
     [TPDemoProgressUtils showSuccess:@"activate finish" toView:self.view];
}


#pragma mark -- setter and getter method

- (UILabel *)productIdLabel {
    if (!_productIdLabel) {
        _productIdLabel = [sharedAddDeviceUtils() keyLabel];
        _productIdLabel.text = @"product id:";
    }
    return _productIdLabel;
}

- (UITextField *)productIdTextField {
    if (!_productIdTextField) {
        _productIdTextField = [sharedAddDeviceUtils() textField];
        _productIdTextField.placeholder = @"product id cannot b entered";
        _productIdTextField.enabled = NO;
    }
    return _productIdTextField;
}

- (UILabel *)consoleLabel {
    if (!_consoleLabel) {
        _consoleLabel = [sharedAddDeviceUtils() keyLabel];
        _consoleLabel.text = @"console:";
    }
    return _consoleLabel;
}

- (UITextView *)consoleTextView {
    if (!_consoleTextView) {
        _consoleTextView = [UITextView new];
        _consoleTextView.layer.borderColor = UIColor.blackColor.CGColor;
        _consoleTextView.layer.borderWidth = 1;
        _consoleTextView.editable = NO;
        _consoleTextView.layoutManager.allowsNonContiguousLayout = NO;
        _consoleTextView.backgroundColor = HEXCOLOR(0xededed);
    }
    return _consoleTextView;
}

- (UIButton *)scanButton {
    if (!_scanButton) {
        _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanButton.layer.cornerRadius = 5;
        [_scanButton setTitle:@"Scan ble device" forState:UIControlStateNormal];
        _scanButton.backgroundColor = UIColor.orangeColor;
        [_scanButton addTarget:self action:@selector(scanMeshDevice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}


- (UIButton *)stopScanButton {
    if (!_stopScanButton) {
        _stopScanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopScanButton.layer.cornerRadius = 5;
        [_stopScanButton setTitle:@"Stop scan ble device" forState:UIControlStateNormal];
        _stopScanButton.backgroundColor = UIColor.orangeColor;
        [_stopScanButton addTarget:self action:@selector(stopScanMeshDeviceClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopScanButton;
}

- (NSMutableArray *)meshModelArray {
    if (!_meshModelArray) {
        _meshModelArray = [[NSMutableArray alloc] init];
    }
    return _meshModelArray;
}

- (NSMutableArray *)nodeIdArray {
    if (!_nodeIdArray) {
        _nodeIdArray = [[NSMutableArray alloc] init];
    }
    return _nodeIdArray;
}

- (NSMutableArray *)devIdArray {
    if (!_devIdArray) {
        _devIdArray = [[NSMutableArray alloc] init];
    }
    return _devIdArray;
}

@end

@interface TYAlertMessgeView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) CALayer *lineLayer;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, copy) TYMessageHandlerBlock sureBtnClickBlock;
@property (nonatomic, copy) TYMessageHandlerBlock cancelBtnClickBlock;


@end

@implementation TYAlertMessgeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}


- (void)updateMessage:(NSString *)message {
    self.messageLabel.text = message;
    self.hidden = NO;
}

- (void)showTtile:(NSString *)title Message:(NSString *)message
    completeBlock:(TYMessageHandlerBlock)completeBlock
      cancelBlock:(TYMessageHandlerBlock)cancelBlock {
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    self.sureBtnClickBlock = completeBlock;
    self.cancelBtnClickBlock = cancelBlock;
    self.hidden = NO;
}

- (void)createView {
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = HEXCOLOR(0xededed);
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.sureButton];
    [self.contentView addSubview:self.cancelButton];
    [self.contentView.layer addSublayer:self.lineLayer];
    self.lineLayer.frame = CGRectMake(0, 50, APP_SCREEN_WIDTH, 1);
    self.contentView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 200);
    self.titleLabel.frame = CGRectMake(20, 20, APP_SCREEN_WIDTH - 40, 20);
    self.messageLabel.frame = CGRectMake(20, 60, APP_SCREEN_WIDTH - 40, 40);
    self.sureButton.frame = CGRectMake(20, 130, 150, 40);
    self.cancelButton.frame = CGRectMake(APP_SCREEN_WIDTH - 20 -150, 130, 150, 40);
}

- (void)sureButtonClick:(id)sender {
    if (self.sureBtnClickBlock) {
        self.sureBtnClickBlock();
    }
    self.hidden = YES;
}

- (void)cancelButtonClick:(id)sender {
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
    }
    self.hidden = YES;
}

#pragma mark -- setter and getter methods

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"去配网" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.backgroundColor = UIColor.orangeColor;
    }
    return _sureButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.backgroundColor = UIColor.orangeColor;
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font =  [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.backgroundColor = [UIColor grayColor].CGColor;
    }
    return _lineLayer;
}

@end
