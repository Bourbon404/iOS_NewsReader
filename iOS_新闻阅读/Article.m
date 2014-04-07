//
//  Article.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "Article.h"

@implementation Article
-(NSString *)description
{
    return [NSString stringWithFormat:@"subTitlt:%@ ",self.subTitle];
//    return [NSString stringWithFormat:@"aID:%d title;%@ subTitle:%@ link;%@ ",self.aId,self.title,self.subTitle,self.link];
}
@end
