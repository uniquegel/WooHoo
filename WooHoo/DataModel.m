//
//  DataModel.m
//  FinalProject
//
//  Created by Ryan Lu on 5/7/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "DataModel.h"


@interface DataModel ()

@property (strong, nonatomic) NSMutableArray *quotes;


@property NSUInteger currentIndex;

//@property NSString *filePath;

@end


@implementation DataModel

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
//        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        
//        NSString *documentsDirectory = [path objectAtIndex:0];
//        
//        self.filePath = [documentsDirectory stringByAppendingPathComponent:@"Property.plist"];
//        
//        
//        self.currentIndex = 0;
//        
//        
//        NSDictionary *quote1 = @{
//                                 @"quote": @"Work hard for what you want because it won't come to you without a fight. You have to be strong and courageous and know that you can do anything you put your mind to. If somebody puts you down or criticizes you, just keep on believing in yourself and turn it into something positive.",
//                                 @"author": @"- Leah LaBelle",
//                                 @"favorite": @"no",
//                                 //                                 @"number":@"1"
//                                 
//                                 };
//        
//        
//        
//        
//        //        NSDictionary *quote2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Find a place inside where there's joy, and the joy will burn out the pain.", @"quote", @"- Joseph Capbell", @"author", @NO,@"favorite",@2 , @"number",nil ];
//        NSDictionary *quote2 = @{
//                                 @"quote": @"Keep your face to the sunshine and you cannot see a shadow.",
//                                 @"author": @"- Helen Keller",
//                                 @"favorite": @"no",
//                                 //                                 @"number":@"2"
//                                 };
//        NSDictionary *quote3 = @{
//                                 @"quote": @"Yesterday is not ours to recover, but tomorrow is ours to win or lose.",
//                                 @"author": @"- Lyndon B. Johnson",
//                                 @"favorite": @"no",
//                                 //                                 @"number":@"3"
//                                 };
//        
//        
//        
//        //        NSDictionary *plist=[[NSDictionary alloc] initWithContentsOfFile:self.filePath];
//        NSArray *pList = [[NSArray alloc] initWithContentsOfFile:self.filePath] ;
//        if (!pList) {
//            self.quotes = [NSMutableArray arrayWithObjects:quote1, quote2, quote3, nil];
//            [self.quotes writeToFile:self.filePath atomically:YES];
//        }
//        else{
//            NSLog(@"ARRAY = %@", pList);
//            self.quotes = pList.mutableCopy;
//        }
//        
        
        
        //        NSLog(@"%lu",  (unsigned long)self.quotes.count);
        
        
    }
    return self;
}


+ (DataModel *) sharedModel {
    static DataModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedModel = [[self alloc]init];
        NSLog(@"%@", @"New sharedModel created!!!");
    });
    
    return _sharedModel;
}

//- (NSDictionary *) randomQuote
//{
//    //    int r = rand() % (self.quotes.count);
//    //    NSLog(@"%lu", (unsigned long)self.quotes.count);
//    //    NSLog(@"%d", r);
//    NSDictionary *randomQuote;
//    int r;
//    if (self.numberOfQuotes>1){
//        do
//        {
//            r = rand() % (self.quotes.count);
//            randomQuote = [self.quotes objectAtIndex:r];
//        } while (r==self.currentIndex);
//        
//        self.currentIndex = [self.quotes indexOfObject:randomQuote];
//    }
//    else if(self.numberOfQuotes == 0){
//        randomQuote = @{
//                        @"quote": @"There is no quote! Add some to the library!",
//                        @"author": @""
//                        };
//    }
//    else {
//        randomQuote = [self.quotes objectAtIndex:0];
//    }
//    return randomQuote;
//}

- (NSMutableArray *) getPlayerArray
{
    return self.playerArray;
}

//- (NSUInteger) numberOfQuotes
//{
//    NSUInteger num  = self.quotes.count;
//    return num;
//}
//- (NSDictionary *) quoteAtIndex: (NSUInteger) index
//{
//    NSDictionary *quote = [self.quotes objectAtIndex:index];
//    return quote;
//}
//
//- (void) removeQuoteAtIndex: (NSUInteger) index
//{
//    [self.quotes removeObjectAtIndex:index];
//    [self.quotes writeToFile:self.filePath atomically:YES];
//    
//}
//
//- (void) insertQuote: (NSString *) quote
//                    :(NSString *) author
//                    : (NSUInteger) index
//{
//    NSDictionary *newQuote = @{
//                               @"quote": quote,
//                               @"author": author
//                               };
//    [self.quotes insertObject:newQuote atIndex:index];
//    [self.quotes writeToFile:self.filePath atomically:YES];
//}
//
//- (void) insertQuote: (NSDictionary *) quote
//             atIndex: (NSUInteger) index
//{
//    [self.quotes insertObject:quote atIndex:index];
//    [self.quotes writeToFile:self.filePath atomically:YES];
//}
//
//- (NSDictionary *) nextQuote
//{
//    if (self.currentIndex != (self.quotes.count-1)) {
//        self.currentIndex++;
//    }
//    else {
//        self.currentIndex = 0;
//    }
//    return [self.quotes objectAtIndex:self.currentIndex];
//}
//
//- (NSDictionary *) prevQuote
//{
//    if (self.currentIndex!= 0) {
//        self.currentIndex--;
//    }
//    else {
//        self.currentIndex = self.quotes.count-1;
//    }
//    
//    return [self.quotes objectAtIndex:self.currentIndex];
//}
//


@end

