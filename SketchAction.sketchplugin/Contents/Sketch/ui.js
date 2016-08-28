@import 'helper.js'

var width = 1000
var height = 400
var topHeight = 50

var ui = {
  makeModalWindow: function() {
    var window = NSWindow.alloc().initWithContentRect_styleMask_backing_defer_(
      NSMakeRect(0, 0, width, height), NSTitledWindowMask, NSBackingStoreBuffered, false)
    window.backgroundColor = NSColor.grayColor()

    return window
  },

  makeContainerView: function(context) {
    var view = NSView.alloc().init()
    var topView = this.makeTopView(context)

    view.addSubview(topView)
    topView.frame = NSMakeRect(0, height - topHeight, width, topHeight)

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
    textField.cell.usesSingleLineMode = true
    textField.cell.wraps = true
    textField.cell.focusRingType = NSFocusRingTypeNone

    return textField
  },

  makeSearchImageView: function(plugin) {
    var imageView = NSImageView.alloc().init()
    imageView.frame = NSMakeRect(0, 0, 100, 100)
    imageView.image = helper.getImage(plugin)

    return imageView
  },

  makeTableView: function() {

  },

  makeTopView: function(context) {
    var view = NSView.alloc().init()

    var textField = this.makeTextField()
    var imageView = this.makeSearchImageView(context.plugin)

    view.addSubview(textField)
    view.addSubview(imageView)

    imageView.frame = NSMakeRect(5, topHeight - 39, 26, 26)
    textField.frame = NSMakeRect(40, topHeight - 45, width - 55, 40)

    return view
  }
}
