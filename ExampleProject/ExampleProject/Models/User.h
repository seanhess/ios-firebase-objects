//
//  User.h
//  ExampleProject
//
//  Created by Felipe Antonio Cardoso on 06/02/16.
//  Copyright © 2016 ExampleProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Objectable.h"

@interface User : NSObject <Objectable>

@property (nonatomic, strong) NSString * name;

@end
