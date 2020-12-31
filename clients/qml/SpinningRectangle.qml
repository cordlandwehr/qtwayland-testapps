/*
    SPDX-License-Identifier: MIT
    SPDX-CopyrightText: Andreas Cord-Landwehr <cordlandwehr@kde.org>
*/

import QtQuick 2.0
import QtQuick.Window 2.2

Rectangle {
    color: "red"
    width: 200; height: width
    Rectangle {
        anchors.centerIn: parent
        color: "yellow"
        width: 50; height: width
        NumberAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 1000
        }
    }
}
