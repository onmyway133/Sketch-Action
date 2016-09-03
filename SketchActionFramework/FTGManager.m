//
//  Manager.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGManager.h"

@implementation FTGManager

+ (instancetype)shared {
  static FTGManager *manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[FTGManager alloc] init];
  });

  return manager;
}

- (void)say {
  NSLog(@"hello world");
}

@end
