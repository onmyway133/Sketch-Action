//
//  Window.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGWindow.h"
#import "FTGMainView.h"

typedef NS_ENUM(NSUInteger, FTGKey) {
  FTGKeyLeft = 123,
  FTGKeyRight = 124,
  FTGKeyDown = 125,
  FTGKeyUp = 126,
  FTGKeyEnter = 36
};

@interface FTGWindow ()

@property FTGMainView *mainView;

@end

@implementation FTGWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
  self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];

  [self setup];

  return self;
}

- (BOOL)canBecomeKeyWindow {
  return YES;
}

- (BOOL)canBecomeMainWindow {
  return YES;
}

- (BOOL)becomeFirstResponder {
  return YES;
}

// MARK: - Setup

- (void)setup {
  self.mainView = [[FTGMainView alloc] init];

  self.mainView.wantsLayer = YES;
  self.mainView.layer.masksToBounds = YES;
  self.mainView.layer.cornerRadius = 5;
  self.mainView.layer.borderColor = [NSColor grayColor].CGColor;
  self.mainView.layer.borderWidth = 1;

  [self setContentView:self.mainView];

  self.backgroundColor = [NSColor clearColor];

  __weak FTGWindow *weakSelf = self;
  [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyUpMask handler:^NSEvent * _Nullable(NSEvent * _Nonnull event) {
    FTGWindow *strongSelf = weakSelf;
    [strongSelf handleEvent:event];

    return event;
  }];
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
  [self closeAndStop];
}

- (void)closeAndStop {
  [self close];
  [[NSApplication sharedApplication] stopModal];
}

// MARK: - Event

- (void)handleEvent:(NSEvent *)event {
  switch (event.keyCode) {
    case FTGKeyLeft:
      [self.mainView handleKeyLeft];
      break;
    case FTGKeyRight:
      [self.mainView handleKeyRight];
      break;
    case FTGKeyDown:
      [self.mainView handleKeyDown];
      break;
    case FTGKeyEnter:
      [self.mainView handleKeyEnter];
//      [self closeAndStop];
      break;
    default:
      break;
  }
}

@end
