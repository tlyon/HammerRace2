//
//  MainViewController.m
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BluetoothAndScoring.h"
#import "ScoreViewController.h"
// This is defined in Math.h
#define M_PI   3.14159265358979323846264338327950288   /* pi */
#define HITS_NEEDED 50

// Our conversion definition
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize lastXVal;
@synthesize percentComplete;
int waitTime = 5;
int GameLength=100;
AVAudioPlayer *newPlayer;
NSString *path;
NSURL *fileURL;
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    if(running){
    if(acceleration.x - lastXVal >= .7 || acceleration.x - lastXVal <= -.7){
        // NSLog(@"Strum event: lastX:%g, X:%g", lastXVal, acceleration.x);
        //determine if swing or loading
        if (acceleration.x < 0 && lastXVal > 0 ) {
            percentComplete += pow(acceleration.x + .5, 4);
            //percentComplete += 10;
            
            percent.text = [NSString stringWithFormat:@"%d %%",(int)(percentComplete)];
            // NSLog(@"Hit value = %f", percentComplete);
        }
        
    }
    
    //determine if completed
    if (percentComplete > GameLength) {
        [self endGame];
    }
    
    //wait(&waitTime);
    lastXVal = acceleration.x;
    
    if(acceleration.y<0 && acceleration.x>-1){
        //NSLog(@"degree = %i",(int)((-1-acceleration.x) * 90));
        [self rotateImage:background degrees:(int)((-1-acceleration.x) * 90)];
        if(percentComplete>lastpercent){
            [self changeBackground:percentComplete];
            lastpercent+=25;
        }
        
    }
    else if(acceleration.y>0 && acceleration.x>0){
        [self rotateImage:background degrees:180];
    }
    else {
        [self rotateImage:background degrees:0];
    }
    }
    
}

-(void)resetComplete{
    percentComplete = 0;
    timecount=0.0;
    percent.text = [NSString stringWithFormat:@"%d %%",(int)(percentComplete)];
    Counter.text = [NSString stringWithFormat:@"%g",timecount];
    lastpercent=0;
    winnerDisplay.text = @"";
    BluetoothAndScoring *blue = [BluetoothAndScoring getInstance];
    [blue reset];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    running=false;
    last_degrees = -90;
    lastpercent=25;
    lastXVal = 0;
    timecount=0.0;
    
    [self changeBackground:0.0];

   // NSLog(@"in didload");
    
    scoreboard = [[ScoreViewController alloc] init];   
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL) animated
{
    [UIAccelerometer sharedAccelerometer].delegate = self; // tell the singleton instance of UIAccelerometer
}

- (void)viewWillDisappear:(BOOL) animated
{
    [UIAccelerometer sharedAccelerometer].delegate = nil;
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (void)rotateImage:(UIImageView *)image degrees:(CGFloat)degrees
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGFloat modifiedDegrees = degrees;
    if(percentComplete<GameLength/4){
        if(degrees>-15 && degrees<90)modifiedDegrees=-15;
    }else if (percentComplete<GameLength/2){
        if(degrees>-10 && degrees<90)modifiedDegrees=-10;
    }else if (percentComplete<GameLength*3/4){
        if(degrees>-1 && degrees<90)modifiedDegrees=-5;
    }else if (percentComplete<GameLength){
        if(degrees>-1 && degrees<90)modifiedDegrees=-2;
    }else{
        
    }
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(modifiedDegrees));
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
    
}
- (void)changeBackground:(float)percentDone{
   // NSLog(@"changing background percent = %g",percentDone);
    if(percentDone<GameLength/4){
        background.image = [self getImage:@"landscape0.png"];
    }else if (percentDone<GameLength/2){
        background.image = [self getImage:@"landscape25.png"];
    }else if (percentDone<GameLength*3/4){
        background.image = [self getImage:@"landscape50.png"];
    }else if (percentDone<GameLength){
        background.image = [self getImage:@"landscape75.png"];
    }else{
        background.image = [self getImage:@"landscape100.png"];
    }
}

-(UIImage*)getImage:(NSString*)fileName{
    @autoreleasepool {
        NSString *thumbnailFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], fileName];
        UIImage *image  = [UIImage imageWithContentsOfFile:thumbnailFile];
        return image;
    }
    
}

-(void)onTick:(NSTimer *)timer {
    timecount+=0.1;
    Counter.text = [NSString stringWithFormat:@"%g",(timecount)];
    if ((int)timecount>1) {
        scoreDisplay.text = @"";
    }
}

-(void)onCountdownTick:(NSTimer *)timer {
    countdown-=1;
    scoreDisplay.text = [NSString stringWithFormat:@"%i",(countdown)];
    path = [[NSBundle mainBundle] pathForResource:@"pang" ofType:@"wav"];
    fileURL = [NSURL fileURLWithPath: path];
    newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [newPlayer play];
    
    if(countdown==0){
        countdownTimer.invalidate;
        countdownTimer=nil;
        scoreDisplay.text = @"GO!";
//        path = [[NSBundle mainBundle] pathForResource:@"go-go-go" ofType:@"wav"];
//        fileURL = [NSURL fileURLWithPath: path];
//        newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//        [newPlayer play];
        [self startTimer];
        running=true;
    }
}

-(void)startGame{
    [startButton setHidden:TRUE];
    countdown=6;
    [self resetComplete];
    
    
    NSLog(@"Starting!");
    //[self startCountdown];
    
    BluetoothAndScoring* blue = [BluetoothAndScoring getInstance];
    if([blue isConnected]){
        [blue start:@selector(startCountdown) :self];
        scoreDisplay.text =@"Waiting for partner...";
    }
    else{
        [self startCountdown];
    }

    
}

-(void)endGame{
    running=false;
    Timer.invalidate;
    Timer=nil;
    percent.text=@"100 %";
    BluetoothAndScoring* blue = [BluetoothAndScoring getInstance];
    [self changeBackground:percentComplete];
    ScoreViewController* scoreboard = [[ScoreViewController alloc] init]; //First, we create an instance of SomeScript
    
    if([blue isConnected]){
        [blue end:timecount :@selector(updateText) :self];
        scoreDisplay.text = [NSString stringWithFormat:@"%g",(timecount)];
        //set audio file to be played
//        path = [[NSBundle mainBundle] pathForResource:@"applause5" ofType:@"wav"];
//        fileURL = [NSURL fileURLWithPath: path];
//        newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//         [newPlayer play];
         //plays a sound here for winner and loser?

        
        
    }
    else{
        scoreDisplay.text = [NSString stringWithFormat:@"%g",(timecount)];
         //plays a sound here
//        path = [[NSBundle mainBundle] pathForResource:@"cheer8k" ofType:@"wav"];
//        fileURL = [NSURL fileURLWithPath: path];
//        newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//        [newPlayer play];
        
        
    }
    [scoreboard updateLeaderboardStorage:timecount forPerson:@"bbb"];
    
    [startButton setTitle:@"Restart" forState:UIControlStateNormal];
    [startButton setHidden:FALSE];
    
}

-(void)startTimer{
    Timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(onTick:)
                                   userInfo:nil
                                    repeats:YES];
    
}


-(void)updateText{
    BluetoothAndScoring* blue = [BluetoothAndScoring getInstance];
    winnerDisplay.text = [blue endText];
}


- (IBAction)startCountdown
{
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(onCountdownTick:)
                                                    userInfo:nil
                                                     repeats:YES];
    
}


@end
