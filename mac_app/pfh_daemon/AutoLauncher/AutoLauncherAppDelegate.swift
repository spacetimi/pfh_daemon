//
//  AppDelegate.swift
//  AutoLauncher
//
//  Created by Avi Krishnan on 6/4/20.
//  Copyright © 2020 spacetimi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AutoLauncherAppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = runningApps.contains {
            $0.bundleIdentifier == "com.spacetimi.pfh-daemon"
        }

        if !isRunning {
            var path = Bundle.main.bundlePath as NSString
            for _ in 1...4 {
                path = path.deletingLastPathComponent as NSString
            }
            NSWorkspace.shared.launchApplication(path as String)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

