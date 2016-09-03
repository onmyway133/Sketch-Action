@import 'ui.js'

function onRun(context) {
  var window = context.document.window
  var plugin = context.plugin

  var path = context.plugin.url().absoluteString().stringByAppendingPathComponent("Contents/Resources")
  log(path)
  loadFramework(path)
}

function loadFramework(pluginRoot) {
  if (NSClassFromString('Window') == null) {
    var mocha = [Mocha sharedRuntime]
    return [mocha loadFrameworkWithName: "SketchActionFramework" inDirectory: pluginRoot]
  } else {
    return true
  }
}
