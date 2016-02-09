//
//  User.m
//  ExampleProject
//
//  Created by Felipe Antonio Cardoso on 06/02/16.
//  Copyright © 2016 ExampleProject. All rights reserved.
//

#import "User.h"

@implementation User

-(NSDictionary *)toObject{
  return [self dictionaryWithValuesForKeys:@[@"name"]];
}

@end
