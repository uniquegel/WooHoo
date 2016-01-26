//
//  DataModel.h
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
-(NSMutableArray*) getPlayerArray;
@property (strong, nonatomic) NSMutableArray *playerArray;
+ (DataModel *) sharedModel;
@end
