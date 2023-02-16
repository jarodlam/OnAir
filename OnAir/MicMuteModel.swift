//
//  MicMuteStatus.swift
//  OnAir
//
//  Created by Lam, Jarod on 14/2/2023.
//

import Foundation

enum MuteStatus: Int {
    case unknown = 0
    case muted = 1
    case unmuted = 2
}

class MicMuteModel: ObservableObject {
    @Published var status: MuteStatus = .unknown

    init() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 5) {
                let s = self.getMuteStatus()
                DispatchQueue.main.async {
                    self.status = s
                }
            }
        }
    }
    
    func getMuteStatus() -> MuteStatus {
        let script = NSAppleScript(source: """
        tell application "System Events"
            if not (process "zoom.us" exists) then return 0
            tell process "zoom.us"
                repeat with theMenuBar in menu bars
                    if not (menu "Meeting" of menu bar 1 exists) then exit
                    if menu item "Unmute Audio" of menu "Meeting" of menu bar 1 exists then return 1
                    if menu item "Mute Audio" of menu "Meeting" of menu bar 1 exists then return 2
                end repeat
            end tell
        end tell
        return 0
        """)!
        
        var error: NSDictionary?
        let result: NSAppleEventDescriptor = script.executeAndReturnError(&error)
        
        if let error = error {
            print("AppleScript error: \(error)")
            return .unknown
        } else {
            return MuteStatus(rawValue: Int(result.int32Value)) ?? .unknown
        }
    }
}
