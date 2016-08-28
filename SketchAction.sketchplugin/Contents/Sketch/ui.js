@import 'helper.js'

var ui = {
  makeModalWindow: function() {
    var window = NSWindow.alloc().initWithContentRect_styleMask_backing_defer_(
      NSMakeRect(0, 0, 1365, 500), NSTitledWindowMask, NSBackingStoreBuffered, false)
    window.backgroundColor = NSColor.grayColor()

    return window
  },

  makeContainerView: function() {
    var view = NSView.alloc().init()

    return view
  },

  makeTextField: function() {
    var textField = NSTextField.alloc().init()
    textField.editable = true
    textField.setFont(NSFont.systemFontOfSize(32))
    textField.textColor = NSColor.blackColor()
    textField.frame = NSMakeRect(10, 10, 1365, 115)
    textField.stringValue = "hello world"
    textField.cell().setPlaceholderString("Search")

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

    textField.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(textField)
    view.addSubview(imageView)

    return view
  }
}
