//
//  ScoreViewController.h
//  HammerRace
//
//  Created by Scott Schroeder on 12/4/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController{
    IBOutlet UILabel *sscore1;
    IBOutlet UILabel *sscore2;
    IBOutlet UILabel *sscore3;
    IBOutlet UILabel *sscore4;
    IBOutlet UILabel *sscore5;
    IBOutlet UILabel *sscore6;
    IBOutlet UILabel *sscore7;
    IBOutlet UILabel *sscore8;
    IBOutlet UILabel *sscore9;
    IBOutlet UILabel *sscore10;
    IBOutlet UILabel *sinit1;
    IBOutlet UILabel *sinit2;
    IBOutlet UILabel *sinit3;
    IBOutlet UILabel *sinit4;
    IBOutlet UILabel *sinit5;
    IBOutlet UILabel *sinit6;
    IBOutlet UILabel *sinit7;
    IBOutlet UILabel *sinit8;
    IBOutlet UILabel *sinit9;
    IBOutlet UILabel *sinit10;
    
    NSUserDefaults *storage;
}

-(void)updateLeaderboardStorage:(double)score forPerson:(NSString*)person;
-(void)updateLeaderboard;
-(IBAction)clearLeaderboard;
- (IBAction) dismissModalVC;

@end
