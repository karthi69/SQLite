//
//  ViewController.m
//  DatabaseExample
//
//  Created by Karthi A on 29/04/17.
//  Copyright © 2017 Karthi A. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteManupulateViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)storageTypeSQLiteSelected:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    self.navigationController.title = @"Data Storage";
    SQLiteManupulateViewController *myController = [storyboard instantiateViewControllerWithIdentifier:@"SQLiteVC"];
    [self.navigationController pushViewController:myController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
