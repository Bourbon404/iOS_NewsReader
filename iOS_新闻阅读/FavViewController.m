//
//  FavViewController.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-12.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "FavViewController.h"

@interface FavViewController ()

@end

@implementation FavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    Label.text = @"string";
    [self.view addSubview:Label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
