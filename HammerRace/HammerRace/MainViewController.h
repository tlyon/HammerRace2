//
//  MainViewController.h
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate, UIAccelerometerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
