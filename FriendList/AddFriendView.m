//
//  AddFriendView.m
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddFriendView.h"


@implementation AddFriendView

@synthesize fManager;
@synthesize first;
@synthesize last;
@synthesize email;

@synthesize phone;
@synthesize friend;

@synthesize addFriendDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) dealloc{
    [super dealloc];
    [fManager release];
    [first release];
    [last release];
    [email release];
    [phone release];
    [friend release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                target:self 
                                                                                action:@selector(addFriendFinished:)]; 
    self.navigationItem.rightBarButtonItem = doneButton;
    
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                                  target:self 
                                                                                  action:@selector(cancelAddFriend:)]; 
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationItem.title = @"Add Friend";
    
    [doneButton release];
    [cancelButton release];
}

- (IBAction)addFriendFinished:(id)sender {
    
    
    if (firstNameField.text == @"" || lastNameField.text == @"" || phoneField.text == @"" || emailField.text ==@""){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Friend Error" message:@"Please fill all the fields" delegate:nil cancelButtonTitle:@"Go Back" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];
    }else {
        int number = [fManager.friendList count ] + 1;
        NSNumber *id = [NSNumber numberWithInt:number];
        
        Friend *tmp = [[[Friend alloc] initPeopleWithFirstName:[firstNameField text]
                                                      lastName:[lastNameField text] 
                                                   phoneNmuber:[phoneField text] 
                                                         Email:[emailField text]
                                                         andID:id] autorelease];
        
        if ([addFriendDelegate respondsToSelector:@selector(friendAdded:)]){
            [addFriendDelegate friendAdded:tmp];
        }
        
        [firstNameField setText:@""];
        [lastNameField setText:@""];
        [phoneField setText:@""];
        [emailField setText:@""];
        
        [self dismissViewControllerAnimated:YES completion: nil];
    }
}

- (IBAction)cancelAddFriend:(id)sender{
    [self dismissViewControllerAnimated:YES completion: nil];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    UITextField * tf = nil;
    
    switch (indexPath.row) {
            
        case 0 : {
            cell.textLabel.text = @"First";
            tf = firstNameField = [self makeTextField:@"" placeholder:@"Enter First Name"];
            [cell addSubview:firstNameField];
            break;
        }
        case 1 : {
            cell.textLabel.text = @"Last";
            tf = lastNameField = [self makeTextField:@"" placeholder:@"Enter Last Name"];
            [cell addSubview:lastNameField];
            break;
        }
        case 2 : {
            cell.textLabel.text = @"Phone";
            tf = phoneField = [self makeTextField:@"" placeholder:@"Enter Phone Number"];
            [cell addSubview:phoneField];
            break;
        }    
        case 3 : {
            cell.textLabel.text = @"Email";
            tf = emailField = [self makeTextField:@"" placeholder:@"Enter Email"];
            [cell addSubview:emailField];
            break;        
        }
    }
    
    tf.frame = CGRectMake(100, 12, 190, 30);
    
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    tf.delegate = self;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

// Creates a textfield with the specified text and placeholder text
-(UITextField*) makeTextField: (NSString*)text	
                  placeholder: (NSString*)placeholder {
    
    UITextField *tf = [[[UITextField alloc] init] autorelease];
	tf.placeholder = placeholder ;
	tf.text = text ;         
	tf.autocorrectionType = UITextAutocorrectionTypeNo ;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.adjustsFontSizeToFitWidth = YES;
    
	tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f]; 	
	return tf ;
    
}

// Handles UIControlEventEditingDidEndOnExit
- (IBAction)textFieldFinished:(id)sender {
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ( textField == phoneField ){
         [textField setKeyboardType:UIKeyboardTypePhonePad];
    }
}


// Textfield value changed, store the new value.
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
	if ( textField == firstNameField ) {
		first = textField.text ;
	} else if ( textField == lastNameField ) {
        last = textField.text;
	} else if ( textField == phoneField ) {
        phone = textField.text ;
	} else if ( textField == emailField ) {
        email = textField.text ;
	}
}

@end
