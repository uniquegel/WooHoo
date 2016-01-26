//
//  MyVoiceTableViewController.h
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "TableViewController.h"

@interface MyVoiceTableViewController : TableViewController


@property (strong, nonatomic) IBOutlet UITableView *audioTable;
@property NSMutableArray *playerArray;

@end
