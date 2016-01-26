//
//  LogInViewController.m
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *passwordOutlet;
@property UITextField *userNameTF;
@property UITextField *passWordTF;
- (IBAction)LoginButton:(id)sender;
- (IBAction)SignupButton:(id)sender;
- (IBAction)BigButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *signupButtonOutlet;
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize screen
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"newgif" ofType:@"gif"];
    NSData *loginGif = [NSData dataWithContentsOfFile:filePath];
    UIWebView *loginWebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 127, 375, 400)];
    [loginWebview loadData:loginGif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    loginWebview.userInteractionEnabled = NO;
    [self.view addSubview:loginWebview];
    
    //specify place holders
    UIColor *grayColor = [UIColor colorWithRed:170/255.0f green:164/255.0f blue:169/255.0f alpha:1.0f];
    [self.userNameOutlet.layer setBackgroundColor: [grayColor CGColor]];
    self.userNameOutlet.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{
                                                                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                                                    NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:20]
                                                                                                                    }
                                                 ];
    [self.passwordOutlet.layer setBackgroundColor: [ grayColor CGColor]];
    self.passwordOutlet.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{
                                                                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                                                    NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:20]
                                                                                                                    }
                                                 ];
    [self.userNameOutlet.layer setMasksToBounds:YES];
    
    //configure buttons
    UIColor * color = [UIColor colorWithRed:255/255.0f green:215/255.0f blue:20/255.0f alpha:1.0f];
    self.loginButtonOutlet.backgroundColor= [UIColor whiteColor];
    [self.loginButtonOutlet setTitle:@"LOGIN" forState:UIControlStateNormal];
    [self.loginButtonOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.loginButtonOutlet.titleLabel.font =[ UIFont fontWithName:@"HelveticaNeue-UltraLight " size:16];
    self.signupButtonOutlet.backgroundColor= color;
    [self.signupButtonOutlet setTitle:@"SIGNUP" forState:UIControlStateNormal];
    [self.signupButtonOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.signupButtonOutlet.titleLabel.font =[ UIFont fontWithName:@"HelveticaNeue-UltraLight " size:16];
    
    //configure center label
    UILabel* loginPageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, self.view.frame.size.width, 30)];
    loginPageLabel.text = @"The world LISTENS you";
    loginPageLabel.textColor = [UIColor whiteColor];
    loginPageLabel.font =[ UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    loginPageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginPageLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


- (IBAction)LoginButton:(id)sender {
    //Log in button that uses parse framework to handle user log in
    [PFUser logInWithUsernameInBackground:self.userNameOutlet.text password:self.passwordOutlet.text block:^(PFUser *user, NSError *error) {
        if (user) {
            // Do stuff after successful login.
            [self performSegueWithIdentifier:@"LoginToMain" sender:self];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Something is wrong! Did you register?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)SignupButton:(id)sender {
    //see if username and password is empty
    if ([self.userNameOutlet.text isEqualToString:@""] || [self.passwordOutlet.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please enter both your username and password before registration!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        PFUser *user = [PFUser user];
        user.username = self.userNameOutlet.text;
        user.password = self.passwordOutlet.text;
        //parse call, inputs user info into parse table
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {   //
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hooray!" message:@"Your account has been setup!" delegate:self cancelButtonTitle:@"Let's go!" otherButtonTitles:nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:[error userInfo][@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            }
        }];
    }
}

//button that handles resign first responder
- (IBAction)BigButton:(id)sender {
    NSLog(@"Big button clicked");
    [self.userNameOutlet resignFirstResponder];
    [self.passwordOutlet resignFirstResponder];
}
@end
