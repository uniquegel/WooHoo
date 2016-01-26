//
//  RecorderViewController.m
//  FinalProject
//
//  Created by Ryan Lu on 5/5/15.
//  Copyright (c) 2015 Ryan Lu. All rights reserved.
//

#import "RecorderViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>


@interface RecorderViewController ()
@property AVAudioRecorder* recorder;
- (IBAction)BigButton:(id)sender;

@property AVAudioPlayer* player;
@property BOOL isNotRecording;
- (IBAction)RecordButtonTouched:(id)sender;
- (IBAction)RecordButtonCancelled:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)drag:(id)sender;
- (IBAction)RecorderButtonTouchedUp:(id)sender;
- (IBAction)PlayButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PlayButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *RecordButtonOutlet;
@property NSInteger i;
@property (weak, nonatomic) IBOutlet UIButton *PostButtonOutlet;

@property NSTimer *Timer;
@property (weak, nonatomic) IBOutlet UILabel *durationDisplayOutlet;

@property (weak, nonatomic) IBOutlet UIProgressView *ProgressBar;
@property     NSString *filePath;
@property NSString *fileDuratoin;
- (IBAction)PostButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titleOutlet;
@property (strong, nonatomic) NSString *tempString;
- (void) stopRecording;
@end

@implementation RecorderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //initialization
    self.PlayButtonOutlet.enabled=NO;
    self.PostButtonOutlet.enabled=NO;
    
    //    self.StopButtonOutlet.enabled = NO;
    self.isNotRecording = YES;
    self.ProgressBar.progress=0;
    
    //find the path for file
    self.filePath = [NSString stringWithFormat:@"%@/audio.m4a",[[NSBundle mainBundle] resourcePath]];
    NSURL *fileURL = [NSURL fileURLWithPath:self.filePath];
    
    //recorder setup
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                              [NSNumber numberWithFloat:16000.0], AVSampleRateKey,
                              [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                              nil];
    
    //recorder initialization
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    [session setActive:YES error:nil];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:settings error:nil];
    [self.recorder setDelegate:self];
    self.recorder.meteringEnabled = YES;
    self.recorder.prepareToRecord;
    
    NSLog(@"file path: %@",fileURL.absoluteString);
    
    // Do any additional setup after loading the view.
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


//timer used to keep track of the duration of voices
- (void) TimerCount{
    //timer increment
    self.i++;
    if (self.i==10) {
        self.stopRecording;
    }
    [self.durationDisplayOutlet setText:[@(self.i) stringValue]];
    self.ProgressBar.progress =(float)(self.i)/10.0f;
}

//stop recording method
- (void) stopRecording {
    [self.recorder stop];
    self.Timer.invalidate;
    self.isNotRecording = YES;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
    
    //check if theres file
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:self.filePath] == NO)
    {
        //if found files
        NSLog (@"FOUND file");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No file!" message:@"Yo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];}
    else{
        NSLog (@"File not found");
    }
    
    //reset button image
    UIImage *btnImage = [UIImage imageNamed:@"Mic1.png"];
    [self.RecordButtonOutlet setImage:btnImage forState:UIControlStateNormal];
    NSLog(@"Record STOPED");

    //reset buttons
    self.PlayButtonOutlet.enabled = YES;
    self.PostButtonOutlet.enabled = YES;
    
    //configure playback
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recorder.url error:nil];
    NSInteger ints = self.player.duration;
    self.tempString = [NSString stringWithFormat:@"%ld", (long)ints];
}

//touched the record button
- (IBAction)RecordButtonTouched:(id)sender {
    self.PlayButtonOutlet.enabled = NO;
    self.ProgressBar.progress = 0;
    if(self.isNotRecording)
    {
        self.isNotRecording = NO;
        [self.recorder record];
        
        //reset timer
        self.i = 0;
        [self.durationDisplayOutlet setText:@"0"];
        self.Timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerCount) userInfo:nil repeats:YES];
        
        //change image
        UIImage *btnImage = [UIImage imageNamed:@"Mic2.png"];
        [self.RecordButtonOutlet setImage:btnImage forState:UIControlStateNormal];
        //        [self.RecordButtonOutlet setTitle: @"Release to Stop" forState:UIControlStateNormal];
        NSLog(@"Record started!");
    }
}


- (IBAction)RecorderButtonTouchedUp:(id)sender {
    self.stopRecording;
    
}

- (IBAction)PlayButton:(id)sender {
    self.player.volume =5;
    [self.player play];
}


- (void) RestartTimer:(id)sender {
    self.i=0;
}

//post button clicked
- (IBAction)PostButton:(id)sender {
    //declare parse object
    PFObject *audioFiles = [PFObject objectWithClassName:@"AudioFiles"];
    
    //convert audio to NSData format
    NSString *s = [self.recorder.url absoluteString];
    NSData *audioData = [NSData dataWithContentsOfFile:self.filePath];
    
    //create audiofile as a property
    //create audiofile for current user
    //update different columns in parse
    PFUser *user = [PFUser currentUser];
    PFFile *audioFile = [PFFile fileWithName:@"Audio.m4a" data:audioData];
    audioFiles[@"audioFile"] = audioFile;
    audioFiles[@"postedBy"] =[user username];
    //check if title is empty
    if ([self.titleOutlet.text isEqualToString:@""]) {
        audioFiles[@"title"] = @"(empty)";
    }else{
        
        audioFiles[@"title"] = self.titleOutlet.text;
    }
    audioFiles[@"vote"] = @"0";
    NSLog(@"tempString: %@", self.tempString);
    audioFiles[@"duration"] =self.tempString;
    
    //finally save the file to parse
    [audioFiles saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if(succeeded){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Good job!" message:@"Your voice has been posted!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            // optional - add more buttons:
            //            [alert addButtonWithTitle:@"Yes"];
            [alert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
        }
    }];
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)BigButton:(id)sender {
    [self.titleOutlet resignFirstResponder];
}
@end
















