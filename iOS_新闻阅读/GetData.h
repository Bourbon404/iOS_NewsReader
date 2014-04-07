//
//  GetData.h
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"
@interface GetData : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *_menus;
    NSMutableString *_currentElement;
    Article *_currentArticle;
}
-(void)inputUrl;

@end
