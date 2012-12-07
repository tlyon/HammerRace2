//
//  BluetoothAndScoring.m
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "BluetoothAndScoring.h"

@implementation BluetoothAndScoring
//singleton instance
static BluetoothAndScoring *singleton = nil;
//the time that the game begins
static NSDate *startTime = nil;
//the time sent from the other device
static NSDate *otherTime = nil;
//the time when start is pressed
static NSDate* currentTime = nil;
//how long it takes to finish
static double completionTime = -1;
//how long the other phone took
static double otherCompletionTime = -1;
//selector to the start function in the main view
static SEL mainViewStart = nil;
//selector to the method to update the text at the end
static SEL mainViewEndText = nil;
//String for the ending text
static NSString* endText;
//reference to the mainView class
static id mainViewRef;

//Get an instance of the current Bluetooth class
+(BluetoothAndScoring*)getInstance{
    @synchronized([BluetoothAndScoring class])
    {
        if (!singleton)
            singleton = [[self alloc] init];
        return singleton;
    }
    return nil;
}

//reset the scoring for a new game
-(void)reset{
    if (completionTime != -1) {
        startTime = nil;
        otherTime = nil;
        currentTime = nil;
        completionTime = -1;
        otherCompletionTime = -1;
    }
}

//use Bluetooth picker to connect to peer
-(void)connectToPeer{
    [myPicker show];
    
}

//returns True if connected to peer
-(bool)isConnected{
    if (myPeerID == nil) {
        return false;
    } else{
        return true;
    }
}

//implements the GameKit peer picker
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID
                   toSession:(GKSession *)session
{
    myPeerID = peerID;
    mySession = session;
    mySession.delegate = self;
    [mySession setDataReceiveHandler:self withContext:nil];
    // Remove the picker
    [picker dismiss];
}

//implements the GameKit peer picker
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
    [session acceptConnectionFromPeer:peerID error:nil];
}


//Handles the receive data.  Either setting start time or completion time
- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer
           inSession:(GKSession *)session context:(void *)context{
    NSLog(@"received data: ");
    
    //Get Start Time
    if (otherTime == nil) {
        otherTime = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"%@\n", [otherTime descriptionWithLocale: @"yyyy-MM-dd" ]);
        if (currentTime != nil) {
            startTime = [NSDate date];
            //Start the game if the other device is ready
            [mainViewRef performSelector:mainViewStart];
            return;
        }
        return;
    }
    
    //Get the Completion Time
    [data getBytes:&otherCompletionTime length:sizeof(otherCompletionTime)];
    NSLog(@"%f\n", otherCompletionTime);
    if(completionTime != -1){
        
        //compare completion times
        if (otherCompletionTime > completionTime) {
            endText = @"You won!";
            [self reset];
        } else if(otherCompletionTime == completionTime){
            endText = @"You tied!";
            [self reset];
        } else{
            //we lost
            endText = @"You lost!";
            [self reset];
        }
        //Set completion text
        [mainViewRef performSelector:mainViewEndText];
        
    } 
    
    
}

//initialize the game kit picker
- (id) init{
    myPicker = [[GKPeerPickerController alloc] init]; myPicker.delegate = self;
    myPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    return [super init];
}

//Handle start button and communication to peer. Calls back to main view when
//ready to start the game
-(void)start:(SEL)startMethod :(id)mainView{
    mainViewRef = mainView;
    mainViewStart = startMethod;
    currentTime = [NSDate date];
    NSData* dataData = [NSKeyedArchiver archivedDataWithRootObject:currentTime];
    [mySession sendDataToAllPeers:dataData withDataMode:GKSendDataReliable error:nil];
    if (otherTime != nil) {
        currentTime = [NSDate date];
        [mainView performSelector:startMethod];
    }
}

//Handles communication to the peer when the game is end
//Takes in completion time and calls the update text method
-(void)end:(double)withTime:(SEL)updateText :(id)mainView{
    mainViewRef = mainView;
    NSDate* endTime = [NSDate date];
    completionTime = withTime;
    NSData* dateData = [NSData dataWithBytes:&completionTime length:sizeof(completionTime)];
    [mySession sendDataToAllPeers:dateData withDataMode:GKSendDataReliable error:nil];
    mainViewEndText = updateText;
    
    //if other device already finished, return text
    if (otherCompletionTime != -1) {
        //compare completion times
        if (otherCompletionTime > completionTime) {
            endText = @"You won!";
            [self reset];
        } else if(otherCompletionTime == completionTime){
            endText = @"You tied!";
            [self reset];
        } else{
            endText = @"You lost!";
            [self reset];
        }
    } else {
        endText = @"Waiting for partner";
    }
    
    [mainView performSelector:updateText];
}

//return completion time
-(double)getCompletionTime{
    return completionTime;
}

//return ending text
-(NSString*)endText{
    return endText;
}

@end
