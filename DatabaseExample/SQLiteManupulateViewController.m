//
//  SQLiteManupulateViewController.m
//  DatabaseExample
//
//  Created by Karthi A on 29/04/17.
//  Copyright © 2017 Karthi A. All rights reserved.
//

#import "SQLiteManupulateViewController.h"
#import "DataBaseManager.h"
#import "UserTableViewController.h"
@interface SQLiteManupulateViewController ()

@end

@implementation SQLiteManupulateViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)AddDataInDatabase:(id)sender {
    _AddDataButton.titleLabel.numberOfLines = 1;
    _AddDataButton.lineBreakMode=NSLineBreakByTruncatingTail;
    DataBaseManager *databaseManager = [DataBaseManager getInstance];
    NSLog(@"%@ --- %@",self.UserIdField.text,self.UserNameTextView.text);
    if (!([self.UserIdField.text isEqualToString:@""]&& [self.UserNameTextView.text isEqualToString:@""])) {
         [databaseManager saveEmployee:self.UserIdField.text employeeName:self.UserNameTextView.text];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Full Data" message:@"some data is missing" preferredStyle:UIAlertControllerStyleAlert];
        [alert showViewController:self sender:alert];
    }
   
}
- (IBAction)searchButtonClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    self.navigationController.title = @"Data Details";
    UserTableViewController *myController = [storyboard instantiateViewControllerWithIdentifier:@"UserTableViewController"];
    [self.navigationController pushViewController:myController animated:YES];
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
