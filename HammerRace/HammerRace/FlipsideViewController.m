//
//  FlipsideViewController.m
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "FlipsideViewController.h"
#import "BluetoothAndScoring.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // load leftHandSwitch state from plist
    BluetoothAndScoring* blue = [BluetoothAndScoring getInstance];
    if ([blue isConnected]) {
        bluetoothConnected.text = @"Connected";
        bluetoothConnected.textColor = [UIColor greenColor];
    }
    else{
        bluetoothConnected.text = @"Not Connected";
        bluetoothConnected.textColor = [UIColor grayColor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onOffSwitch:(id)sender{
    //write leftHandSwitch to plist
}

-(IBAction)connect:(id)sender{
    BluetoothAndScoring* bluetooth = [BluetoothAndScoring getInstance];
    [bluetooth connectToPeer];
    if ([bluetooth isConnected]) {
        bluetoothConnected.text = @"Connected";
        bluetoothConnected.textColor = [UIColor greenColor];
    }
    else{
        bluetoothConnected.text = @"Not Connected";
        bluetoothConnected.textColor = [UIColor grayColor];
    }
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
