var landscape = 0
var portrait = 90
var reverseLandscape = 180
var reversePortrait = 270

var screen = { width: 960, height: 600 };

var singletonObjects = {}

function loadSingleton(fileName, parent, callback, data) {
    if (singletonObjects[fileName]) {
        callback(singletonObjects[fileName])
        return
    }

    loadComponent(fileName, function(loadedComponent) {
            if (data)
                singletonObjects[fileName] = loadedComponent.createObject(parent, data)
            else
                singletonObjects[fileName] = loadedComponent.createObject(parent)
            callback(singletonObjects[fileName])
    });
}

// TODO: component cache
function loadComponent(fileName, callback) {
    // TODO: handle loading multiple components at once
    // needed for async loading
    var loadingComponent = Qt.createComponent(fileName);

    // TODO: handle async loading
    if (!loadingComponent) {
        console.log("FAILED LOADING COMPONENT: " + fileName + " - " + loadingComponent.errorString())
        return
    }

    callback(loadingComponent);
}

