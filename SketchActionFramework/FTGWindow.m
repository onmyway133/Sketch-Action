//
//  Window.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGWindow.h"
#import "FTGMainView.h"
#import "FTGMenuItem.h"
#import "FTGHandler.h"

typedef NS_ENUM(NSUInteger, FTGKey) {
  FTGKeyLeft = 123,
  FTGKeyRight = 124,
  FTGKeyDown = 125,
  FTGKeyUp = 126,
  FTGKeyEnter = 36,
  FTGKeyBackspace = 51,
};

@interface FTGWindow ()

@property FTGMainView *mainView;
@property id monitor;

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
  self.monitor = [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyUpMask handler:^NSEvent * _Nullable(NSEvent * _Nonnull event) {
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
    case FTGKeyEnter: {
      FTGMenuItem *item = [self.mainView findCurrentItem];
      [self closeAndStop];
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FTGHandler handle:item];
      });
      [NSEvent removeMonitor:self.monitor];
      break;
    }
    case FTGKeyBackspace:
      [self.mainView handleKeyBackspace];
      break;
    default:
      break;
  }
}

@end
