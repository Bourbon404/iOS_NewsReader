//
//  ArticleDatabase.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "ArticleDatabase.h"
#import "SqliteDatabase.h"

static ArticleDatabase *staticArticleDatabase;

@implementation ArticleDatabase

+(void)createDatabaseIfNotExists
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[ArticleDatabase filename]])
    {
        return;
    }
    NSMutableString *init_sqls = [NSMutableString stringWithCapacity:1024];
    
    [init_sqls appendFormat:@"create table Articles(AID integer primary key autoincrement,title text,link text);"];
    
    SqliteDatabase *db = [[SqliteDatabase alloc] initWithFilename:[ArticleDatabase filename]];
    [db executeNonQuery:init_sqls error:nil];
}

+(NSString *)filename
{
    NSString *str = [[NSString alloc] initWithFormat:@"%@/Documents/article.sqlite",NSHomeDirectory()];
    return str;
}

+(ArticleDatabase *)sharedDatabase
{
    if (staticArticleDatabase == nil)
    {
        staticArticleDatabase = [[ArticleDatabase alloc] init];
    }
    return staticArticleDatabase;
}
-(id)init
{
    self = [super init];
    if (self)
    {
        sqliteDatabase = [[SqliteDatabase alloc] initWithFilename:[ArticleDatabase filename]];
    }
    return self;
}
@end
