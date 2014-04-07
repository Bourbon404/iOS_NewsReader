//
//  MenuViewController.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "MenuViewController.h"
#import "GetData.h"
#import "Article.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "ArticleManager.h"
#import "FavViewController.h"
#import "GetData.h"
#import "NaviViewController.h"
#import "MenuCell.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData:) name:@"data" object:nil];
    [self getRemoteData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"data" object:nil];
}

//获取信息
-(void)getRemoteData
{
    GetData *data = [[GetData alloc] init];
    [data inputUrl];
}
-(void)getData:(NSNotification *)notify
{
    _menus = [[NSMutableArray alloc] initWithArray:notify.object];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_menus count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[MenuCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    Article *article = [_menus objectAtIndex:indexPath.row];
    cell.headTitle.text = article.title;
    
//    cell.textLabel.text = article.title;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = [_menus objectAtIndex:indexPath.row];
    Article *lastArticle = indexPath.row == 0 ? nil : [_menus objectAtIndex:indexPath.row - 1];
    Article *nextArticle = indexPath.row == [_menus count] - 1 ? nil : [_menus objectAtIndex:indexPath.row + 1];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.lastLink = lastArticle == nil ? nil : lastArticle.link;
    detail.nextLink = nextArticle == nil ? nil : nextArticle.link;
    detail.link = article.link;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
