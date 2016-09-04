//
//  Manager.h
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTGWindow.h"

@interface FTGManager : NSObject

+ (instancetype)shared;
- (void)say;
- (FTGWindow *)makeWindow;

@end
