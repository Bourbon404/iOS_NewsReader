//
//  ArticleManager.m
//  iOS_新闻阅读
//
//  Created by bourbon on 14-2-10.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#import "ArticleManager.h"
#import "Article.h"
#import "ArticleDatabase.h"

static ArticleManager *staticArticleManager;

@implementation ArticleManager
+(ArticleManager *)defaultManager
{
    if (staticArticleManager == nil)
    {
        staticArticleManager = [[ArticleManager alloc] init];
    }
    return staticArticleManager;
}

-(NSMutableArray *)allArticles
{
    if (allAritcle == nil)
    {
        allAritcle = [[ArticleDatabase sharedDatabase] allArticles];
    }
    return allAritcle;
}
-(NSMutableArray *)selectArticleByArticleId:(int)articleId
{
    NSMutableArray *array = [[ArticleDatabase sharedDatabase] selectArticleByArticleId:articleId];
    return array;
}

-(int)addArticle:(Article *)aArticle error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    int rc = [[ArticleDatabase sharedDatabase] addArticle:aArticle error:&underlyingError];
    if(rc)
    {
        if(error!=NULL)
        {
            NSArray *objArray = [NSArray arrayWithObjects:@"新建文章失败",underlyingError, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,NSUnderlyingErrorKey, nil];
            NSDictionary *eDit = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [[NSError alloc] initWithDomain:BUSINESS_ERROR_DOMAIN code:rc userInfo:eDit];
        }
        return rc;
    }
    if(allAritcle == nil)
    {
        allAritcle = [[NSMutableArray alloc] init];
    }
    [allAritcle addObject:aArticle];
    return rc;

}

-(int)deleteAllArticleserror:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    int rc = [[ArticleDatabase sharedDatabase] deleteAllArticleserror:&underlyingError];
    if(rc)
    {
        if(error!=NULL)
        {
            NSArray *objArray = [NSArray arrayWithObjects:@"删除频道失败",underlyingError, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,NSUnderlyingErrorKey, nil];
            NSDictionary *eDit = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [[NSError alloc] initWithDomain:BUSINESS_ERROR_DOMAIN code:rc userInfo:eDit];
        }
        return rc;
    }
    [allAritcle removeAllObjects];
    return rc;
}
@end
