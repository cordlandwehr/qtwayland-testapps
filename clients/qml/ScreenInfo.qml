/*
    SPDX-License-Identifier: MIT
    SPDX-CopyrightText: Andreas Cord-Landwehr <cordlandwehr@kde.org>
*/

import QtQuick 2.0
import QtQuick.Window 2.2

Rectangle {
    color: "red"
    width: 200; height: width
    Component.onCompleted: {
        console.log("done")
        var screens = Qt.application.screens;
        for (var i = 0; i < screens.length; ++i)
            console.log("screen " + screens[i].name + " has geometry " +
                        screens[i].virtualX + ", " + screens[i].virtualY + " " +
                        screens[i].width + "x" + screens[i].height)
    }
}
