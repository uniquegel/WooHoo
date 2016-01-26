//
//  DetailViewController.h
//  FinalProject
//
//  Created by Ryan Lu on 5/19/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController
- (IBAction)UpvoteButton:(id)sender;
- (void) setPFObject:(PFObject*) ParseObject;
@end
