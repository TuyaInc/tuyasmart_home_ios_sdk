//
//  TYDemoTheme.h
//  TuyaSmartPublic
//
//  Created by 高森 on 2017/3/9.
//  Copyright © 2017年 Tuya. All rights reserved.
//

//----------------- 配色 -----------------//

//导航栏、TabBar相关
#define TOP_BAR_TEXT_COLOR          [TYDemoTheme theme].status_font_color
#define TOP_BAR_BACKGROUND_COLOR    [TYDemoTheme theme].status_bg_color
#define TAB_BAR_TEXT_COLOR          [TYDemoTheme theme].navbar_font_color
#define TAB_BAR_BACKGROUND_COLOR    [TYDemoTheme theme].navbar_bg_color


//背景颜色
#define MAIN_BACKGROUND_COLOR       [TYDemoTheme theme].app_bg_color

//列表相关
#define LIST_MAIN_TEXT_COLOR        [TYDemoTheme theme].list_primary_color
#define LIST_SUB_TEXT_COLOR         [TYDemoTheme theme].list_sub_color
#define LIST_LIGHT_TEXT_COLOR       [TYDemoTheme theme].list_secondary_color
#define LIST_LINE_COLOR             [TYDemoTheme theme].list_line_color
#define LIST_BACKGROUND_COLOR       [TYDemoTheme theme].list_bg_color

//提示
#define NOTICE_TEXT_COLOR           [TYDemoTheme theme].notice_font_color
#define NOTICE_BACKGROUND_COLOR     [TYDemoTheme theme].notice_bg_color

//按钮
#define BUTTON_TEXT_COLOR           [TYDemoTheme theme].primary_button_font_color
#define BUTTON_BACKGROUND_COLOR     [TYDemoTheme theme].primary_button_bg_color
#define SUB_BUTTON_TEXT_COLOR       [TYDemoTheme theme].secondary_button_font_color
#define SUB_BUTTON_BACKGROUND_COLOR [TYDemoTheme theme].secondary_button_bg_color
#define DISABLE_BUTTON_BACKGROUND_COLOR [TYDemoTheme theme].disable_button_bg_color

//old
#define MAIN_COLOR                  BUTTON_BACKGROUND_COLOR
#define MAIN_FONT_COLOR             LIST_MAIN_TEXT_COLOR
#define SUB_FONT_COLOR              LIST_SUB_TEXT_COLOR
#define LIGHT_FONT_COLOR            LIST_LIGHT_TEXT_COLOR
#define SEPARATOR_LINE_COLOR        LIST_LINE_COLOR

//----------------------------------------//

#import <Foundation/Foundation.h>

@interface TYDemoTheme : NSObject

@property (class, nonatomic, readonly) TYDemoTheme *theme;

// topBar
@property (nonatomic, strong) UIColor *status_font_color;
@property (nonatomic, strong) UIColor *status_bg_color;

// tabBar
@property (nonatomic, strong) UIColor *navbar_font_color;
@property (nonatomic, strong) UIColor *navbar_bg_color;

// background
@property (nonatomic, strong) UIColor *app_bg_color;

// list
@property (nonatomic, strong) UIColor *list_primary_color;
@property (nonatomic, strong) UIColor *list_sub_color;
@property (nonatomic, strong) UIColor *list_secondary_color;
@property (nonatomic, strong) UIColor *list_line_color;
@property (nonatomic, strong) UIColor *list_bg_color;

// notice
@property (nonatomic, strong) UIColor *notice_font_color;
@property (nonatomic, strong) UIColor *notice_bg_color;

// button(深色背景，浅色文字)
@property (nonatomic, strong) UIColor *primary_button_font_color;
@property (nonatomic, strong) UIColor *primary_button_bg_color;

// button2(浅色背景，深色文字)
@property (nonatomic, strong) UIColor *secondary_button_font_color;
@property (nonatomic, strong) UIColor *secondary_button_bg_color;

// button disable bg color
@property (nonatomic, strong) UIColor *disable_button_bg_color;

// 渐变颜色
@property (nonatomic, strong) UIColor *home_index_bg_start_color;
@property (nonatomic, strong) UIColor *home_index_bg_end_color;



- (UIStatusBarStyle)preferredStatusBarStyle;

@end

@interface TYDemoTheme (Appearance)

+ (void)reloadAppearance;

@end
