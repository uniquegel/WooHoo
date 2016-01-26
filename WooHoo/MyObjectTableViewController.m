//
//  MyVoiceTableViewController.m
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//
//

#import "MyObjectTableViewController.h"
#import <Parse/Parse.h>
#import "CustomTebleVIewCellTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "DataModel.h"

@interface MyObjectTableViewController ()

@property NSArray *allObjects;
@property (strong, nonatomic) NSMutableArray *myObjects;
@property NSInteger rows;
@property DataModel *sharedModel;
@property (strong, nonatomic) AVAudioPlayer *player;
- (IBAction)RefreshButton:(id)sender;

@end
// PLEASE NOTE: comments are skipped in this file since it is very similar to TableViewController.m, please find comments in that file
@implementation MyObjectTableViewController

- (void)viewDidLoad {
    //singleton data model set up
    self.sharedModel = [DataModel sharedModel];
    self.allObjects = [NSMutableArray array];
    self.myObjects = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"AudioFiles"];
    [super viewDidLoad];
    NSMutableArray *playerArray;
    [self queryMethod];
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

//query method that queries from parse and gets the files
-(void) queryMethod{
    PFQuery *query = [PFQuery queryWithClassName:@"AudioFiles"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
        _allObjects = [[NSArray alloc] initWithArray:
                       objectsNormal];
        _rows = [_allObjects count];
        PFUser *user = [PFUser currentUser];
        for ( int i =0; i<self.allObjects.count ; i++) {
            if ([[[self.allObjects objectAtIndex:i] objectForKey:@"postedBy"] isEqualToString:user.username]) {
                [self.myObjects addObject:[self.allObjects objectAtIndex:i]];
            }
        }
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.myObjects.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //get and set up parse project, then initialize player
    PFObject *object = [self.myObjects objectAtIndex:indexPath.row];
    PFFile *audioFile = [object objectForKey:@"audioFile"];
    [audioFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
        if(!error){
            self.player = [[AVAudioPlayer alloc] initWithData:result error:nil];
            self.player.volume = 5;
            [self.player play];
        }
        else
        {
            NSLog(@"ERROR!");
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //declare cell
    static NSString *myObjectTableCellIdentifier = @"MyObjectsCell";
    CustomTebleVIewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myObjectTableCellIdentifier forIndexPath:indexPath];
    cell.upvoteOutlet.tag = indexPath.row;
    cell.downvoteOutlet.tag = indexPath.row;
    cell.voteLabelOutlet.tag = indexPath.row;
    
    // Configure the cell...
    PFObject *object = [self.myObjects objectAtIndex:indexPath.row];
    cell.TitleOutlet.text = [object objectForKey:@"title"];
    cell.FileDurationOutlet.text = @"0";
    cell.FileDurationOutlet.text = [object objectForKey:@"duration"];
    cell.voteLabelOutlet.text = [object objectForKey:@"vote"];
    cell.voteCount = [[object objectForKey:@"vote"] integerValue];
    cell.projectIDOutlet.text = object.objectId;
    cell.projectIDOutlet.hidden = YES;
    
    return cell;
}


//- (void)clicked:(UIButton*)sender {
//    PFObject *object = [_allObjects objectAtIndex:sender.tag];
//    PFFile *audioFile = [object objectForKey:@"audioFile"];
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//refresh button to refresh the table
- (IBAction)RefreshButton:(id)sender {
    NSLog(@"Refresh button clicked");
    [self.myObjects removeAllObjects];
    [self queryMethod];
    [self.tableView reloadData];
}
@end