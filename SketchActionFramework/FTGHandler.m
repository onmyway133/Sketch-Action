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
  return;
  
  NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
  [string appendString:@"tell application \"System Events\" to tell process \"Finder\"\n"];
  [string appendString:@" click menu item \"New Finder Window\" of menu 1 of menu bar item \"File\" of menu bar 1\n"];
  [string appendString:@"end tell"];

  NSAppleScript *script = [[NSAppleScript alloc] initWithSource:string];

  NSDictionary *errorDict;
  NSAppleEventDescriptor *descriptor = [script executeAndReturnError:&errorDict];

  if (descriptor != nil) {
    NSLog(@"%u", (unsigned int)descriptor.descriptorType);
  }
}

@end
