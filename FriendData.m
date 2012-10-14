//
//  FriendData.m
//  FriendList
//
//  Created by sen hou on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendData.h"


@implementation FriendData

@dynamic email;
@dynamic friendId;
@dynamic firstName;
@dynamic lastName;
@dynamic phone;

//add friend
+ (void) insertFriend:(Friend *)friend inManagedObjectContext:(NSManagedObjectContext *)context{
    
    FriendData *data = (FriendData *)[NSEntityDescription insertNewObjectForEntityForName:@"FriendData" inManagedObjectContext:context];
    
    [data setFirstName:[friend firstName]];
    [data setLastName:[friend lastName]];
    [data setPhone:[friend phone]];
    [data setEmail:[friend email]];
    [data setFriendId:[friend friendId]];
    
    NSError *error;
    
    if (![context save:&error]){
        NSLog(@"%@",[error description]);
    }
}


//get all friends
+ (NSMutableArray *)getFriendWithContext:(NSManagedObjectContext *)context{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FriendData" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [sortDescriptor release];
    
    [request setSortDescriptors:sortDescriptors];
    NSError *error;
    
    NSMutableArray *fentchResults = [[context executeFetchRequest:request error :&error] mutableCopy];
    
    [request release];
    
    if (!fentchResults){
        NSLog(@"%@",[error description]);
    }
    
    return [fentchResults autorelease] ;
}

//delete friend
+ (void) deleteFriendWithContext:(NSManagedObjectContext *)context andData:(Friend *) newFriend{
  
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FriendData" inManagedObjectContext:context];
    
    NSEntityDescription *tmpFriend = nil;
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"friendId=%@",[newFriend friendId]]];
    [request setEntity:entity];
    
    tmpFriend = [[context executeFetchRequest:request error:&error] lastObject];
    
    [request release];
    if (!error){
        NSLog(@"%@",[error description]);
        NSLog(@"fetch error");
    }else{
        
        if (tmpFriend == nil){
            NSLog(@"Nothing to be deleted");
        }else{
            [context deleteObject:(FriendData *)tmpFriend];
            if (![context save:&error]){
                NSLog(@"%@",[error description]);
                NSLog(@"save errors");
            }
        }
    }

}


//edit friend 
+ (void) editFriendWithContext:(NSManagedObjectContext *)context andData:(Friend *) newFriend{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FriendData" inManagedObjectContext:context];
    
    
    NSEntityDescription *tmpFriend = nil;
    NSError *error = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPredicate:[NSPredicate predicateWithFormat:@"friendId=%@",[newFriend friendId]]];
    [request setEntity:entity];
    
    tmpFriend = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (error != nil){
        NSLog(@"%@",[error debugDescription]);
    }else{
        if (tmpFriend == nil){
            NSLog(@"Nothing to be edited");
        }else{
            [(FriendData *)tmpFriend setFirstName:[newFriend firstName]];
            [(FriendData *)tmpFriend setLastName:[newFriend lastName]];
            [(FriendData *)tmpFriend setPhone:[newFriend phone]];
            [(FriendData *)tmpFriend setEmail:[newFriend email]];
            if (![context save:&error]){
                NSLog(@"%@",[error description]);
            }
        }
    }
}

@end
