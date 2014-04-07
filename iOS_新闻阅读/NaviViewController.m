//
//  NaviViewController.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-12.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "NaviViewController.h"
#import "FavViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#import "ArticleManager.h"
#import "GetData.h"
@interface NaviViewController ()

@end

@implementation NaviViewController

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self)
    {
        rootViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"menu" style:(UIBarButtonItemStyleBordered) target:self action:@selector(showMenu)];
        rootViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(refreshData)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//获取信息
-(void)getRemoteData
{
    GetData *data = [[GetData alloc] init];
    [data inputUrl];
}

//刷新信息
-(void)refreshData
{
    [[ArticleManager defaultManager] deleteAllArticleserror:nil];
    [self getRemoteData];
}

//展示菜单
-(void)showMenu
{
    if (!_sideMenu) {
        RESideMenuItem *item1 = [[RESideMenuItem alloc] initWithTitle:@"首页" action:^(RESideMenu *menu, RESideMenuItem *item) {
            MenuViewController *mmm = [[MenuViewController alloc] init];
            mmm.title = @"首页";
            NaviViewController *navi = [[NaviViewController alloc] initWithRootViewController:mmm];
            [menu setRootViewController:navi];
            [self getRemoteData];
            
        }];
        RESideMenuItem *item2 = [[RESideMenuItem alloc] initWithTitle:@"栏目 +" action:^(RESideMenu *menu, RESideMenuItem *item) {
            
        }];
        RESideMenuItem *story = [[RESideMenuItem alloc] initWithTitle:@"深夜食堂" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"深夜食堂");
        }];
        RESideMenuItem *iSay = [[RESideMenuItem alloc] initWithTitle:@"瞎扯" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"瞎扯");
        }];
        RESideMenuItem *sky = [[RESideMenuItem alloc] initWithTitle:@"知天下" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"知天下");
        }];
        RESideMenuItem *tele = [[RESideMenuItem alloc] initWithTitle:@"映科技" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"映科技");
        }];
        item2.subItems = @[story,iSay,sky,tele];
        
        
        RESideMenuItem *item3 = [[RESideMenuItem alloc] initWithTitle:@"我的收藏" action:^(RESideMenu *menu, RESideMenuItem *item) {
            
            FavViewController *fav = [[FavViewController alloc] init];
            fav.title = @"我的收藏";
            NaviViewController *navi = [[NaviViewController alloc] initWithRootViewController:fav];
            [menu setRootViewController:navi];
            
            NSLog(@"Item %@", item);
        }];
        
        
        RESideMenuItem *item4 = [[RESideMenuItem alloc] initWithTitle:@"设置 +" action:^(RESideMenu *menu, RESideMenuItem *item) {
            
            NSLog(@"Item %@", item);
        }];
        RESideMenuItem *downLoadNow = [[RESideMenuItem alloc] initWithTitle:@"立即缓存" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"设置颜色");
        }];
        RESideMenuItem *nightMode = [[RESideMenuItem alloc] initWithTitle:@"夜间模式" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"夜间模式");
        }];
        RESideMenuItem *pushNews = [[RESideMenuItem alloc] initWithTitle:@"消息推送" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"消息推送");
        }];
        RESideMenuItem *noPic = [[RESideMenuItem alloc] initWithTitle:@"无图模式" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"无图模式");
        }];
        item4.subItems = @[downLoadNow,nightMode,pushNews,noPic];
        
        
        RESideMenuItem *item5 = [[RESideMenuItem alloc] initWithTitle:@"多语言环境 +" action:^(RESideMenu *menu, RESideMenuItem *item) {
            NSLog(@"设置多语言");
        }];
        RESideMenuItem *Chinese = [[RESideMenuItem alloc] initWithTitle:@"简体中文" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"设置简体中文");
        }];
        RESideMenuItem *English = [[RESideMenuItem alloc] initWithTitle:@"English" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            NSLog(@"设置为English");
        }];
        item5.subItems = @[Chinese,English];
        
        
        
        _sideMenu = [[RESideMenu alloc] initWithItems:@[item1,item2,item3,item4,item5]];
        _sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
        _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    }
    
    [_sideMenu show];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
