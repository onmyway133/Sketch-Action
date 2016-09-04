//
//  Window.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGWindow.h"

@interface FTGWindow () <NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>

@property NSView *containerView;
@property NSTextField *textField;
@property NSImageView *imageView;
@property NSTableView *tableView;
@property NSScrollView *scrollView;
@property NSView *topView;
@property NSColor *myColor;

@property NSArray<NSMenuItem *> *items;

@end

@implementation FTGWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
  self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];

  [self setup];

  return self;
}

// MARK: - Setup

- (void)setup {
  self.myColor = [NSColor colorWithCalibratedRed:231/255 green:232/255 blue:232/255 alpha:1.0];

  self.backgroundColor = self.myColor;

  self.containerView.wantsLayer = YES;
  self.containerView.layer.backgroundColor = self.myColor.CGColor;

  // Controls
  self.containerView = [self makeContainerView];
  self.textField = [self makeTextField];
  self.imageView = [self makeImageView];
  self.tableView = [self makeTableView];
  self.scrollView = [self makeScrollView];
  self.topView = [self makeTopView];

  self.topView.frame = NSMakeRect(0, windowHeight - topHeight, windowWidth, topHeight);
  self.scrollView.frame = NSMakeRect(0, 0, windowWidth, windowHeight - topHeight);
  self.tableView.tableColumns.firstObject.width = self.tableView.frame.size.width;

  // Top
  [self.topView addSubview:self.textField];
  [self.topView addSubview:self.imageView];

  self.imageView.frame = NSMakeRect(5, topHeight - 39, 26, 26);
  self.textField.frame = NSMakeRect(40, topHeight - 45, windowWidth - 55, 40);

  // Table view
  self.scrollView.documentView = self.tableView;

  // Window content view
  [self.containerView addSubview:self.topView];
  [self.containerView addSubview:self.scrollView];

  [self setContentView:self.containerView];
}

// MARK: - Data

- (void)loadData {

}

// MARK: - Controls

- (NSTextField *)makeTextField {
  NSTextField *textField = [[NSTextField alloc] init];
  textField.focusRingType = NSFocusRingTypeNone;
  textField.bezeled = NO;
  textField.bordered = NO;
  textField.cell.usesSingleLineMode = YES;
  textField.cell.wraps = NO;
  textField.placeholderString = @"Search";
  textField.editable = YES;
  textField.font = [NSFont systemFontOfSize:14];
  textField.backgroundColor = [NSColor clearColor];

  textField.delegate = self;

  return textField;
}

- (NSImageView *)makeImageView {
  NSImageView *imageView = [[NSImageView alloc] init];

  NSBundle *bundle = [NSBundle bundleForClass:[FTGWindow class]];
  imageView.image = [bundle imageForResource:@"search"];

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
  tableView.focusRingType = NSFocusRingTypeNone;

  NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"column-identifier"];
  [tableView addTableColumn:column];

  tableView.dataSource = self;
  tableView.delegate = self;

  return tableView;
}

- (NSScrollView *)makeScrollView {
  NSScrollView *scrollView = [[NSScrollView alloc] init];
  scrollView.hasVerticalScroller = YES;

  return scrollView;
}

// MARK: - Table Data source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return self.items.count;
}

// MARK: - Table Delegate

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
  return [[NSTableRowView alloc] init];
}

- (void)controlTextDidChange:(NSNotification *)notification {
  NSTextField *textField = [notification object];
  NSLog(@"controlTextDidChange: stringValue == %@", [textField stringValue]);
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
