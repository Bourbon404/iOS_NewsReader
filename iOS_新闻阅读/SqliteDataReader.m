//
//  SqliteDataReader.m
//  Ablums_MVC
//
//  Created by Bourbon on 13-9-3.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "SqliteDataReader.h"


@implementation SqliteDataReader

- (id)initWithStatement:(sqlite3_stmt *)aStatement{
    self=[super init];
    if (self) {
        statement=aStatement;
    }
    return self;
}

- (BOOL)read{
    return sqlite3_step(statement)==SQLITE_ROW;
}

- (int)integerValueForColumnIndex:(NSUInteger)columnIndex{
    int value=sqlite3_column_int(statement, columnIndex);
    return value;
}

- (double)doubleValueForColumnIndex:(NSUInteger)columnIndex{
    double value=sqlite3_column_double(statement, columnIndex);
    return value;
}

- (NSString *)stringValueForColumnIndex:(NSUInteger)columnIndex{
    const unsigned char *value=sqlite3_column_text(statement, columnIndex);
    return [NSString stringWithCString:(const char *)value encoding:NSUTF8StringEncoding];
}

-(NSData *)dataValueForColumnIndex:(NSUInteger)columnIndex
{
//    int length = sqlite3_column_bytes(statement, columnIndex);
//    NSData *data = [NSData dataWithBytes:sqlite3_column_blob(statement, columnIndex) length:length];
    const void *value = sqlite3_column_blob(statement, columnIndex);
    int length = sqlite3_column_bytes(statement, columnIndex);
    NSData *data = [NSData dataWithBytes:value length:length];
    return data;
}

- (void)close{
    sqlite3_finalize(statement);
}

@end

