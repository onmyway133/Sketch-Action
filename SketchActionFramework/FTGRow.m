//
//  FTGRow.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGRow.h"

@implementation FTGRow

- (BOOL)isFlipped {
  return YES;
}

- (instancetype)init {
  self = [super init];

  [self setup];
  return self;
}

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
}

// MARK: - Setup

- (void)setup {
  self.titleTextField = [self makeTextField];


  self.subtitleTextField = [self makeTextField];
}

// MARK: - Layout

// MARK: - Controls

- (NSTextField *)makeTextField {
  NSTextField *textField = [[NSTextField alloc] init];



  return textField;
}

@end
