//
//  DetailViewController.h
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    UIWebView *_webView;
}
@property (nonatomic,strong) NSURL *lastLink;
@property (nonatomic,strong) NSURL *link;
@property (nonatomic,strong) NSURL *nextLink;
@end
