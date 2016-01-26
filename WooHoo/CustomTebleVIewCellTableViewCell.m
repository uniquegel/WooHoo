//
//  CustomTebleVIewCellTableViewCell.m
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "CustomTebleVIewCellTableViewCell.h"
#import "DataModel.h"
#import <Parse/Parse.h>
#import <AVFoundation/AVFoundation.h>
@interface CustomTebleVIewCellTableViewCell ()

@property DataModel *sharedModel;
@property NSMutableArray *playerArray;

@end
@implementation CustomTebleVIewCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.sharedModel = [DataModel sharedModel];
    self.playerArray = self.sharedModel.getPlayerArray;
}


//Init cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)UpvoteButton:(id)sender {
    NSLog(@"Upvote but clicked!");
    self.voteCount++;
    NSString *str = [NSString stringWithFormat:@"%ld", (long)self.voteCount];
    self.voteLabelOutlet.text = str;
    
    // Create a pointer to an object of class Point with id
    NSLog(@"Object id: %@", self.projectIDOutlet.text);
    PFObject *point = [PFObject objectWithoutDataWithClassName:@"AudioFiles" objectId:self.projectIDOutlet.text];
    
    // Set a new value on quantity
    [point setObject:str forKey:@"vote"];
    
    // Save
    [point save];
}

- (IBAction)DownvoteButton:(id)sender {
        NSLog(@"downvote but clicked!");
    self.voteCount --;
    NSString *str = [NSString stringWithFormat:@"%li", (long)self.voteCount];
    self.voteLabelOutlet.text = str;
    
    // Create a pointer to an object of class Point with id
    PFObject *point = [PFObject objectWithoutDataWithClassName:@"AudioFiles" objectId:self.projectIDOutlet.text];
    
    // Set a new value on quantity
    [point setObject:str forKey:@"vote"];
    
    // Save
    [point save];
}
@end
