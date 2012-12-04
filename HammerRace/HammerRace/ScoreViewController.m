//
//  ScoreViewController.m
//  HammerRace
//
//  Created by Scott Schroeder on 12/4/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController

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
    [self updateLeaderboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateLeaderboard{
    storage = [NSUserDefaults standardUserDefaults];
    [storage synchronize];
    if([storage doubleForKey:@"score1"]==100){
       sscore1.text = @"__._";
    }else{
      sscore1.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score1"]];  
    }
    if([storage doubleForKey:@"score2"]==100){
        sscore2.text = @"__._";
    }else{
        sscore2.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score2"]];
    }
    if([storage doubleForKey:@"score3"]==100){
        sscore3.text = @"__._";
    }else{
        sscore3.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score3"]];
    }
    if([storage doubleForKey:@"score4"]==100){
        sscore4.text = @"__._";
    }else{
        sscore4.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score4"]];
    }
    if([storage doubleForKey:@"score5"]==100){
        sscore5.text = @"__._";
    }else{
        sscore5.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score5"]];
    }
    if([storage doubleForKey:@"score6"]==100){
        sscore6.text = @"__._";
    }else{
        sscore6.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score6"]];
    }
    if([storage doubleForKey:@"score7"]==100){
        sscore7.text = @"__._";
    }else{
        sscore7.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score7"]];
    }
    if([storage doubleForKey:@"score8"]==100){
        sscore8.text = @"__._";
    }else{
        sscore8.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score8"]];
    }
    if([storage doubleForKey:@"score9"]==100){
        sscore9.text = @"__._";
    }else{
        sscore9.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score9"]];
    }
    if([storage doubleForKey:@"score10"]==100){
        sscore10.text = @"__._";
    }else{
        sscore10.text = [NSString stringWithFormat:@"%g", [storage doubleForKey:@"score10"]];
    }

}


-(void)updateLeaderboardStorage:(double)score forPerson:(NSString*)person{
    NSLog(@"Updating leaderboard with score %g",score);
    
    storage = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%d",[storage doubleForKey:@"score1"]<0.0001);
    if([storage doubleForKey:@"score1"]<0.0001)[storage setDouble:100.0 forKey:@"score1"];
    if([storage doubleForKey:@"score2"]<0.0001)[storage setDouble:100.0 forKey:@"score2"];
    if([storage doubleForKey:@"score3"]<0.0001)[storage setDouble:100.0 forKey:@"score3"];
    if([storage doubleForKey:@"score4"]<0.0001)[storage setDouble:100.0 forKey:@"score4"];
    if([storage doubleForKey:@"score5"]<0.0001)[storage setDouble:100.0 forKey:@"score5"];
    if([storage doubleForKey:@"score6"]<0.0001)[storage setDouble:100.0 forKey:@"score6"];
    if([storage doubleForKey:@"score7"]<0.0001)[storage setDouble:100.0 forKey:@"score7"];
    if([storage doubleForKey:@"score8"]<0.0001)[storage setDouble:100.0 forKey:@"score8"];
    if([storage doubleForKey:@"score9"]<0.0001)[storage setDouble:100.0 forKey:@"score9"];
    if([storage doubleForKey:@"score10"]<0.0001)[storage setDouble:100.0 forKey:@"score10"];

    
    if((score < [storage doubleForKey:@"score1"])){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:[storage doubleForKey:@"score4"] forKey:@"score5"];
        [storage setDouble:[storage doubleForKey:@"score3"] forKey:@"score4"];
        [storage setDouble:[storage doubleForKey:@"score2"] forKey:@"score3"];
        [storage setDouble:[storage doubleForKey:@"score1"] forKey:@"score2"];
        [storage setDouble:score forKey:@"score1"];
    }
    else if(score < [storage doubleForKey:@"score2"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:[storage doubleForKey:@"score4"] forKey:@"score5"];
        [storage setDouble:[storage doubleForKey:@"score3"] forKey:@"score4"];
        [storage setDouble:[storage doubleForKey:@"score2"] forKey:@"score3"];
        [storage setDouble:score forKey:@"score2"];}
    else if(score < [storage doubleForKey:@"score3"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:[storage doubleForKey:@"score4"] forKey:@"score5"];
        [storage setDouble:[storage doubleForKey:@"score3"] forKey:@"score4"];
        [storage setDouble:score forKey:@"score3"];}
    else if(score < [storage doubleForKey:@"score4"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:[storage doubleForKey:@"score4"] forKey:@"score5"];
        [storage setDouble:score forKey:@"score4"];}
    else if(score < [storage doubleForKey:@"score5"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:score forKey:@"score5"];}
    else if(score < [storage doubleForKey:@"score6"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:score forKey:@"score6"];}
    else if(score < [storage doubleForKey:@"score7"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:score forKey:@"score7"];}
    else if(score < [storage doubleForKey:@"score8"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:score forKey:@"score8"];}
    else if(score < [storage doubleForKey:@"score9"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:score forKey:@"score9"];
}
    else if(score < [storage doubleForKey:@"score10"]){
        [storage setDouble:score forKey:@"score10"];}

    [storage synchronize];
}

-(IBAction) clearLeaderboard{
storage = [NSUserDefaults standardUserDefaults];
    [storage setDouble:100.0 forKey:@"score1"];
    [storage setDouble:100.0 forKey:@"score2"];
    [storage setDouble:100.0 forKey:@"score3"];
    [storage setDouble:100.0 forKey:@"score4"];
    [storage setDouble:100.0 forKey:@"score5"];
    [storage setDouble:100.0 forKey:@"score6"];
    [storage setDouble:100.0 forKey:@"score7"];
    [storage setDouble:100.0 forKey:@"score8"];
    [storage setDouble:100.0 forKey:@"score9"];
    [storage setDouble:100.0 forKey:@"score10"];
    [storage synchronize];
    [self updateLeaderboard];
}

- (IBAction) dismissModalVC {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

@end
