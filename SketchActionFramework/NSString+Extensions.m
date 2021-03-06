//
//  NSString+Extensions.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

- (NSString *)ftg_trimmed {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)ftg_contains:(NSString *)string {
  return [self rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound;
}

@end
