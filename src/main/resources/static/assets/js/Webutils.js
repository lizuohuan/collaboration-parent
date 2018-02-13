
// find the top window
var findTopWindow = function (currentWindow) {
    if (currentWindow.parent == currentWindow) {
        return currentWindow;
    } else {
        return findTopWindow(currentWindow.parent);
    }
};
