//
//  DataBaseManager.h
//  DatabaseExample
//
//  Created by Karthi A on 29/04/17.
//  Copyright © 2017 Karthi A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBaseManager : NSObject
{
    NSString *databasePath;
}
+(DataBaseManager*)getInstance;
-(BOOL)createDB;
-(BOOL) saveEmployee:(NSString*)employeeID
        employeeName:(NSString*)employeeName;
-(NSArray *)getUserDetail;
@end
