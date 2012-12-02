//
//  MainViewController.h
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate, UIAccelerometerDelegate>{
    IBOutlet UIImageView *background;
    int last_degrees;
    IBOutlet UILabel *percent;
    int lastpercent;
    IBOutlet UILabel *Counter;
    double timecount;
    
}

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property float lastXVal;
@property float percentComplete;
- (IBAction)pullBack:(id)sender;
- (IBAction)hit:(id)sender;
-(void)resetComplete;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
-(void)onTick:(NSTimer *)timer;
@end
