FirebaseObjects is a repo with a few classes to make common firebase tasks easier. 

FirebaseCollection: Keep a Dictionary in sync with a firebase
-------------------------------------------------------------

    // somewhere in viewDidLoad
    self.firebase = [[Firebase alloc] initWithUrl:@"https://fake.firebaseio.com/stuff"];
    self.dictionary = [NSMutableDictionary dictionary];
    self.collection = [[FirebaseCollection alloc] initWithNode:firebase dictionary:dictionary type:[User class]];
    
    [self.collection didAddChild:^(User * user) {
        // created remotely or locally, it is called here
        NSLog(@"New User %@", user);
        [self.tableView reloadData];
    }];
    
    User * me = [User new];
    me.name = @"me";
    [self.collection addObject:me];
    
### What if I want to run a table view?

Just use the dictionary's allValues to drive it. 

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return [self.dictionary.allValues count];
    }


### Initialization on object types

Tell the collection what type your objects should be by passing in the class. Alternatively, you can use the `factory` init method to create one with a block

    self.collection = [[FirebaseCollection alloc] initWithNode:firebase dictionary:dictionary factory:^(NSDictionary* value) {
        return [User new];
    }];
    
Firebase calls `setValuesForKeysWithDictionary` internally to set values on your object. So 

### Implement `Objectable`

Your class (`User` in this example) should implement the `Objectable` protocol so `FirebaseCollection` knows how to convert it into a dictionary.

    -(NSDictionary*)toObject {
        return [self dictionaryWithValuesForKeys:@[@"name"]];
    }
    
### Adding, Removing and Updating all handled for you

Use `didAddChild`, `didRemoveChild` and `didUpdateChild` to be notified when they have been changed



FirebaseConnection: be notified when connection changes
-------------------------------------------------------

    self.connection = [[FirebaseConnection alloc] initWithFirebaseName:@"myfirebasename" onConnect:^{
        [self connectToLobby];
    } onDisconnect:^{
        [self showDiconnectedScreen];
    }];
