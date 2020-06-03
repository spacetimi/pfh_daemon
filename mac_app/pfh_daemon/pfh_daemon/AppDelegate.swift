//
//  AppDelegate.swift
//  pfh_daemon
//
//  Created by Avi Krishnan on 5/29/20.
//  Copyright © 2020 spacetimi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    var dumpFileHelper: DumpFileHelper?
    var foregroundAppHelper: ForegroundAppHelper?
    
    @IBOutlet var statusMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "PFH"
        statusItem?.menu = statusMenu
        
        self.dumpFileHelper = DumpFileHelper()
        self.foregroundAppHelper = ForegroundAppHelper(dumpFileHelper: self.dumpFileHelper!, interval: 5)
        self.foregroundAppHelper?.StartLoop()
    }

    @IBAction func onPauseClicked(_ sender: NSMenuItem) {
        print("on pause clicked")
    }
        
    @IBAction func onResumeClicked(_ sender: NSMenuItem) {
    }
    
    @IBAction func onQuitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

