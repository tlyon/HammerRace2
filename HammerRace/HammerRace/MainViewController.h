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
    int percentComplete;
    int last_degrees;
    
}

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
- (IBAction)pullBack:(id)sender;
- (IBAction)hit:(id)sender;

@end
