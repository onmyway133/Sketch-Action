//
//  FTGMainView.h
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FTGMenuItem.h"

@interface FTGMainView : NSView

- (void)handleKeyDown;
- (void)handleKeyLeft;
- (void)handleKeyRight;
- (void)handleKeyBackspace;
- (FTGMenuItem *)findCurrentItem;

@end
