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
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.status = self.getMuteStatus()
        }
    }
    
    func getMuteStatus() -> MuteStatus {
        let script = NSAppleScript(source: """
            tell application "System Events"
                set zoomApp to first application process whose name contains "zoom.us"
                if not (zoomApp exists) then return 0
                
                tell process "zoom.us"
                    set meetingMenu to menu bar item "Meeting" of menu bar 1
                    if not (meetingMenu exists) then return 0
                    
                    set meetingMenuItems to menu items of meetingMenu
                    set unmuteMenuItem to item "Unmute Audio" of meetingMenuItems
                    set muteMenuItem to item "Mute Audio" of meetingMenuItems
                    
                    if unmuteMenuItem exists then return 1
                    if muteMenuItem exists then return 1
                    
                    return 0
                end tell
            end tell
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
