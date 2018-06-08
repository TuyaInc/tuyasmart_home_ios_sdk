//
//  TPWebViewController.m
//  TYLibraryExample
//
//  Created by 冯晓 on 16/2/18.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPWebViewController.h"
#import "TPProgressUtils.h"
#import "TPTopBarView.h"
#import "UIViewController+TPCategory.h"

@interface TPWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView       *webView;
@property (nonatomic, strong) NSString        *url;
@property (nonatomic, strong) TPTopBarView    *topBarView;
@property (nonatomic, strong) TPBarButtonItem *centerTitleItem;

@end

@implementation TPWebViewController

- (instancetype)initWithUrlString:(NSString *)urlString {
    if (self = [super init]) {
        self.url = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self loadWebView];
}

- (void)dealloc {
    _webView.delegate = nil;
    _webView = nil;
    
    [TPProgressUtils hideHUDForView:nil animated:YES];
}

- (void)initView {
    [self initTopBarView];
    [self initWebView];
}

- (void)initTopBarView {
    self.topBarView.leftItem = [TPBarButtonItem leftBackItem:self action:@selector(backButtonTap)];
    
    self.centerTitleItem.title = self.title;
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.bottomLineHidden = NO;
    
    [self.view addSubview:self.topBarView];
}


- (TPTopBarView *)topBarView {
    if (!_topBarView) {
        _topBarView = [TPTopBarView new];
    }
    return _topBarView;
}

- (void)backButtonTap {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (TPBarButtonItem *)centerTitleItem {
//    if (!_centerTitleItem) {
//        _centerTitleItem = [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemCenter title:@"Title"];
//    }
//    return _centerTitleItem;
//}

- (void)initWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT)];
    [_webView.scrollView setBounces:NO];
    [_webView.scrollView setContentOffset:CGPointZero animated:NO];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = MAIN_BACKGROUND_COLOR;
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

- (void)loadWebView {
    if (_url != nil) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
        [self.webView loadRequest:request];
    }
}



#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [TPProgressUtils showMessag:TPLocalizedString(@"loading", @"") toView:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [TPProgressUtils hideHUDForView:webView animated:YES];
    
    [self updateTopViewTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [TPProgressUtils hideHUDForView:webView animated:YES];
    [TPProgressUtils showError:TPLocalizedString(@"load_error", @"")];
}



- (void)updateTopViewTitle:(NSString *)title {
    if (title.length > 0 && self.centerTitleItem.title.length == 0) {
        self.centerTitleItem.title = title;
        self.topBarView.centerItem = self.centerTitleItem;
    }
}

@end

