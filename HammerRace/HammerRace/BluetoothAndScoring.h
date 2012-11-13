//
//  BluetoothAndScoring.h
//  HammerRace
//
//  Created by Todd Lyon on 11/13/12.
//  Copyright (c) 2012 CprE388. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothAndScoring : NSObject

//called from view when wanting to connect to a find a partner
//returns true when successful
-(BOOL)connectToPeer;

-(int)ready;


@end
