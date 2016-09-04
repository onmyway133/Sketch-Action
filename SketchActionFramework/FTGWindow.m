//
//  Window.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGWindow.h"
#import "FTGMenuItem.h"
#import "FTGRow.h"

@interface FTGWindow () <NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>

@property NSView *containerView;
@property NSTextField *textField;
@property NSImageView *imageView;
@property NSTableView *tableView;
@property NSScrollView *scrollView;
@property NSView *topView;
@property NSColor *myColor;

@property NSMutableArray<FTGMenuItem *> *items;

@end

@implementation FTGWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
  self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];

  [self setup];
  [self loadData];

  return self;
}

// MARK: - Setup

- (void)setup {
  self.myColor = [NSColor colorWithCalibratedRed:231/255.0f green:232/255.0f blue:232/255.0f alpha:1.0f];

  self.backgroundColor = self.myColor;

  // Controls
  self.containerView = [self makeContainerView];
  self.textField = [self makeTextField];
  self.imageView = [self makeImageView];
  self.tableView = [self makeTableView];
  self.scrollView = [self makeScrollView];
  self.topView = [self makeTopView];

  self.topView.frame = NSMakeRect(0, windowHeight - topHeight, windowWidth, topHeight);
  self.scrollView.frame = NSMakeRect(0, 0, windowWidth, windowHeight - topHeight);
  self.tableView.tableColumns.firstObject.width = self.scrollView.frame.size.width;

  // Top
  [self.topView addSubview:self.textField];
  [self.topView addSubview:self.imageView];

  self.imageView.frame = NSMakeRect(5, topHeight - 39, 26, 26);
  self.textField.frame = NSMakeRect(40, topHeight - 50, windowWidth - 55, 40);

  // Table view
  self.scrollView.documentView = self.tableView;

  // Window content view
  [self.containerView addSubview:self.topView];
  [self.containerView addSubview:self.scrollView];

  [self setContentView:self.containerView];
}

// MARK: - Data

- (void)loadData {
  self.items = [NSMutableArray array];

  for (NSMenuItem *child in [NSApplication sharedApplication].mainMenu.itemArray) {
    [self loadWithMenuItem:child];
  }

  [self.tableView reloadData];
}

- (void)loadWithMenuItem:(NSMenuItem *)item {
  FTGMenuItem *ftgItem = [[FTGMenuItem alloc] initWithMenuItem:item];
  [self.items addObject:ftgItem];

  for (NSMenuItem *child in item.submenu.itemArray) {
    [self loadWithMenuItem:child];
  }
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
  textField.font = [NSFont systemFontOfSize:26];
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

  view.wantsLayer = YES;
  view.layer.backgroundColor = self.myColor.CGColor;

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
  FTGRow *rowView = [[FTGRow alloc] init];

  return rowView;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  return nil;
}

// MARK: - Textfield Delegate

- (void)controlTextDidChange:(NSNotification *)notification {
  NSTextField *textField = [notification object];
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
