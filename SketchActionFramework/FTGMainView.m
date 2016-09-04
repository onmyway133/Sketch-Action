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
@property NSView *separatorView;
@property NSColor *myColor;

@property NSMutableArray<FTGMenuItem *> *totalItems;
@property NSArray<FTGMenuItem *> *items;
@property BOOL isTextFieldFirstResponder;

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
  self.separatorView = [self makeSeparatorView];

  self.topView.frame = NSMakeRect(0, 0, windowWidth, topHeight);
  self.separatorView.frame = NSMakeRect(0, topHeight - 1, windowWidth, 1);
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
  [self addSubview:self.separatorView];
  [self addSubview:self.scrollView];

  [self makeTextFieldFirstResponder];
}

// MARK: - Data

- (void)loadData {
  self.totalItems = [NSMutableArray array];

  for (NSMenuItem *child in [NSApplication sharedApplication].mainMenu.itemArray) {
    [self loadWithMenuItem:child];
  }

  [self.tableView reloadData];
}

- (void)loadWithMenuItem:(NSMenuItem *)item {
  FTGMenuItem *ftgItem = [[FTGMenuItem alloc] initWithMenuItem:item];

  if (item.title.length != 0) {
    [self.totalItems addObject:ftgItem];
  }

  for (NSMenuItem *child in item.submenu.itemArray) {
    [self loadWithMenuItem:child];
  }
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
  frame.size.height = tableView.rowHeight;
  rowView.frame = frame;

  [rowView configureLayout];

  rowView.titleTextField.stringValue = [item.item.title ftg_trimmed];
  rowView.subtitleTextField.stringValue = item.path;

  return rowView;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
  FTGMenuItem *item = self.items[self.tableView.selectedRow];
  self.textField.stringValue = item.item.title.ftg_trimmed;
}

// MARK: - Textfield Delegate

- (void)controlTextDidChange:(NSNotification *)notification {
  NSTextField *textField = [notification object];

  NSMutableArray *filteredItems = [NSMutableArray array];
  for (FTGMenuItem *item in self.totalItems) {
    if ([item.item.title ftg_contains:textField.stringValue]
        || [textField.stringValue ftg_contains:item.item.title.ftg_trimmed]) {
      [filteredItems addObject:item];
    }
  }

  self.items = filteredItems;
  [self.tableView reloadData];

  [self updateWindowSize];
}

- (void)updateWindowSize {
  CGFloat height = self.items.count * (self.tableView.rowHeight + 2) + topHeight;
  height = MIN(height, windowHeight);

  CGRect rect = self.window.frame;
  CGFloat offset = height - rect.size.height;

  rect.size.height += offset;
  rect.origin.y -= offset;
  [self.window setFrame:rect display:YES];
}

// MARK: - Key

- (void)handleKeyDown {
  [self.tableView.window makeFirstResponder:self.tableView];
  self.isTextFieldFirstResponder = NO;
}

- (void)handleKeyLeft {
  [self makeTextFieldFirstResponder];
}

- (void)handleKeyRight {
  [self makeTextFieldFirstResponder];
}

- (void)makeTextFieldFirstResponder {
  if (!self.isTextFieldFirstResponder) {
    self.isTextFieldFirstResponder = YES;
    [self.textField becomeFirstResponder];
  }
}

- (void)selectRow:(NSInteger)index {
  if (index <0 || index >= self.items.count) {
    return;
  }

  NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
  [self.tableView selectRowIndexes:set byExtendingSelection:NO];
  [self.tableView scrollRowToVisible:index];
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
  tableView.backgroundColor = self.myColor;

  return tableView;
}

- (NSScrollView *)makeScrollView {
  NSScrollView *scrollView = [[NSScrollView alloc] init];
  scrollView.hasVerticalScroller = YES;

  return scrollView;
}

- (NSView *)makeSeparatorView {
  NSView *view = [[NSView alloc] init];

  view.wantsLayer = YES;
  view.layer.backgroundColor = [[NSColor grayColor] colorWithAlphaComponent:0.4].CGColor;
  
  return view;
}

@end
