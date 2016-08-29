@import 'helper.js'
@import 'MochaJSDelegate.js'

COScript.currentCOScript().setShouldKeepAround_(true)

var config = {
  width: 680,
  height: 400,
  topHeight: 50,
  backgroundColor: NSColor.colorWithCalibratedRed_green_blue_alpha(231/255, 232/255, 232/255, 1.0)
}

var manager = {
  delegateClass: new MochaJSDelegate(),
  delegate: null,
  dataSourceClass: new MochaJSDelegate(),
  dataSource: null,
  items: ["one", "two", "three"],

  setup: function() {
    this.dataSourceClass.setHandlerForSelector("numberOfRowsInTableView:", function(tableView) {
      log("numberOfRowsInTableView")
      return 2
    })

    this.dataSourceClass.setHandlerForSelector("tableView:objectValueForTableColumn:row:", function(tableView, column, row) {
      log("objectValueForTableColumn")
      log(column)
      log(row)
      return "hello"
    })

    this.delegateClass.setHandlerForSelector("tableView:didClickTableColumn:", function(tableView, column) {
      log("didClickTableColumn")
    })

    this.delegate = this.delegateClass.getClassInstance()
    this.dataSource = this.dataSourceClass.getClassInstance()
  }
}

var ui = {
  tableView: null,

  makeModalWindow: function() {
    var window = NSWindow.alloc().initWithContentRect_styleMask_backing_defer_(
      NSMakeRect(0, 0, config.width, config.height), NSTitledWindowMask, NSBackingStoreBuffered, false)
    window.backgroundColor = config.backgroundColor

    return window
  },

  makeContainerView: function(context) {
    var view = NSView.alloc().init()
    var topView = this.makeTopView(context)
    var tableViewContainer = this.makeTableView()

    view.addSubview(tableViewContainer)
    view.addSubview(topView)

    topView.frame = NSMakeRect(0, config.height - config.topHeight, config.width, config.topHeight)

    return view
  },

  makeTextField: function() {
    var textField = NSTextField.alloc().init()
    textField.editable = true
    textField.setFont(NSFont.systemFontOfSize(28))
    textField.textColor = NSColor.blackColor()
    textField.stringValue = "hello world"
    textField.cell().setPlaceholderString("Search")
    textField.bezeled = false
    textField.drawsBackground = false
    textField.bordered = false
    textField.cell().usesSingleLineMode = true
    textField.cell().wraps = true
    textField.cell().focusRingType = NSFocusRingTypeNone

    return textField
  },

  makeSearchImageView: function(plugin) {
    var imageView = NSImageView.alloc().init()
    imageView.frame = NSMakeRect(0, 0, 100, 100)
    imageView.image = helper.getImage(plugin)

    return imageView
  },

  makeTableView: function() {
    var rect = NSMakeRect(0, 0, config.width, config.height - config.topHeight)
    var container = NSScrollView.alloc().init()
    container.frame = rect

    var tableView = NSTableView.alloc().init()
    this.tableView = tableView
    tableView.frame = rect

    var column = NSTableColumn.alloc().initWithIdentifier("")
    column.width = config.width

    tableView.addTableColumn(column)
    // tableView.headerView = null

    manager.setup()

    tableView.setDataSource_(manager.dataSource)
    tableView.setDelegate_(manager.delegate)

    container.documentView = tableView
    container.hasVerticalScroller = true

    container.backgroundColor = NSColor.redColor()

    return container
  },

  makeTopView: function(context) {
    var view = NSView.alloc().init()

    var textField = this.makeTextField()
    var imageView = this.makeSearchImageView(context.plugin)

    view.addSubview(textField)
    view.addSubview(imageView)

    imageView.frame = NSMakeRect(5, config.topHeight - 39, 26, 26)
    textField.frame = NSMakeRect(40, config.topHeight - 45, config.width - 55, 40)

    return view
  }
}
