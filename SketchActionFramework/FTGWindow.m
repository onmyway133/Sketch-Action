//
//  Window.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGWindow.h"
#import "FTGMainView.h"

@interface FTGWindow () 

@property FTGMainView *mainView;

@end

@implementation FTGWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
  self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];

  [self setup];

  return self;
}

// MARK: - Setup

- (void)setup {
  self.mainView = [[FTGMainView alloc] init];
  [self setContentView:self.mainView];
}

// MARK: - Controls

- (NSView *)makeContainerView {
  NSView *view = [[NSView alloc] init];

  return view;
}

// MARK: - Key

- (void)keyDown:(NSEvent *)theEvent {
  [super keyDown:theEvent];
}

- (void)cancelOperation:(id)sender {
  [self close];
  [[NSApplication sharedApplication] stopModal];
}

@end
