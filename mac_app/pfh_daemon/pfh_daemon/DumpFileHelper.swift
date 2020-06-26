//
//  FileHelper.swift
//  pfh_daemon
//
//  Created by Avi Krishnan on 6/3/20.
//  Copyright © 2020 spacetimi. All rights reserved.
//

import Foundation

class DumpFileHelper {
    
    var _dumpFileDirectory: NSURL?
    
    init() {
        self._dumpFileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
    }
    
    func Dump(s: String) {
        let dumpFileUrl = getCurrentDumpFileUrl()!

        if let fileUpdater = try? FileHandle(forUpdating: dumpFileUrl) {
            fileUpdater.seekToEndOfFile()
            fileUpdater.write(s.data(using: .utf8)!)
        } else {
            try! s.write(to: dumpFileUrl, atomically: true, encoding: String.Encoding.utf8)
        }
    }
    
    func getCurrentDumpFileUrl() -> URL? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dumpFileName = "day-" + dateFormatter.string(from: date) + ".dat"
        let dumpFileUrl = self._dumpFileDirectory!.appendingPathComponent(dumpFileName)

        return dumpFileUrl
    }
}
