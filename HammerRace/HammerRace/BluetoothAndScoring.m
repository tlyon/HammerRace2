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

+(BluetoothAndScoring*)getInstance{
    @synchronized([BluetoothAndScoring class])
    {
        if (!singleton)
            singleton = [[self alloc] init];
        return singleton;
    }
    return nil;
}

+(BOOL)connectToPeer{
    
}

+(int)ready{
    
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
    
}

- (IBAction) connectBluetooth{
    
}

@end
