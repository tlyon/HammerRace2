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
static NSDate* currentTime = nil;
static double completionTime = -1;
static double otherCompletionTime = -1;
static SEL mainViewStart = nil;
static SEL mainViewEndText = nil;
static NSString* endText;
static id mainViewRef;

+(BluetoothAndScoring*)getInstance{
    @synchronized([BluetoothAndScoring class])
    {
        if (!singleton)
            singleton = [[self alloc] init];
        return singleton;
    }
    return nil;
}

-(void)reset{
    if (completionTime != -1) {
        startTime = nil;
        otherTime = nil;
        currentTime = nil;
        completionTime = -1;
        otherCompletionTime = -1;
    }
}

-(void)connectToPeer{
    [myPicker show];
    
}

-(bool)isConnected{
    if (myPeerID == nil) {
        return false;
    } else{
        return true;
    }
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
    NSLog(@"received data: ");
    if (otherTime == nil) {
        otherTime = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"%@\n", [otherTime descriptionWithLocale: @"yyyy-MM-dd" ]);
        if (currentTime != nil) {
            startTime = [NSDate date];
            [mainViewRef performSelector:mainViewStart];
            return;
        }
    }
    
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
        [mainViewRef performSelector:mainViewEndText];
        
    } 
    
    
}

- (id) init{
    myPicker = [[GKPeerPickerController alloc] init]; myPicker.delegate = self;
    myPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    return [super init];
}

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

-(void)end:(double)withTime:(SEL)updateText :(id)mainView{
    mainViewRef = mainView;
    NSDate* endTime = [NSDate date];
    completionTime = withTime;
    NSData* dateData = [NSData dataWithBytes:&completionTime length:sizeof(completionTime)];
    [mySession sendDataToAllPeers:dateData withDataMode:GKSendDataReliable error:nil];
    mainViewEndText = updateText;
    
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

-(double)getCompletionTime{
    return completionTime;
}

-(NSString*)endText{
    return endText;
}

@end
