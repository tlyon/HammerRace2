//
//  FlipsideViewController.h
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController{
    IBOutlet UISwitch *leftHandSwitch;
    IBOutlet UILabel *bluetoothConnected;
}

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
-(IBAction)onOffSwitch:(id)sender;
-(IBAction)connect:(id)sender;

@end
