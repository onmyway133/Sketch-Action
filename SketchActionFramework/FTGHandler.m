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
  NSLog(@"%@", item.path);
}

@end
