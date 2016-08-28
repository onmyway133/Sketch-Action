@import 'helper.js'

var ui = {
  makeModalWindow: function() {
    var window = NSWindow.alloc().initWithContentRect_styleMask_backing_defer_(
      NSMakeRect(0, 0, 1365, 500), NSTitledWindowMask, NSBackingStoreBuffered, false)
    window.backgroundColor = NSColor.grayColor()

    return window
  },

  makeContainerView: function(context) {
    var view = NSView.alloc().init()
    var topView = this.makeTopView(context)

    view.addSubview(topView)
    topView.translatesAutoresizingMaskIntoConstraints = false

    topView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
    topView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
    topView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    topView.heightAnchor.constraintEqualToConstant(40.0).active = true

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

    view.addSubview(textField)
    view.addSubview(imageView)

    textField.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false

    imageView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
    imageView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    imageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    imageView.widthAnchor.constraintEqualToConstant(40.0).active = true

    textField.leftAnchor.constraintEqualToAnchor(imageView.rightAnchor).active = true
    textField.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
    textField.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    textField.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true

    return view
  }
}
