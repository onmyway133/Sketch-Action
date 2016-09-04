//
//  FTGMenuItem.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGMenuItem.h"
#import "NSString+Extensions.h"

@implementation FTGMenuItem

- (instancetype)initWithMenuItem:(NSMenuItem *)item {
  self = [super init];
  self.item = item;
  [self setup];
  return self;
}

- (void)setup {
  self.chain = [NSMutableArray arrayWithObject:self.item];

  NSMenuItem *parent = self.item.parentItem;
  while (parent != nil) {
    [self.chain addObject:parent];
    parent = parent.parentItem;
  }

  NSMutableArray *items = [NSMutableArray array];
  for (NSMenuItem *i in self.chain.reverseObjectEnumerator) {
    [items addObject:i.title.ftg_trimmed];
  }

  self.path = [items componentsJoinedByString:@" ➞ "];
}

@end
