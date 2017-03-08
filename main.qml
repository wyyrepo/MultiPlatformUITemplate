import QtQuick 2.8
import QtQuick.Window 2.2

Window {
//Main window properties
    id: idMainWindow
    title: qsTr("MultiPlatformTemplate")
    visible: true
    width: 360
    height: 640
    minimumHeight: 360
    minimumWidth: 360
    property int orientation: 0 //0 = portrait, 1 = landscape
//  visibility: Window.FullScreen

//Title bar properties
    property double titleBarHeightLandscapeRatio: 0.125
    property double titleBarHeightPortraitRatio: 0.06
    property int titleBarHeight: idMainWindow.orientation == idMainWindow.orientationLandscape ? idMainWindow.height * titleBarHeightLandscapeRatio : idMainWindow.height * titleBarHeightPortraitRatio

//Main menu properties
    property double mainMenuWidthLandscapeRatio: 0.5
    property double mainMenuWidthPortraitRatio: 0.8
    property int mainMenuWidth: idMainWindow.orientation == idMainWindow.orientationLandscape ? idMainWindow.width * mainMenuWidthLandscapeRatio : idMainWindow.width * mainMenuWidthPortraitRatio
    property bool isMenuOpen: false

//Swipe area properties
    property int maximumTimeGesture: 190 //[ms] in this time you must move from point a to b to activate gesture
    //property double minimumDistanceGestureActivationRatio: -> for now unused (setting in Swipe area is used)

//End of properties section

    signal menuShowHide()
    signal menuSwipeGestureHide()
    signal menuSwipeGestureShow()

    onWidthChanged: {
        if( width > height  && idMainWindow.orientation != 1) {
            idMainWindow.orientation = 1
            titleBarHeight = idMainWindow.height * titleBarHeightLandscapeRatio
            mainMenu.submenuHeight = idMainWindow.height * titleBarHeightLandscapeRatio
            console.log("main window aspect ratio changed -> orientation = Landscape")
        } else if (width < height && idMainWindow.orientation != 0){
            idMainWindow.orientation = 0
            titleBarHeight = idMainWindow.height * titleBarHeightPortraitRatio
            mainMenu.submenuHeight = idMainWindow.height * titleBarHeightPortraitRatio
            console.log("main window aspect ratio changed -> orientation = Portrait")
        }
    }

    TitleBar {
        id: idTitleBar
        height: titleBarHeight
        anchors.top: parent.top
    }

    Loader {
        id: idLoaderFrame
        anchors.top: idTitleBar.bottom
        anchors.bottom: idMainWindow.bottom
        anchors.left: idMainWindow.left
        anchors.right: idMainWindow.right
    }

    MainMenu {
        id: idMainMenu
        anchors.top: idTitleBar.bottom
        submenuHeight: idMainWindow.orientation == idMainWindow.orientationLandscape ? idMainWindow.height * titleBarHeightLandscapeRatio : idMainWindow.height * titleBarHeightPortraitRatio
    }

    SwipeArea {
        id: idSwipeArea
        anchors.fill: parent
    }
}
