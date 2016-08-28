// https://sketchplugindev.james.ooo/interacting-with-objective-c-classes-in-cocoascript-68be7f39616f#.ukt0xaq46

Class = function(className, BaseClass, selectorHandlerDict) {
    var uniqueClassName = className + NSUUID.UUID().UUIDString();
    var delegateClassDesc = MOClassDescription.allocateDescriptionForClassWithName_superclass_(uniqueClassName, BaseClass);
    for (var selectorString in selectorHandlerDict) {
        delegateClassDesc.addInstanceMethodWithSelector_function_(selectorString, selectorHandlerDict[selectorString]);
    }
    delegateClassDesc.registerClass();
    return NSClassFromString(uniqueClassName);
};
