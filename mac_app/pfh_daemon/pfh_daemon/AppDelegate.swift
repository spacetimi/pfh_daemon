//
//  AppDelegate.swift
//  pfh_daemon
//
//  Created by Avi Krishnan on 5/29/20.
//  Copyright © 2020 spacetimi. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var dumpFileHelper: DumpFileHelper?
    var foregroundAppHelper: ForegroundAppHelper?
    
    let helperBundleName = "com.spacetimi.AutoLauncher"
    
    @IBOutlet var statusMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "PFH"
        statusItem?.button?.image = NSImage(named: "clock")
        statusItem?.menu = statusMenu
        
        self.dumpFileHelper = DumpFileHelper()
        self.foregroundAppHelper = ForegroundAppHelper(dumpFileHelper: self.dumpFileHelper!, interval: 15)
        self.foregroundAppHelper?.StartLoop()
        
        // Register for auto launch
        SMLoginItemSetEnabled(helperBundleName as CFString, true)
    }

    @IBAction func onPauseClicked(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.Pause()
    }
        
    @IBAction func onResumeClicked(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.Resume()
    }
    
    @IBAction func onQuitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

