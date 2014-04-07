//
//  Article.h
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic,assign) int aId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSURL *link;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,strong) UIImage *image;

@end
