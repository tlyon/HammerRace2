//
//  MainViewController.m
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
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
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    if(acceleration.x - lastXVal >= .7 || acceleration.x - lastXVal <= -.7){
        NSLog(@"Strum event: lastX:%g, X:%g", lastXVal, acceleration.x);
        //determine if swing or loading
        if (acceleration.x < 0 && lastXVal > 0 ) {
            //percentComplete += -pow(acceleration.x + .5, 3);
            percentComplete += 10;
            NSLog(@"Hit value = %f", percentComplete);
        }
        
    }
    
    //wait(&waitTime);
    lastXVal = acceleration.x;
    
    if(acceleration.y<0 && acceleration.x>-1){
        NSLog(@"degree = %i",(int)((-1-acceleration.x) * 90));
        [self rotateImage:background degrees:(int)((-1-acceleration.x) * 90)];
        [self changeBackground:percentComplete];
    }
    else {
        [self rotateImage:background degrees:0];
    }
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    last_degrees = -90;
    lastXVal = 0;
    [self changeBackground:55.0];
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
    if(percentComplete<25){
        if(degrees>-15)modifiedDegrees=-15;
    }else if (percentComplete<50){
        if(degrees>-10)modifiedDegrees=-10;
    }else if (percentComplete<75){
        if(degrees>-1)modifiedDegrees=-5;
    }else if (percentComplete<100){
        if(degrees>-1)modifiedDegrees=-2;
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
    NSLog(@"%g",percentDone);
    if(percentDone<25){
        background.image = [UIImage imageNamed:@"landscape0.png"];
    }else if (percentDone<50){
        background.image = [UIImage imageNamed:@"landscape25.png"];
    }else if (percentDone<75){
        background.image = [UIImage imageNamed:@"landscape50.png"];
    }else if (percentDone<100){
        background.image = [UIImage imageNamed:@"landscape75.png"];
    }else{
        background.image = [UIImage imageNamed:@"landscape100.png"];
    }
}



@end
