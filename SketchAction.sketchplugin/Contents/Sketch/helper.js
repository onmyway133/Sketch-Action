var helper = {
  getImage: function(plugin) {
    var imageFilePath = plugin.urlForResourceNamed("search@2x.png")
    var imageData = NSData.dataWithContentsOfURL(imageFilePath)
    var image = NSImage.alloc().initWithData(imageData)

    return image
  }
}
