//
//  UserListViewController.m
//  ExampleProject
//
//  Created by Felipe Antonio Cardoso on 06/02/16.
//  Copyright © 2016 ExampleProject. All rights reserved.
//

#import "UserListViewController.h"
#import <FirebaseObjects/FirebaseCollection.h>
#import <Firebase/Firebase.h>
#import "User.h"

@interface UserListViewController ()

@end

@implementation UserListViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];

  [_tableView setDelegate: self];
  [_tableView setDataSource: self];
  
  //*==================================
  //Some setup
  //*==================================
  #warning TODO: Set your Firebase AppName in base URL!
  _firebase = [[Firebase alloc] initWithUrl:@"https://YOUR-APP-NAME-HERE.firebaseio.com/users_example"];
  _dictionary = [NSMutableDictionary dictionary];
  _collection = [[FirebaseCollection alloc] initWithNode:_firebase dictionary:_dictionary type:[User class]];
  
  //*==================================
  //Methods to observe objects status
  //*==================================
  
  //Executed after add a object
  [_collection didAddChild:^(User * user) {
    [_tableView reloadData];
  }];
  
  //Executed after remove a object
  [_collection didRemoveChild:^(User * user)  {
    [_tableView reloadData];
  }];
  
  //Executed after update some object data
  //Try to edit a user name in your Firebase dashboard
  //After editing it will be updated in the tableView instantaneously
  [_collection didUpdateChild:^(User * user)  {
    NSInteger userIndex = [self indexOfUser:user];
    if(userIndex == ((NSInteger)-1)){ return; }
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:userIndex inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//TableView - UITableViewDataSource and UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  NSInteger count = [[_dictionary allValues] count];
  return ((count == 0) ?  1 : count);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  NSString * cellIdentifier = @"CellIdentifier";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  if([[_dictionary allKeys] count] == 0){
    
    cell.textLabel.text = @"NO REGISTRED USERS";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
  }else{
    
    User * user = [[_dictionary allValues] objectAtIndex:indexPath.row];
    cell.textLabel.text = user.name;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor blackColor];
    
  }
  
  return cell;
}

//Some helper methods
-(void)createUserWithName:(NSString *)name {
  
  //Insert new user to server and local store using FirebaseObjects, 'didAddChild:' is called after this.
  User * newUser = [[User alloc] init];
  newUser.name = name;
  [_collection addObject:newUser];
  
}

-(NSInteger)indexOfUser:(User *) user{
  
  for(User * currentUser in [_dictionary allValues]){
    if([currentUser isEqual:user]){
      return [[_dictionary allValues] indexOfObject: currentUser];
    }
  }
  
  return -1;
}

//Action on UITabBarButton
- (IBAction)addUser:(id)sender {
  
  __weak UserListViewController *weakSelf = self;

  UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"New user" message:@"Please, type a name" preferredStyle: UIAlertControllerStyleAlert];
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = @"Name";
  }];
  
  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
  }]];
  
  [alertController addAction:[UIAlertAction actionWithTitle:@"Insert" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    UITextField * textField =  [[alertController textFields] firstObject];
    if(([textField text] != nil) && (![[textField text] isEqualToString:@""])){
      [weakSelf createUserWithName: textField.text];
    }
  }]];
  
  [self presentViewController:alertController animated:true completion:nil];
}


@end
