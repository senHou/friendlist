//
//  FriendListController.m
//  FriendList
//
//  Created by sen hou on 9/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendListController.h"


@implementation FriendListController

@synthesize fManager;
@synthesize addFriendView;
@synthesize managedObjectContext;
@synthesize detailViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        fManager = [[FriendManager alloc] init];
        addFriendView = [[AddFriendView alloc] initWithStyle:UITableViewStyleGrouped];
        detailViewController = [[DisplayFriendViewController alloc] initWithStyle:UITableViewStyleGrouped];
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
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [ fManager setFriendList:[FriendData getFriendWithContext:managedObjectContext]];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend:)];
    self.navigationItem.rightBarButtonItem = button;
    self.navigationItem.title = @"Friend List";
    detailViewController.finishedEditDelegate = self;
    [button release];
    
    
//        [button addTarget:self action:@selector(simpleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction) addFriend:(id)sender {
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:addFriendView];
    addFriendView.addFriendDelegate = self;
    addFriendView.fManager = self.fManager;
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    
}


//delegate method from AddFriendView
-(void) friendAdded:(Friend *)friend {
    
    [FriendData insertFriend:friend inManagedObjectContext:managedObjectContext];
    [fManager setFriendList:[FriendData getFriendWithContext:managedObjectContext]];
    
    [[self tableView] reloadData];
}


//delegate method from DisplayFriendViewController
-(void) finishedEdit:(Friend *)data{
    [FriendData editFriendWithContext:managedObjectContext andData:data];
    [fManager setFriendList:[FriendData getFriendWithContext:managedObjectContext]];
    [[self tableView] reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[fManager friendList ]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[fManager.friendList objectAtIndex:indexPath.row] firstName];
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Friend *tmp = [fManager.friendList objectAtIndex:indexPath.row];
        [FriendData deleteFriendWithContext:managedObjectContext andData:tmp];
        fManager.friendList = [FriendData getFriendWithContext:managedObjectContext];
        
        [self.tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    detailViewController.friend = [fManager.friendList objectAtIndex:indexPath.row];
     // ...
     // Pass the selected object to the new view controller.
    [detailViewController.tableView reloadData];
    detailViewController.navigationItem.title = [[fManager.friendList objectAtIndex:indexPath.row ] firstName];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


-(void) dealloc{
    [super dealloc];
    [fManager release];
    [addFriendView release];
    [detailViewController release];
    [managedObjectContext release];
}

@end
