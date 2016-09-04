//
//  FTGMainView.m
//  SketchActionFramework
//
//  Created by Khoa Pham on 04/09/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

#import "FTGMainView.h"
#import "FTGMenuItem.h"
#import "FTGRowView.h"
#import "FTGConstants.h"
#import "NSString+Extensions.h"

@interface FTGMainView () <NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>

@property NSTextField *textField;
@property NSImageView *imageView;
@property NSTableView *tableView;
@property NSScrollView *scrollView;
@property NSView *topView;
@property NSColor *myColor;

@property NSMutableArray<FTGMenuItem *> *items;

@end

@implementation FTGMainView

- (instancetype)init {
  self = [super init];
  [self setup];
  [self loadData];
  return self;
}

- (BOOL)isFlipped {
  return YES;
}

// MARK: - Setup

- (void)setup {
  self.myColor = [NSColor colorWithCalibratedRed:231/255.0f green:232/255.0f blue:232/255.0f alpha:1.0f];

  // Controls
  self.textField = [self makeTextField];
  self.imageView = [self makeImageView];
  self.tableView = [self makeTableView];
  self.scrollView = [self makeScrollView];
  self.topView = [self makeTopView];

  self.topView.frame = NSMakeRect(0, 0, windowWidth, topHeight);
  self.scrollView.frame = NSMakeRect(0, topHeight, windowWidth, windowHeight - topHeight);
  self.tableView.tableColumns.firstObject.width = self.scrollView.frame.size.width;

  // Top
  [self.topView addSubview:self.textField];
  [self.topView addSubview:self.imageView];

  self.imageView.frame = NSMakeRect(5, 12, 26, 26);
  self.textField.frame = NSMakeRect(40, 2, windowWidth - 55, 40);

  // Table view
  self.scrollView.documentView = self.tableView;

  // Window content view
  [self addSubview:self.topView];
  [self addSubview:self.scrollView];

  [self.textField becomeFirstResponder];
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

  if (item.title.length != 0) {
    [self.items addObject:ftgItem];
  }

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

  NSBundle *bundle = [NSBundle bundleForClass:[FTGMainView class]];
  imageView.image = [bundle imageForResource:@"search"];

  return imageView;
}

- (NSView *)makeTopView {
  NSView *view = [[NSView alloc] init];

  view.wantsLayer = YES;
  view.layer.backgroundColor = self.myColor.CGColor;

  return view;
}

- (NSTableView *)makeTableView {
  NSTableView *tableView = [[NSTableView alloc] init];
  tableView.focusRingType = NSFocusRingTypeNone;

  NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"column-identifier"];
  [tableView addTableColumn:column];

  tableView.dataSource = self;
  tableView.delegate = self;

  tableView.rowHeight = 46;
  tableView.headerView = nil;

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
  FTGRowView *rowView = [[FTGRowView alloc] init];
  FTGMenuItem *item = self.items[row];

  CGRect frame = rowView.frame;
  frame.size.width = tableView.frame.size.width;
  rowView.frame = frame;

  [rowView configureLayout];

  rowView.titleTextField.stringValue = [item.item.title ftg_trimmed];
  rowView.subtitleTextField.stringValue = item.path;

  return rowView;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  return nil;
}

// MARK: - Textfield Delegate

- (void)controlTextDidChange:(NSNotification *)notification {
  NSTextField *textField = [notification object];
}

@end
