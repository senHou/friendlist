//
//  Friend.h
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic,retain)NSNumber *friendId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;


-(id) initPeopleWithFirstName:(NSString *)first 
                     lastName:(NSString *)last 
                  phoneNmuber:(NSString *)number 
                        Email:(NSString *)emailAddress
                        andID:(NSNumber *)fid;

@end
