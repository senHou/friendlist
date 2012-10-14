//
//  AddFriendView.h
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "FriendManager.h"
#import "DisplayFriendViewController.h"

@protocol AddFriendDelegate <NSObject>

-(void)friendAdded:(Friend *)friend;

@end

@interface AddFriendView : UITableViewController <UITextFieldDelegate>{
    
    IBOutlet UITextField *firstNameField;
    IBOutlet UITextField *lastNameField;
    IBOutlet UITextField *phoneField;    
    IBOutlet UITextField *emailField;

    NSString *first;
    NSString *last;
    NSString *phone;
    NSString *email;
    
    id<AddFriendDelegate> addFriendDelegate;
}

@property (nonatomic, retain) Friend *friend;
@property (nonatomic, retain) FriendManager *fManager;
@property (nonatomic,copy)  NSString *first;
@property (nonatomic,copy)  NSString *last;
@property (nonatomic,copy)  NSString *phone;
@property (nonatomic,copy)  NSString *email;

@property (nonatomic, retain)id addFriendDelegate;

// Creates a textfield with the specified text and placeholder text
-(UITextField*) makeTextField: (NSString*)text	
                  placeholder: (NSString*)placeholder;


// Handles UIControlEventEditingDidEndOnExit

- (IBAction)textFieldFinished:(id)sender ;
- (IBAction)addFriendFinished:(id)sender ;
- (IBAction)cancelAddFriend:(id)sender;



@end
