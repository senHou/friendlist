//
//  FriendData.h
//  FriendList
//
//  Created by sen hou on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Friend.h"


@interface FriendData : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * friendId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phone;

+(void) insertFriend:(Friend *)friend inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSMutableArray *)getFriendWithContext:(NSManagedObjectContext *)context;
+ (void) editFriendWithContext:(NSManagedObjectContext *)context andData:(Friend *) newFriend;
+ (void) deleteFriendWithContext:(NSManagedObjectContext *)context andData:(Friend *) newFriend;

@end
