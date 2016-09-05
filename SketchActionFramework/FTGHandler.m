//
//  FTGHandler.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGHandler.h"

@implementation FTGHandler

+ (void)handle:(FTGMenuItem *)item {
  NSInteger index = [item.item.menu indexOfItem:item.item];
  [item.item.menu performActionForItemAtIndex:index];
}

@end
