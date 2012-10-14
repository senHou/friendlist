//
//  EditFriendController.h
//  FriendList
//
//  Created by sen hou on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@protocol EditFriendDelegate <NSObject>

-(void)friendEdited:(Friend *)friend;

@end

@interface EditFriendController : UITableViewController <UITextFieldDelegate>{

    UITextField *firstNameField;
    UITextField *lastNameField;
    UITextField *phoneField;    
    UITextField *emailField;
    
    id <EditFriendDelegate> edit_delegate;
}

@property (nonatomic, retain) Friend *friend;
@property (nonatomic, retain) id <EditFriendDelegate> edit_delegate;

- (IBAction)cancelEditFriend:(id)sender;
- (IBAction)doneEdit:(id)sender;

-(UITextField*) makeTextField: (NSString*)text;
@end
