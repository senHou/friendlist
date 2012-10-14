//
//  DisplayFriendViewController.h
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "EditFriendController.h"
#import <MessageUI/MessageUI.h>


@protocol FinishedEditFriendDelegate <NSObject>

-(void) finishedEdit:(Friend *)data;

@end

@interface DisplayFriendViewController : UITableViewController <UITextFieldDelegate,EditFriendDelegate,MFMailComposeViewControllerDelegate>{
    
    UITextField *firstNameField;
    UITextField *lastNameField;
    UITextField *phoneField;    
    UITextField *emailField;
    
    id<FinishedEditFriendDelegate> finishedEditDelegate;
    
}

@property (nonatomic, retain) Friend *friend;
@property (nonatomic, retain) EditFriendController *editFriendController;
@property (nonatomic, retain) id<FinishedEditFriendDelegate> finishedEditDelegate;


// Creates a textfield with the specified text and placeholder text
-(UITextField*) makeTextField: (NSString*)text;
- (void)openMail;
@end
