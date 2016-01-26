//
//  MyVoiceTableViewController.m
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "MyVoiceTableViewController.h"
#import <Parse/Parse.h>
#import "CustomTebleVIewCellTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "DataModel.h"

@interface MyVoiceTableViewController ()
@property NSArray *allObjects;
@property NSInteger rows;
@property DataModel *sharedModel;
- (IBAction)RefreshButton:(id)sender;
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation MyVoiceTableViewController

- (void)viewDidLoad {
    self.sharedModel = [DataModel sharedModel];
    self.allObjects = [NSMutableArray array];
    //    NSUInteger limit = 0;
    //    NSUInteger skip = 0;
    PFQuery *query = [PFQuery queryWithClassName:@"AudioFiles"];
    //    [query setLimit: limit];
    //    [query setSkip: skip];
    //    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    //        if (!error) {
    //            // The find succeeded. Add the returned objects to allObjects
    //            //            NSLog(@"hahhah");
    //            NSLog(@"Objects: %@" , objects);
    //            [self.allObjects addObjectsFromArray:objects];
    //
    //        } else {
    //            // Log details of the failure
    //            NSLog(@"Error: %@ %@", error, [error userInfo]);
    //        }
    //    }];
    
    [super viewDidLoad];
    NSMutableArray *playerArray;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //    NSLog(@"ARRAY: %@", allObjects);
    
    //        // Do something with the returned PFObject in the gameScore variable.
    //        NSLog(@"%@", testObject);
    //        PFFile *audioFile = [testObject objectForKey:@"audioFile"];
    //        [audioFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
    //            if(!error){
    //                self.player = [[AVAudioPlayer alloc] initWithData:result error:nil];
    //                [self.player setDelegate:self];
    //                [self.player play];
    //            } else{
    //                NSLog(@"ERROR!");
    //            }
    //        }];
    //    }];
    //
    
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
-(void) queryMethod{
    PFQuery *query = [PFQuery queryWithClassName:@"AudioFiles"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
        _allObjects = [[NSArray alloc] initWithArray:
                       objectsNormal];
        
        _rows = [_allObjects count];
//        [_audioTable reloadData];
        
        
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
    return self.allObjects.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *object = [_allObjects objectAtIndex:indexPath.row];
    //    cell.TitleOutlet.text = [object objectForKey:@"Title"];
    //    [cell.Button setTitle:@"HEY!" forState:UIControlStateNormal];
    PFFile *audioFile = [object objectForKey:@"audioFile"];
    [audioFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
        if(!error){
            NSLog(@"NSDATA: %@" , result);
            //            if(indexPath.row == 1){
            self.player = [[AVAudioPlayer alloc] initWithData:result error:nil];
            
            //            [player setDelegate:self];
            self.player.volume = 5;
            [self.player play];
            //            }
            
            
            //            [self.playerArray addObject:player];
            self.sharedModel.playerArray = self.playerArray;
        }
        else
        {
            NSLog(@"ERROR!");
        }
        
        //                [self.player setDelegate:self];
        //                [self.player play];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *allObjectTableCellIdentifier = @"MyObjectsCell";
    
    CustomTebleVIewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:allObjectTableCellIdentifier forIndexPath:indexPath];
    
    
    
    
    // Configure the cell...
    PFObject *object = [_allObjects objectAtIndex:indexPath.row];
    
    NSLog(@"title: %@", [object objectForKey:@"title"]);
    cell.TitleOutlet.text = [object objectForKey:@"title"];
    cell.FileDurationOutlet.text = @"0";
    cell.FileDurationOutlet.text = [object objectForKey:@"duration"];
//    cell.VoteOutlet.text = [object objectForKey:@"vote"];
    
    PFFile *audioFile = [object objectForKey:@"audioFile"];
    
    //    [audioFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
    //        if(!error){
    //            NSLog(@"NSDATA: %@" , result );
    //            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:result error:nil];
    //
    //            [player setDelegate:self];
    //           [player play];
    //
    //
    //
    //            [self.playerArray addObject:player];
    //            self.sharedModel.playerArray = self.playerArray;
    //        }
    //        else
    //        {
    //            NSLog(@"ERROR!");
    //        }
    //
    //        //                [self.player setDelegate:self];
    //        //                [self.player play];
    //    }];
    
    
    
    //        [cell.StopButotn setTitle:@"HEY!" forState:UIControlStateNormal];
    //    cell.playButtonOutlet.tag = indexPath.row;
    //   [cell.playButtonOutlet addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}


- (void)clicked:(UIButton*)sender {
    PFObject *object = [_allObjects objectAtIndex:sender.tag];
    PFFile *audioFile = [object objectForKey:@"audioFile"];
    
}

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

- (IBAction)RefreshButton:(id)sender {
    [self queryMethod];
    [self.tableView reloadData];
}
@end