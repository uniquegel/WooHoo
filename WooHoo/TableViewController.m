//
//  TableViewController.m
//  FinalProject
//
//  Created by Ryan Lu on 5/4/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "TableViewController.h"
#import <Parse/Parse.h>
#import "CustomTebleVIewCellTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "DataModel.h"
#import "DetailViewController.h"

@interface TableViewController ()

@property NSArray *allObjects;
@property NSInteger rows;
@property DataModel *sharedModel;
- (IBAction)RefreshButton:(id)sender;
@property (strong, nonatomic) AVAudioPlayer *player;
@property PFObject *currentSelectedObject;

@end

@implementation TableViewController

- (void)viewDidLoad {
    //initialize the singleton data model
    self.sharedModel = [DataModel sharedModel];
    self.allObjects = [NSMutableArray array];
    [super viewDidLoad];
    [self queryMethod];
}

//query method for parse
-(void) queryMethod{
    //query method that queries from parse and gets the files back
    PFQuery *query = [PFQuery queryWithClassName:@"AudioFiles"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
        _allObjects = [[NSArray alloc] initWithArray:
                       objectsNormal];
        NSLog(@"allObjects count: %lu" , (unsigned long)[_allObjects count]);
        [_audioTable reloadData];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //when select a row at index, we get the object at that index and instantiate a audioplayer for that file
    PFObject *object = [_allObjects objectAtIndex:indexPath.row];
    self.currentSelectedObject = object;
    PFFile *audioFile = [object objectForKey:@"audioFile"];
    [audioFile getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
        if(!error){
            NSLog(@"NSDATA: %@" , result);
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
    //declare cells
    static NSString *allObjectTableCellIdentifier = @"AllObjectsCell";
    CustomTebleVIewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:allObjectTableCellIdentifier forIndexPath:indexPath];
    cell.upvoteOutlet.tag = indexPath.row;
    cell.downvoteOutlet.tag = indexPath.row;
    cell.voteLabelOutlet.tag = indexPath.row;
    
    // Configure the cell...
    PFObject *object = [_allObjects objectAtIndex:indexPath.row];
    cell.TitleOutlet.text = [object objectForKey:@"title"];
    cell.FileDurationOutlet.text = @"0";
    cell.FileDurationOutlet.text = [object objectForKey:@"duration"];
    cell.voteLabelOutlet.text = [object objectForKey:@"vote"];
    cell.voteCount = [[object objectForKey:@"vote"] integerValue];
    cell.projectIDOutlet.text = object.objectId;
    cell.projectIDOutlet.hidden = YES;
    
    return cell;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


//prepare for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        
        // Get destination view
        DetailViewController *vc = [segue destinationViewController];
        
        // Get button tag number (or do whatever you need to do here, based on your object
        NSInteger tagIndex = [(UIButton *)sender tag];
        
        // Pass the information to your destination view
        [vc setPFObject:self.currentSelectedObject];
    }
}

//refresh button that refreshes the table
- (IBAction)RefreshButton:(id)sender {
    //button that refreshes the table and retrive new data
    [self queryMethod];
    [self.tableView reloadData];
}
@end
