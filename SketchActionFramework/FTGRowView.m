//
//  FTGRow.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGRowView.h"

@interface FTGRowView ()

@property NSView *separatorView;

@end

@implementation FTGRowView

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
  self.titleTextField.font = [NSFont systemFontOfSize:16 weight:NSFontWeightRegular];

  self.subtitleTextField = [self makeTextField];
  self.subtitleTextField.font = [NSFont systemFontOfSize:13 weight:NSFontWeightLight];

  self.separatorView = [self makeSeparatorView];

  [self addSubview:self.titleTextField];
  [self addSubview:self.subtitleTextField];
  [self addSubview:self.separatorView];
}

- (void)configureLayout {
  self.titleTextField.frame = NSMakeRect(10, 5, self.bounds.size.width - 10, 30);
  self.subtitleTextField.frame = NSMakeRect(10, 25, self.bounds.size.width - 10, 20);

  self.separatorView.frame = NSMakeRect(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
}

// MARK: - Controls

- (NSTextField *)makeTextField {
  NSTextField *textField = [[NSTextField alloc] init];
  textField.editable = NO;
  textField.selectable = NO;
  textField.bezeled = NO;
  textField.textColor = [NSColor blackColor];
  textField.drawsBackground = NO;

  return textField;
}

- (NSView *)makeSeparatorView {
  NSView *view = [[NSView alloc] init];

  view.wantsLayer = YES;
  view.layer.backgroundColor = [[NSColor grayColor] colorWithAlphaComponent:0.4].CGColor;

  return view;
}

@end
