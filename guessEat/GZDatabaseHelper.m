//
//  GZDatabaseHelper.m
//  guessEat
//
//  Created by Guiwei LIN on 8/23/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZDatabaseHelper.h"
#import "GZDish.h"

@implementation GZDatabaseHelper


+ (GZDatabaseHelper *)sharedInstance
{
    static GZDatabaseHelper *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
}

- (id)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //combine the path of external database and document directory
    myDatabasePath=[[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"ios_eat"]];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ios_eat" ofType:@""];
    
    NSLog(@"current path is %@" , path);
    
    NSError *error = nil;
    
    //copy external database to document directory
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:myDatabasePath error:&error];
    
    //judge the database is it existed
    NSFileManager *filmanager = [NSFileManager defaultManager];
    if ([filmanager fileExistsAtPath:myDatabasePath] == NO) {
        NSLog(@"the database not exist");
    }
    else{
        NSLog(@"file is exist");
    }


    return self;
}


- (NSArray *)queryFromDataBase
{
    const char *dbpath = [myDatabasePath UTF8String];
    sqlite3_stmt *statement;
    NSMutableArray *dish_array=[[NSMutableArray alloc]initWithCapacity:5];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,description from Dishes"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                GZDish *dish  = [[GZDish alloc]init];
                
                NSString *dishesID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
               // NSLog(@"id is: %@", dishesID);
                
                dish.dish_id = dishesID;
                
                NSString *dishesName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1    )];
               // NSLog(@"name is: %@", dishesName);
                
                dish.dish_name = dishesName;

                
                NSString *dish_description = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2    )];
                //NSLog(@"description is: %@", dish_description);
                
                dish.dish_description = dish_description;

                [dish_array addObject:dish];
                
            }

            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    return dish_array;
}

- (NSString *)searchDataBase:(int)dishID
{
    const char *dbpath = [myDatabasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *searchResult=[[NSString alloc]init];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT name from contacts id=\"%d\"",dishID];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *result= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSLog(@"search result: %@", searchResult);
                searchResult=result;
            }
            else {
                NSLog(@"search failed");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    return searchResult;
}




@end
