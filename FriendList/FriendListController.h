//
//  FriendListController.h
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendManager.h"
#import "AddFriendView.h"
#import "DisplayFriendViewController.h"
#import "Friend.h"
#import "FriendData.h"

@interface FriendListController : UITableViewController <AddFriendDelegate , FinishedEditFriendDelegate>


@property (nonatomic, retain) FriendManager *fManager;
@property (nonatomic, retain) AddFriendView *addFriendView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain) DisplayFriendViewController *detailViewController;

-(IBAction) addFriend:(id)sender;

@end
