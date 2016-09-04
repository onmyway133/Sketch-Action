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

- (instancetype)init {
  self = [super init];

  return self;
}

- (void)say {
  NSLog(@"hello world");
}

- (FTGWindow *)makeWindow {
  CGRect rect = NSMakeRect(0, 0, windowWidth, windowHeight);
  return [[FTGWindow alloc] initWithContentRect:rect styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:NO];
}

@end
