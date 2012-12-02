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
static NSDate *endTime = nil;
static NSDate* currentTime = nil;
static NSTimeInterval* completionTime = nil;
static NSTimeInterval* otherTime = nil;

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
    //    otherTime = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else{
        NSDate* opponentsTime = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        //compare completion times
        
    }
    
    
}

- (id) init{
    myPicker = [[GKPeerPickerController alloc] init]; myPicker.delegate = self;
    myPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    return [super init];
}

-(void)start{
    currentTime = [NSDate date];
    NSData* dataData = [NSKeyedArchiver archivedDataWithRootObject:currentTime];
    [mySession sendDataToAllPeers:dataData withDataMode:GKSendDataReliable error:nil];
}

-(void)end{
    NSDate* endTime = [NSDate date];
//    completionTime = [startTime timeIntervalSinceDate:endTime];
  //  NSData* dataData = [NSKeyedArchiver archivedDataWithRootObject:completionTime];
  //  [mySession sendDataToAllPeers:dataData withDataMode:GKSendDataReliable error:nil];
    
}

@end
