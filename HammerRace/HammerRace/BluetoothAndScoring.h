//
//  BluetoothAndScoring.h
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface BluetoothAndScoring : NSObject<GKPeerPickerControllerDelegate, GKSessionDelegate>{
    GKPeerPickerController *myPicker;
    GKSession *mySession;
    NSString *myPeerID;
}

//called from view when wanting to connect to a find a partner
//returns true when successful
+(BluetoothAndScoring*)getInstance;
-(void)connectToPeer;
-(bool)isConnected;
-(void)start:(SEL)startMethod:(id)mainView;
-(void)end:(SEL)updateText:(id)mainView;
-(NSString*)endText;
-(double)getCompletionTime;

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID;

@end
