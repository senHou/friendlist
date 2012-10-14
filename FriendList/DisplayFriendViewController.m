//
//  DisplayFriendViewController.m
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DisplayFriendViewController.h"


@implementation DisplayFriendViewController

@synthesize friend;
@synthesize editFriendController;
@synthesize finishedEditDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        editFriendController = [[EditFriendController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return self;
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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                                                                target:self 
                                                                                action:@selector(editFriend:)]; 
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];
}

- (IBAction)editFriend:(id)sender{
    UINavigationController *navigationController = [[[UINavigationController alloc]
                                                    initWithRootViewController:editFriendController] autorelease];
    
    editFriendController.friend = friend;
    
    editFriendController.edit_delegate = self;
    [editFriendController.tableView reloadData];
    [self presentModalViewController:navigationController animated:YES];
}

-(void)friendEdited:(Friend *)editedFriend {    
    
    firstNameField.text = @"";
    lastNameField.text = @"";
    phoneField.text = @"";
    emailField.text = @"";
    self.friend = editedFriend;
    [[self tableView] reloadData];
    
    if ([finishedEditDelegate respondsToSelector:@selector(finishedEdit:)]){
        [finishedEditDelegate finishedEdit:self.friend];
    }
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
            [firstNameField setText:@""];
            tf = firstNameField = [self makeTextField:[friend firstName]];
            [firstNameField setEnabled:NO];
            [cell addSubview:firstNameField];
            break;
        }
        case 1 : {
            cell.textLabel.text = @"Last";
            [lastNameField setText:@""];
            tf = lastNameField = [self makeTextField:[friend lastName]];
            [lastNameField setEnabled:NO];
            [cell addSubview:lastNameField];
            break;
        }
        case 2 : {
            cell.textLabel.text = @"Phone";
            [phoneField setText:@""];
            tf = phoneField = [self makeTextField:[friend phone]];
            [phoneField setEnabled:NO];
            [cell addSubview:phoneField];
            break;
        }    
        case 3 : {
            cell.textLabel.text = @"Email";
            [emailField setText:@""];
            tf = emailField = [self makeTextField:[friend email]];
            [emailField setEnabled:NO];
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
    
    NSLog(@"%i",[indexPath row]);
    
    if ([indexPath row] == 3){
//        SendEmailController *sendEmailController = [[SendEmailController alloc] initWithNibName:@"SendEmailController" bundle:nil];
//        [sendEmailController setEmail:[emailField text]];
//        [self presentModalViewController:sendEmailController animated:YES];
        
        [self openMail];
    }
     // ...
     // Pass the selected object to the new view controller.
    //[self.navigationController pushViewController:sendEmailController animated:YES];
     
}

- (void)openMail{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@""];
        NSArray *toRecipients = [NSArray arrayWithObjects:[emailField text], nil];
        [mailer setToRecipients:toRecipients];
        //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //NSData *imageData = UIImagePNGRepresentation(myImage);
        //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
        [mailer release];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(UITextField*) makeTextField: (NSString*)text{
    
    UITextField *tf = [[[UITextField alloc] init] autorelease];
	tf.text = text ;         
	tf.autocorrectionType = UITextAutocorrectionTypeNo ;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.adjustsFontSizeToFitWidth = YES;
    
	tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f]; 	
	return tf ;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}


-(void) dealloc {
    [super dealloc];
    [friend release];
    [editFriendController release];
}

@end
