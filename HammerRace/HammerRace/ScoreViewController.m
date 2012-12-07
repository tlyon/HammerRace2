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
	// Update leaderboard 
    [self updateLeaderboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*Updates the leaderboard view, done when the view is loaded*/
-(void)updateLeaderboard{
    //storage - plist storage of leaderboard
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
    sinit1.text = [storage stringForKey:@"init1"];
    sinit2.text = [storage stringForKey:@"init2"];
    sinit3.text = [storage stringForKey:@"init3"];
    sinit4.text = [storage stringForKey:@"init4"];
    sinit5.text = [storage stringForKey:@"init5"];
    sinit6.text = [storage stringForKey:@"init6"];
    sinit7.text = [storage stringForKey:@"init7"];
    sinit8.text = [storage stringForKey:@"init8"];
    sinit9.text = [storage stringForKey:@"init9"];
    sinit10.text = [storage stringForKey:@"init10"];

}

/*Update the storage of the leaderboard.*/
-(void)updateLeaderboardStorage:(double)score forPerson:(NSString*)person{
    NSLog(@"Updating leaderboard with score %g",score);
    
    storage = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[storage stringForKey:@"init1"]);
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
    
    if([storage stringForKey:@"init1"]==NULL)[storage setValue:@"___" forKey:@"init1"];
    if([storage stringForKey:@"init2"]==NULL)[storage setValue:@"___" forKey:@"init2"];
    if([storage stringForKey:@"init3"]==NULL)[storage setValue:@"___" forKey:@"init3"];
    if([storage stringForKey:@"init4"]==NULL)[storage setValue:@"___" forKey:@"init4"];
    if([storage stringForKey:@"init5"]==NULL)[storage setValue:@"___" forKey:@"init5"];
    if([storage stringForKey:@"init6"]==NULL)[storage setValue:@"___" forKey:@"init6"];
    if([storage stringForKey:@"init7"]==NULL)[storage setValue:@"___" forKey:@"init7"];
    if([storage stringForKey:@"init8"]==NULL)[storage setValue:@"___" forKey:@"init8"];
    if([storage stringForKey:@"init9"]==NULL)[storage setValue:@"___" forKey:@"init9"];
    if([storage stringForKey:@"init10"]==NULL)[storage setValue:@"___" forKey:@"init10"];

    
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
        
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:[storage stringForKey:@"init7"] forKey:@"init8"];
        [storage setValue:[storage stringForKey:@"init6"] forKey:@"init7"];
        [storage setValue:[storage stringForKey:@"init5"] forKey:@"init6"];
        [storage setValue:[storage stringForKey:@"init4"] forKey:@"init5"];
        [storage setValue:[storage stringForKey:@"init3"] forKey:@"init4"];
        [storage setValue:[storage stringForKey:@"init2"] forKey:@"init3"];
        [storage setValue:[storage stringForKey:@"init1"] forKey:@"init2"];
        [storage setValue:person forKey:@"init1"];
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
        [storage setDouble:score forKey:@"score2"];
    
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:[storage stringForKey:@"init7"] forKey:@"init8"];
        [storage setValue:[storage stringForKey:@"init6"] forKey:@"init7"];
        [storage setValue:[storage stringForKey:@"init5"] forKey:@"init6"];
        [storage setValue:[storage stringForKey:@"init4"] forKey:@"init5"];
        [storage setValue:[storage stringForKey:@"init3"] forKey:@"init4"];
        [storage setValue:[storage stringForKey:@"init2"] forKey:@"init3"];
        [storage setValue:person forKey:@"init2"];}
    else if(score < [storage doubleForKey:@"score3"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:[storage doubleForKey:@"score4"] forKey:@"score5"];
        [storage setDouble:[storage doubleForKey:@"score3"] forKey:@"score4"];
        [storage setDouble:score forKey:@"score3"];
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:[storage stringForKey:@"init7"] forKey:@"init8"];
        [storage setValue:[storage stringForKey:@"init6"] forKey:@"init7"];
        [storage setValue:[storage stringForKey:@"init5"] forKey:@"init6"];
        [storage setValue:[storage stringForKey:@"init4"] forKey:@"init5"];
        [storage setValue:[storage stringForKey:@"init3"] forKey:@"init4"];
        [storage setValue:person forKey:@"init3"];}
    else if(score < [storage doubleForKey:@"score4"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:[storage doubleForKey:@"score4"] forKey:@"score5"];
        [storage setDouble:score forKey:@"score4"];
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:[storage stringForKey:@"init7"] forKey:@"init8"];
        [storage setValue:[storage stringForKey:@"init6"] forKey:@"init7"];
        [storage setValue:[storage stringForKey:@"init5"] forKey:@"init6"];
        [storage setValue:[storage stringForKey:@"init4"] forKey:@"init5"];
        [storage setValue:person forKey:@"init4"];}
    else if(score < [storage doubleForKey:@"score5"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:[storage doubleForKey:@"score5"] forKey:@"score6"];
        [storage setDouble:score forKey:@"score5"];
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:[storage stringForKey:@"init7"] forKey:@"init8"];
        [storage setValue:[storage stringForKey:@"init6"] forKey:@"init7"];
        [storage setValue:[storage stringForKey:@"init5"] forKey:@"init6"];
        [storage setValue:person forKey:@"init5"];}
    else if(score < [storage doubleForKey:@"score6"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:[storage doubleForKey:@"score6"] forKey:@"score7"];
        [storage setDouble:score forKey:@"score6"];
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:[storage stringForKey:@"init7"] forKey:@"init8"];
        [storage setValue:[storage stringForKey:@"init6"] forKey:@"init7"];
        [storage setValue:person forKey:@"init6"];}
    else if(score < [storage doubleForKey:@"score7"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:[storage doubleForKey:@"score7"] forKey:@"score8"];
        [storage setDouble:score forKey:@"score7"];
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:[storage stringForKey:@"init7"] forKey:@"init8"];
        [storage setValue:person forKey:@"init7"];}
    else if(score < [storage doubleForKey:@"score8"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:[storage doubleForKey:@"score8"] forKey:@"score9"];
        [storage setDouble:score forKey:@"score8"];
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:[storage stringForKey:@"init8"] forKey:@"init9"];
        [storage setValue:person forKey:@"init8"];}
    else if(score < [storage doubleForKey:@"score9"]){
        [storage setDouble:[storage doubleForKey:@"score9"] forKey:@"score10"];
        [storage setDouble:score forKey:@"score9"];
        [storage setValue:[storage stringForKey:@"init9"] forKey:@"init10"];
        [storage setValue:person forKey:@"init9"];
}
    else if(score < [storage doubleForKey:@"score10"]){
        [storage setDouble:score forKey:@"score10"];
        [storage setValue:person forKey:@"init10"];}

    [storage synchronize];
}

/*reset the leaderboard to blanks*/
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
    [storage setValue:@"___" forKey:@"init1"];
    [storage setValue:@"___" forKey:@"init2"];
    [storage setValue:@"___" forKey:@"init3"];
    [storage setValue:@"___" forKey:@"init4"];
    [storage setValue:@"___" forKey:@"init5"];
    [storage setValue:@"___" forKey:@"init6"];
    [storage setValue:@"___" forKey:@"init7"];
    [storage setValue:@"___" forKey:@"init8"];
    [storage setValue:@"___" forKey:@"init9"];
    [storage setValue:@"___" forKey:@"init10"];
    [storage synchronize];
    [self updateLeaderboard];
}
/*dismiss modal view of the leaderboard*/
- (IBAction) dismissModalVC {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

@end
