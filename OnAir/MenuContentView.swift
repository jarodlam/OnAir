//
//  MenuContentView.swift
//  OnAir
//
//  Created by Jarod on 17/2/2023.
//

import SwiftUI

struct MenuContentView: View {
    @StateObject var micMuteModel: MicMuteModel
    
    var body: some View {
        switch micMuteModel.status {
        case .unknown:
            Text("No meeting detected")
        case .muted:
            Text("Muted")
        case .unmuted:
            Text("Unmuted")
        }
        
        Divider()
        
        Button("About") {
            NSApp.orderFrontStandardAboutPanel()
            // Because this app has no UI, need to force the About window to the foreground
            // https://stackoverflow.com/a/2706699
            NSApp.activate(ignoringOtherApps: true)
        }
        
        Button("Quit On Air") {
            NSApp.terminate(nil)
        }
        .keyboardShortcut("Q")
    }
}

struct MenuContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
