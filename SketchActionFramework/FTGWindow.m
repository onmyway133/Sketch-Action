//
//  Window.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGWindow.h"

static CGFloat windowWidth = 680;
static CGFloat windowHeight = 400;
static CGFloat topHeight = 50;

@interface FTGWindow ()

@property NSView *containerView;
@property NSTextField *textField;
@property NSImageView *imageView;
@property NSTableView *tableView;
@property NSScrollView *scrollView;
@property NSView *topView;

@end

@implementation FTGWindow

- (id)init {
  self = [super init];

  return self;
}

// MARK: - Setup

- (void)setup {
  self.backgroundColor = [NSColor colorWithCalibratedRed:231/255 green:232/255 blue:232/255 alpha:1.0];

  self.containerView = [self makeContainerView];
  self.textField = [self makeTextField];
  self.imageView = [self makeImageView];
  self.tableView = [self makeTableView];
  self.scrollView = [self makeScrollView];
  self.topView = [self makeTopView];
}

// MARK: - Controls

- (NSTextField *)makeTextField {
  NSTextField *textField = [[NSTextField alloc] init];

  return textField;
}

- (NSImageView *)makeImageView {
  NSImageView *imageView = [[NSImageView alloc] init];

  return imageView;
}

- (NSView *)makeTopView {
  NSView *view = [[NSView alloc] init];

  return view;
}

- (NSView *)makeContainerView {
  NSView *view = [[NSView alloc] init];

  return view;
}

- (NSTableView *)makeTableView {
  NSTableView *tableView = [[NSTableView alloc] init];

  return tableView;
}

- (NSScrollView *)makeScrollView {
  NSScrollView *scrollView = [[NSScrollView alloc] init];

  return scrollView;
}

@end
