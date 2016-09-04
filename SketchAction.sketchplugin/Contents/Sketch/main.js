@import 'ui.js'

function pluginPath(context) {
	var basePath = NSString.stringWithFormat_(context.scriptPath)
	.stringByDeletingLastPathComponent()
	.stringByDeletingLastPathComponent()
	.stringByDeletingLastPathComponent()

	return basePath + "/Contents/Resources/";
}

function loadFramework(pluginRoot) {
  if (NSClassFromString('FTGManager') == null) {
    var mocha = [Mocha sharedRuntime]
    return [mocha loadFrameworkWithName: "SketchActionFramework" inDirectory: pluginRoot]
  } else {
    return true
  }
}

var modalWindow = null

function onRun(context) {
  var window = context.document.window
  var plugin = context.plugin

  var path = pluginPath(context)
  var result = loadFramework(path)
  var manager = FTGManager.shared()
  manager.say()

  modalWindow = manager.makeWindow()
  NSApplication.sharedApplication().runModalForWindow_(modalWindow)
}
