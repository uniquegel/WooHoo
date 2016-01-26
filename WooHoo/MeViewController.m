//
//  MeViewController.m
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "MeViewController.h"
#import <Parse/Parse.h>

@interface MeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameOutlet;
@property (weak, nonatomic) IBOutlet UILabel *passwordOutlet;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *user = [PFUser currentUser];
    self.usernameOutlet.text = user.username;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
