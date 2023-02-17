//
//  MenuBarIconView.swift
//  OnAir
//
//  Created by Jarod on 16/2/2023.
//

import SwiftUI

struct MenuLabelIconView: View {
    var symbolName: String
    var color: NSColor
    
    var body: some View {
        // Using NSImage because colouring the SwiftUI Image doesn't seem to work for menu bar icons
        let configuration = NSImage.SymbolConfiguration(paletteColors: [color])
        let image = NSImage(systemSymbolName: symbolName, accessibilityDescription: nil)
        let colouredImage = image?.withSymbolConfiguration(configuration)
        Image(nsImage: colouredImage!)
    }
}

struct MenuLabelView: View {
    @StateObject var micMuteModel: MicMuteModel
    
    var body: some View {
        switch micMuteModel.status {
        case .unknown:
            MenuLabelIconView(symbolName: "mic", color: NSColor(.gray))
        case .muted:
            MenuLabelIconView(symbolName: "mic.slash", color: NSColor(.red))
        case .unmuted:
            MenuLabelIconView(symbolName: "mic.fill", color: NSColor(.green))
        }
    }
}

struct MenuLabelView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
