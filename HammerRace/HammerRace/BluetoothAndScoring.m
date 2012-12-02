//
//  BluetoothAndScoring.m
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import "BluetoothAndScoring.h"

@implementation BluetoothAndScoring
static BluetoothAndScoring *singleton = nil;
static NSDate *startTime = nil;
static NSDate *otherTime = nil;
static NSDate *endTime = nil;
static NSDate* currentTime = nil;
static double completionTime = -1;
static double otherCompletionTime = -1;
static SEL mainViewStart = nil;
static SEL mainViewEndText = nil;
static NSString* endText;

+(BluetoothAndScoring*)getInstance{
    @synchronized([BluetoothAndScoring class])
    {
        if (!singleton)
            singleton = [[self alloc] init];
        return singleton;
    }
    return nil;
}

-(void)connectToPeer{
    [myPicker show];
    
}

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

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
    [session acceptConnectionFromPeer:peerID error:nil];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer
           inSession:(GKSession *)session context:(void *)context{
    if (otherTime == nil) {
        otherTime = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (currentTime != nil) {
            startTime = [NSDate date];
            mainViewStart;
        }
    } else if(endTime != nil){
        [data getBytes:&otherCompletionTime length:sizeof(otherCompletionTime)];
        //compare completion times
        if (otherCompletionTime > completionTime) {
            mainViewEndText;
        } else{
            //we lost
            mainViewEndText;
        }
        
    } else{
        [data getBytes:&otherCompletionTime length:sizeof(otherCompletionTime)];
    }
    
    
}

- (id) init{
    myPicker = [[GKPeerPickerController alloc] init]; myPicker.delegate = self;
    myPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    return [super init];
}

-(void)start:(SEL)startMethod{
    currentTime = [NSDate date];
    NSData* dataData = [NSKeyedArchiver archivedDataWithRootObject:currentTime];
    [mySession sendDataToAllPeers:dataData withDataMode:GKSendDataReliable error:nil];
    if (otherTime != nil) {
        currentTime = [NSDate date];
        mainViewStart;
    }
}

-(void)end:(SEL)updateText{
    NSDate* endTime = [NSDate date];
    completionTime = [startTime timeIntervalSinceDate:endTime];
    NSData* dateData = [NSData dataWithBytes:&completionTime length:sizeof(completionTime)];
    [mySession sendDataToAllPeers:dateData withDataMode:GKSendDataReliable error:nil];
    
    
    if (otherCompletionTime != -1) {
        //compare completion times
        if (otherCompletionTime > completionTime) {
            endText = @"You won!";
        } else{
            endText = @"You lost!";
        }
    } else {
        endText = @"Waiting for partner";
    }
    
    mainViewEndText;
}

-(double)getCompletionTime{
    return completionTime;
}

-(NSString*)endText{
    return endText;
}

@end
