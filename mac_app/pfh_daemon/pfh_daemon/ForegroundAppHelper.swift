//
//  ForegroundAppHelper.swift
//  pfh_daemon
//
//  Created by Avi Krishnan on 6/3/20.
//  Copyright © 2020 spacetimi. All rights reserved.
//

import Foundation

class ForegroundAppHelper {
    
    var _dumpFileHelper: DumpFileHelper
    var _isPaused: Bool
    var _interval: TimeInterval
    
    init(dumpFileHelper: DumpFileHelper, interval: TimeInterval) {
        self._dumpFileHelper = dumpFileHelper
        self._isPaused = false
        self._interval = interval
    }
    
    func StartLoop() {
        let date = Date().addingTimeInterval(self._interval)
        let timer = Timer(fireAt: date, interval: self._interval, target: self, selector: #selector(process), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        
    }
    
    func Pause() {
        self._isPaused = true
    }
    
    func Resume() {
        self._isPaused = false
    }
    
    /// Private ////////////////////////////////////////////////////////////////////

    @objc func process() {
        
        if !self._isPaused &&
           !self.isScreenLocked() {
            
            self.getForegroundAppDetails()
        }
    }
    
    func isScreenLocked() -> Bool {
        let sessionDict = CGSessionCopyCurrentDictionary() as? [NSString: Any]
        let locked = sessionDict?["CGSSessionScreenIsLocked"] ?? false
        return locked as! Bool
    }
    
    func getForegroundAppDetails() {
       let source = """
        tell application "System Events"
            set foreground_app to first application process whose frontmost is true
        end tell

        tell foreground_app
            if count of windows > 0 then
               set foreground_app_name to name of foreground_app
               set title_bar_contents to name of front window

               return (foreground_app_name & "####" & title_bar_contents)
            end if
        end tell
        return ""
        """

        let script = NSAppleScript(source: source)!
        var error: NSDictionary? = nil
        let scriptOutput = (script.executeAndReturnError(&error).stringValue ?? "") + "\n"

        if error != nil {
            print(error ?? "error: nil")
        }
        
        self._dumpFileHelper.Dump(s: scriptOutput)
    }
}
