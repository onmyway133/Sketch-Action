//
//  FTGHandler.h
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTGMenuItem.h"

@interface FTGHandler : NSObject

+ (void)handle:(FTGMenuItem *)item;

@end
