//
//  UserListViewController.h
//  ExampleProject
//
//  Created by Felipe Antonio Cardoso on 06/02/16.
//  Copyright © 2016 ExampleProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseObjects/FirebaseCollection.h>
#import <Firebase/Firebase.h>
#import "User.h"


@interface UserListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSMutableDictionary * dictionary;
@property(nonatomic, strong) Firebase * firebase;
@property(nonatomic, strong) FirebaseCollection * collection;

@end
