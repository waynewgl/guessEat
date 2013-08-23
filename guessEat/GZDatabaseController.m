//
//  GZDatabaseController.m
//  guessEat
//
//  Created by Stephen Zheng on 22/08/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import "GZDatabaseController.h"

@interface GZDatabaseController ()

@end

@implementation GZDatabaseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//search existed database in document 
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    docsDir = [dirPaths objectAtIndex:0];
    
    //combine the path of external database and document directory 
    myDatabasePath=[[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"ios_eat"]];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ios_eat" ofType:@""];
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
    
}

- (NSArray *)queryFromDataBase
{
    const char *dbpath = [myDatabasePath UTF8String];
    sqlite3_stmt *statement;
    NSArray *array=[[NSArray alloc]init];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,description from Dishes"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *dishesID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSLog(@"id is: %@", dishesID);
                
                NSString *dishesName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1    )];
                NSLog(@"name is: %@", dishesName);
                
                NSString *dishDescription = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2    )];
                NSLog(@"description is: %@", dishDescription);
                array= [NSArray arrayWithObjects:dishesID,dishesName,dishDescription,nil];
            }
            else {
                NSLog(@"query failed");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    return array;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
