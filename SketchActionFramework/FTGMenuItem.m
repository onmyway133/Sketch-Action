//
//  FTGMenuItem.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGMenuItem.h"

@implementation FTGMenuItem

- (instancetype)initWithMenuItem:(NSMenuItem *)item {
  self = [super init];
  self.item = item;
  [self setup];
  return self;
}

- (void)setup {
  self.path = @"File -> New -> Class";
}

@end
