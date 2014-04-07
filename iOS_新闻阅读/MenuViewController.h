//
//  MenuViewController.h
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface MenuViewController : UITableViewController
{
    NSMutableArray *_menus;
}

@property (nonatomic,strong) RESideMenu *sideMenu;

@end
