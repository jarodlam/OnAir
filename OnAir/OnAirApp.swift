//
//  OnAirApp.swift
//  OnAir
//
//  Created by Lam, Jarod on 14/2/2023.
//

import SwiftUI

@main
struct OnAirApp: App {
    @StateObject var micMuteModel = MicMuteModel()
    @State var iconOpacity = 1.0
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }

    var body: some Scene {
        Settings {
            EmptyView()
        }
        
        MenuBarExtra(
            content: {
                switch micMuteModel.status {
                case .unknown:
                    Text("No meeting detected")
                case .muted:
                    Text("Muted")
                case .unmuted:
                    Text("Unmuted")
                }
                
                Button(
                    action: {
                        NSApp.terminate(nil)
                    }
                ) {
                    Text("Quit")
                }
            },
            label: {
                switch micMuteModel.status {
                case .unknown:
                    Text("·")
                case .muted:
                    Text("🔴")
                case .unmuted:
                    Text("🟢")
                }
            }
        )
    }
}
