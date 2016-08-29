@import 'ui.js'

function onRun(context) {
  var window = context.document.window
  var plugin = context.plugin

  // containerView
  var containerView = ui.makeContainerView(context)

  // modalWindow
  var modalWindow = ui.makeModalWindow()
  modalWindow.contentView = containerView

  // run
  NSApplication.sharedApplication().runModalForWindow_(modalWindow)

  ui.tableView.reloadData()
}
