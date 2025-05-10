//
//  SettingsView.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 9/11/21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("networkEnabled") var networkEnabled = false

    // TODO:
    // - IP address
    // - Board size
    // - Multicolor (Flipdot vs LEDs)

    var body: some View {
        Group {
            Toggle("Enable network", isOn: $networkEnabled)
        }
        .frame(width: 300, alignment: .center)
        .padding()
        .onChange(of: networkEnabled) { _ in
            NotificationCenter.default.post(name: Notification.Name(Notifications.networkChanged), object: nil)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
