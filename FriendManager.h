//
//  FriendManager.h
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"

@interface FriendManager : NSObject

@property (nonatomic, retain) NSMutableArray *friendList;

-(BOOL) addFriend:(Friend *)friend;

-(BOOL) deleteFriend:(Friend *)friend;

-(void) modifyFriendFirstName:(NSString *)first 
                  andLastName:(NSString *)last 
                     withData:(Friend *)newFriend;

-(Friend *) findFriendByFirstName:(NSString *)first andLastName:(NSString *)last;

@end
