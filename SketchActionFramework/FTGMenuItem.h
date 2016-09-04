//
//  FTGMenuItem.h
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AppKit;

@interface FTGMenuItem : NSObject

- (instancetype)initWithMenuItem:(NSMenuItem *)item;

@property NSString *path;
@property NSMenuItem *item;

- (void)trigger;

@end
