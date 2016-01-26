//
//  CustomTebleVIewCellTableViewCell.h
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTebleVIewCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleOutlet;
@property (weak, nonatomic) IBOutlet UILabel *DurationOutlet;
@property (weak, nonatomic) IBOutlet UILabel *FileDurationOutlet;
@property (weak, nonatomic) IBOutlet UIButton *upvoteOutlet;
@property (weak, nonatomic) IBOutlet UIButton *downvoteOutlet;
@property (weak, nonatomic) IBOutlet UILabel *voteLabelOutlet;
- (IBAction)UpvoteButton:(id)sender;
- (IBAction)DownvoteButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *projectIDOutlet;
@property NSInteger voteCount;

@end
