//
//  MenuCell.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-13.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize headImgView,headTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImgView = [[UIImageView alloc] init];
        [headImgView setBackgroundColor:[UIColor clearColor]];
        [self addSubview: headImgView];
        
        
         headTitle = [[UILabel alloc] init];
        [ headTitle setBackgroundColor:[UIColor clearColor]];
        [ headTitle setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview: headTitle];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [ headImgView setFrame:CGRectMake(5, 5, 40, 40)];
    [ headTitle setFrame:CGRectMake(5, 50, 320-50, 50)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
