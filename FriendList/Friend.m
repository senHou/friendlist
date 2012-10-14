//
//  Friend.m
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Friend.h"

@implementation Friend

@synthesize firstName;
@synthesize lastName;
@synthesize phone;
@synthesize email;
@synthesize friendId;

-(id) initPeopleWithFirstName:(NSString *)first 
                     lastName:(NSString *)last 
                  phoneNmuber:(NSString *)number 
                        Email:(NSString *)emailAddress
                        andID:(NSNumber *)fid{
    
    if (self = [super init]){
        [self setFirstName:first];
        [self setLastName:last];
        [self setPhone:number];
        [self setEmail:emailAddress];
        [self setFriendId:fid];
    }
    
    return self;
}

-(void) dealloc{
    [super dealloc];
    [firstName release];
    [lastName release];
    [phone release];
    [email release];
    [friendId release];
}

-(NSString *) description{
    NSString * desc = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",firstName,lastName,phone,email,friendId];
    return desc;
}

@end
