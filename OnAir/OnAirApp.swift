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

    var body: some Scene {
        Settings {
            EmptyView()
        }
        
        MenuBarExtra(
            content: {
                Text(String(micMuteModel.status.rawValue))
                
                Button(
                    action: {
                        NSApp.terminate(nil)
                    }
                ) {
                    Text("Quit")
                }
            },
            label: {
                Text("OnAir")
            }
        )
    }
}
