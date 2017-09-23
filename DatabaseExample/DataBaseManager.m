//
//  DataBaseManager.m
//  DatabaseExample
//
//  Created by Karthi A on 29/04/17.
//  Copyright © 2017 Karthi A. All rights reserved.
//

#import "DataBaseManager.h"
static DataBaseManager *sharedInstance = nil;

static sqlite3 *database = nil;

static sqlite3_stmt *statement = nil;

@implementation DataBaseManager

+(DataBaseManager*)getInstance{
    
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}
-(BOOL)createDB{
    
    NSString *docsDir;
    
    NSArray *dirPaths;
    
    // Get the documents directory path
    
    dirPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    
    /** test
    */
    
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"StaffManagement.db"]];
    
    BOOL isSuccess = YES;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
        
    {
        
        const char *dbpath = [databasePath UTF8String];
        
        //Open the database connection
        
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
            
        {
            
            char *errMsg;
            
            const char *sql_stmt =
            
            "create table if not exists EMPLOYEE (firstname text NOT NULL, lastname text NOT NULL);";
            
            //Execute the query
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                
                != SQLITE_OK)
                
            {
                
                isSuccess = NO;
                
            }
            
            sqlite3_close(database);
            
            return isSuccess;
            
        }
        
        else {
            
            isSuccess = NO;
            
        }
        
    }
    
    return isSuccess;
    
}

-(BOOL) saveEmployee:(NSString*)firstName
        employeeName:(NSString*)lastName
{
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EMPLOYEE (firstname, lastname) values (\'%@\',\'%@\')", firstName , lastName];
        const char *insert_stmt = [insertSQL UTF8String];
        if (sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL)!= SQLITE_OK)
        {
        sqlite3_close(database);
        return NO;
        }
    else        {
        
        //Add a statement parameter to a query.
        
        if (sqlite3_step(statement) == SQLITE_DONE)
            
        {
            sqlite3_reset(statement);
            sqlite3_close(database);
            return YES;            }
        
        else
            
        {
            sqlite3_reset(statement);
            sqlite3_close(database);
            return NO;
        }
        
    }
    }    return NO;}

-(NSArray *)getUserDetail
{
     const char *dbpath = [databasePath UTF8String];
     NSMutableArray *userData = [[NSMutableArray alloc]init];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
         NSString *selectSQL = [NSString stringWithFormat: @"select firstname,lastname from EMPLOYEE "];
        const char *query_stmt = [selectSQL UTF8String];
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL)== SQLITE_OK) {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                do {
                    NSMutableDictionary *userDetailDict = [[NSMutableDictionary alloc]init];
                     int column1 = sqlite3_column_type(statement, 0);
                    if (column1 == SQLITE3_TEXT) {
                        const unsigned char *col = sqlite3_column_text(statement, 0);
                 NSString*       value = [NSString stringWithFormat:@"%s", col];
                        [userDetailDict setObject:value forKey:@"firstname"];
                    }
                      int column2 = sqlite3_column_type(statement, 1);
                    if (column2 == SQLITE3_TEXT) {
                        const unsigned char *col = sqlite3_column_text(statement, 1);
                   NSString* value = [NSString stringWithFormat:@"%s", col];
                        [userDetailDict setObject:value forKey:@"lastname"];
                    }
                    [userData addObject:userDetailDict];
                    
                } while (sqlite3_step(statement) == SQLITE_ROW);
            }
            
        }
    }
    return userData;
}

@end
