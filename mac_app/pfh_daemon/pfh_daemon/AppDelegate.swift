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
    
    var _temporaryTimer = Timer()
    
    @IBOutlet var statusMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "PFH"
        statusItem?.button?.image = NSImage(named: "clock-normal")
        statusItem?.menu = statusMenu
        
        self.dumpFileHelper = DumpFileHelper()
        self.foregroundAppHelper = ForegroundAppHelper(dumpFileHelper: self.dumpFileHelper!, interval: 15)
        self.foregroundAppHelper?.StartLoop()
        
        // Register for auto launch
        SMLoginItemSetEnabled(helperBundleName as CFString, true)
    }

    @IBAction func onPauseClicked(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.Pause()
        statusItem?.button?.image = NSImage(named: "clock-paused")
    }
        
    @IBAction func onResumeClicked(_ sender: NSMenuItem) {
        self.resumeNormalOperations()
    }
    
    @IBAction func onQuitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func onPauseFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.Pause()
        statusItem?.button?.image = NSImage(named: "clock-paused")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onPauseFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.Pause()
        statusItem?.button?.image = NSImage(named: "clock-paused")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 30, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onPauseFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.Pause()
        statusItem?.button?.image = NSImage(named: "clock-paused")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 60, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkProductiveFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "productive")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkProductiveFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "productive")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 30, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkProductiveFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "productive")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 60, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkOperationalOverheadFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "operational-overhead")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkOperationalOverheadFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "operational-overhead")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 30, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkOperationalOverheadFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "operational-overhead")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 60, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkUnproductiveFor15Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "unproductive")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkUnproductiveFor30Minutes(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "unproductive")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 30, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    @IBAction func onMarkUnproductiveFor1Hour(_ sender: NSMenuItem) {
        self.foregroundAppHelper?.MarkAsStatus(status: "unproductive")
        statusItem?.button?.image = NSImage(named: "clock-forced")
        
        _temporaryTimer.invalidate()
        _temporaryTimer = Timer.scheduledTimer(timeInterval: 60 * 60, target: self, selector: #selector(resumeNormalOperations), userInfo: nil, repeats: false)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func resumeNormalOperations() {
        self.foregroundAppHelper?.Resume()
        statusItem?.button?.image = NSImage(named: "clock-normal")
    }
}

