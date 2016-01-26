//
//  DetailViewController.m
//  FinalProject
//
//  Created by Ryan Lu on 5/19/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "DetailViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface DetailViewController ()

- (IBAction)UpvoteButton:(id)sender;
- (IBAction)DownvoteButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
- (IBAction)PlayButotn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) AVAudioPlayer *player;
- (IBAction)PostCommentButton:(id)sender;

@property PFObject* currentParseObject;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setPFObject:(PFObject *)ParseObject {
    self.currentParseObject = ParseObject;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)UpvoteButton:(id)sender {
    
}
- (IBAction)DownvoteButton:(id)sender {
}
- (IBAction)PlayButotn:(id)sender {
    
    PFFile *audioFile = [self.currentParseObject objectForKey:@"audioFile"];
    [audioFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
        if(!error){
            NSLog(@"NSDATA: %@" , result);
            self.player = [[AVAudioPlayer alloc] initWithData:result error:nil];
            self.player.volume = 5;
            [self.player play];
            //            self.sharedModel.playerArray = self.playerArray;
        }
        else
        {
            NSLog(@"ERROR!");
        }
    }];
}
- (IBAction)PostCommentButton:(id)sender {
}
@end
