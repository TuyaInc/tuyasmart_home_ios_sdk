//
//  TPInstagramLoginViewController.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/3/10.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPInstagramLoginViewController.h"
#import "InstagramKit.h"

@interface TPInstagramLoginViewController() <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView       *webView;
@property (nonatomic, strong) TPTopBarView    *topBarView;
@property (nonatomic, strong) TPBarButtonItem *leftBackItem;
@property (nonatomic, strong) TPBarButtonItem *centerTitleItem;

@end

@implementation TPInstagramLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
//    [[InstagramEngine sharedEngine] logout];
    
    [self initTopBarView];
    [self initWebView];
    [self loadWebView];
    
}

- (void)dealloc {
    _webView.delegate = nil;
    _webView = nil;
    
    [TPProgressUtils hideHUDForView:nil animated:YES];
}

- (void)initTopBarView {
    self.topBarView.leftItem = self.leftBackItem;
    
    self.centerTitleItem.title = TPSocialLocalizedString(@"login", nil);
    self.topBarView.centerItem = self.centerTitleItem;
    
    [self.view addSubview:self.topBarView];
}


- (TPTopBarView *)topBarView {
    if (!_topBarView) {
        _topBarView = [TPTopBarView new];
    }
    return _topBarView;
}

- (TPBarButtonItem *)leftBackItem {
    if (!_leftBackItem) {
        _leftBackItem = [[TPBarButtonItem alloc ] initWithBarButtonSystemItem:TPBarButtonSystemItemLeftWithoutIcon title:TPSocialLocalizedString(@"Cancel", @"") target:self action:@selector(backButtonTap)];
    }
    return _leftBackItem;
}


- (TPBarButtonItem *)centerTitleItem {
    if (!_centerTitleItem) {
        _centerTitleItem = [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemCenter title:@"Title"];
    }
    return _centerTitleItem;
}

- (void)initWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT)];
    [_webView.scrollView setBounces:NO];
    [_webView.scrollView setContentOffset:CGPointZero animated:NO];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}


- (void)backButtonTap {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)loadWebView {
    
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
    
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSError *error;
    if ([[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:request.URL error:&error])
    {
        [self authenticationSuccess];
    }
    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)authenticationSuccess {
    
    if ([self.delegate respondsToSelector:@selector(didSuccessLogin:accessToken:)]) {
        [self.delegate didSuccessLogin:self accessToken:[InstagramEngine sharedEngine].accessToken];
    }
}
@end
