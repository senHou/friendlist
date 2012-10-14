//
//  FriendManager.m
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendManager.h"

@implementation FriendManager


@synthesize friendList;


-(id) init{
    if (self = [super init]){
        friendList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(BOOL) addFriend:(Friend *)friend{
    
    if ([self findFriendByFirstName:[friend firstName] andLastName:[friend lastName]] == NULL){
        [friendList addObject:friend];
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)deleteFriend:(Friend *)friend{
    if ([self findFriendByFirstName:[friend firstName] andLastName:[friend lastName]] !=NULL){
        [friendList removeObject:friend];
        return YES;
    }else{
        return NO;
    }
}

-(void)modifyFriendFirstName:(NSString *)first andLastName:(NSString *)last withData:(Friend *)newFriend{
    
    Friend *temp = [self findFriendByFirstName:first andLastName:last];
    if (temp != NULL) {
        [temp setFirstName:[newFriend firstName]];
        [temp setLastName:[newFriend lastName]];
        [temp setPhone:[newFriend phone]];
        [temp setEmail:[newFriend email]];
    }
}


-(Friend *) findFriendByFirstName:(NSString *)first andLastName:(NSString *)last{
    
    Friend *temp = NULL;
    NSString *firstName;
    NSString *lastName;
    for (int i = 0; i < [friendList count]; i++) {
        firstName = [[friendList objectAtIndex:i]firstName];
        lastName = [[friendList objectAtIndex:i]lastName];
        
        if([firstName isEqualToString:first] && [lastName isEqualToString:last]){
            temp = [friendList objectAtIndex:i];
            break;
        }
    }
    return temp;
}

- (void) dealloc {
    [super dealloc];
    
    [friendList release];
}

@end
