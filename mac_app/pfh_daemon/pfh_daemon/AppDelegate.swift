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
    
    @IBOutlet var statusMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "PFH"
        statusItem?.menu = statusMenu
        
        let date = Date().addingTimeInterval(5)
        let timer = Timer(fireAt: date, interval: 5, target: self, selector: #selector(runCode), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
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
    
    @objc func runCode() {
        let sessionDict = CGSessionCopyCurrentDictionary() as? [NSString: Any]
        let locked = sessionDict?["CGSSessionScreenIsLocked"] ?? false
        if locked as! Bool {
            print("locked")
        } else {
            print("unlocked")
        }
        
        getForegroundAppDetailsViaAppleScript()
    }

    func getForegroundAppDetailsViaAppleScript() {
        let source = """
        tell application "System Events"
            set foreground_app to first application process whose frontmost is true
        end tell

        tell foreground_app
            if count of windows > 0 then
               set foreground_app_name to name of foreground_app
               set title_bar_contents to name of front window

               return (foreground_app_name & "##" & title_bar_contents)
            end if
        end tell
        return ""
        """

        let script = NSAppleScript(source: source)!
        var error: NSDictionary? = nil
        let scriptOutput = script.executeAndReturnError(&error).stringValue

        print(scriptOutput ?? "nil")
        if error != nil {
            print(error ?? "error: nil")
        }

        // script.executeAndReturnError(&error)
    }
}

