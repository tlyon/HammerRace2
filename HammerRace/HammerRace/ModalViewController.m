//
//  ModalViewController.m
//  Maze
//
//  Created by Scott Schroeder on 9/18/12.
//  Copyright (c) 2012 Scott Schroeder. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController


- (IBAction) dismissModalVC {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
