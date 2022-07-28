/*
    SPDX-License-Identifier: MIT
    SPDX-CopyrightText: Andreas Cord-Landwehr <cordlandwehr@kde.org>
*/

import QtQuick 2.15
import QtQuick.Window 2.15
import QtWayland.Compositor 1.0

WaylandCompositor {
    id: root
    property ListModel shellSurfaces: ListModel {}

    WaylandOutput {
        compositor: root
        sizeFollowsWindow: true
        window: Window {
            id: topSurfaceArea
            width: 1024
            height: 768
            visible: true
            color: "#1337af"

            Repeater {
                model: root.shellSurfaces
                ShellSurfaceItem {
                    shellSurface: modelData
                }
            }
        }
    }

    Component {
        id: chromeComponent
        WaylandQuickItem {
            onSurfaceDestroyed: destroy()
        }
    }

    Component {
        id: xdgPopupComponent
        ShellSurfaceItem {
            onSurfaceDestroyed: destroy()
        }
    }

    WlShell {
        onWlShellSurfaceCreated: handleShellSurfaceCreated(shellSurface)
    }

    property variant viewsBySurface: ({})

    function handleShellSurfaceCreated(shellSurface) {
         root.shellSurfaces.append({"shellSurface": shellSurface})
    }

    XdgShellV5 {
        onXdgSurfaceCreated: handleShellSurfaceCreated(xdgSurface)
        onXdgPopupCreated: {
            var parentViews = viewsBySurface[xdgPopup.parentSurface];
            xdgPopupComponent.createObject(parentViews.top, { "shellSurface": xdgPopup } );
            xdgPopupComponent.createObject(parentViews.bottom, { "shellSurface": xdgPopup } );
        }
    }
}
