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

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
   // NSLog(@"Acceleration Event (x:%g, y:%g, z:%g)", acceleration.x, acceleration.y, acceleration.z);
    NSLog(@"degree = %i", (int)((-1 - acceleration.x) * 90));
    [self rotateImage:background degrees:((-1 - acceleration.x) * 90)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];

}

- (IBAction)hit:(id)sender{
       [self rotateImage:background degrees:-10];
}


- (IBAction)pullBack:(id)sender{
    [self rotateImage:background degrees:-90];
}

@end
