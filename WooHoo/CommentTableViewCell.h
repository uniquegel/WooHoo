//
//  CommentTableViewCell.h
//  FinalProject
//
//  Created by Ryan Lu on 6/1/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
- (IBAction)UpvoteCommentButton:(id)sender;
- (IBAction)DownvoteCommentButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *voteCommentLabel;
- (IBAction)playCommentButton:(id)sender;
@end
