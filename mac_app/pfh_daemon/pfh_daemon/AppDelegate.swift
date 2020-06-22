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
    
    @IBAction func onPauseFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.PauseFor(timeInterval: 60 * 15)
    }
    
    @IBAction func onPauseFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.PauseFor(timeInterval: 60 * 30)
    }
    
    @IBAction func onPauseFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.PauseFor(timeInterval: 60 * 60)
    }
    
    @IBAction func onMarkProductiveFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "productive", timeInterval: 60 * 15)
    }
    
    @IBAction func onMarkProductiveFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "productive", timeInterval: 60 * 30)
    }
    
    @IBAction func onMarkProductiveFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "productive", timeInterval: 60 * 60)
    }
    
    @IBAction func onMarkOperationalOverheadFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "operational-overhead", timeInterval: 60 * 15)
    }
    
    @IBAction func onMarkOperationalOverheadFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "operational-overhead", timeInterval: 60 * 30)
    }
    
    @IBAction func onMarkOperationalOverheadFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "operational-overhead", timeInterval: 60 * 60)
    }
    
    @IBAction func onMarkUnproductiveFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "unproductive", timeInterval: 60 * 15)
    }
    
    @IBAction func onMarkUnproductiveFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "unproductive", timeInterval: 60 * 30)
    }
    
    @IBAction func onMarkUnproductiveFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatusFor(status: "unproductive", timeInterval: 60 * 60)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

