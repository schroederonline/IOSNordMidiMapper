//
//  ContentView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 10.04.21.
//

import SwiftUI

struct DevicesListView: View {
    let deviceModels: [GenericDeviceModel] = DeviceNodeModelItems().getAvailableDeviceModels();
    var body: some View {
        NavigationView {
            List {
                ForEach(deviceModels) { device in
                    let deviceName = device.getName();
                    NavigationLink(destination: DeviceView( vModel: VModel( device: device))) {
                        Text(deviceName)
                    }
                }
            }.navigationTitle("Nord Devices") // Listen Überschrift
//                .navigationBarTitleDisplayMode(.inline)
        }
        // Funtioniert nicht wenn auf dem nächten view wieder .navigationTitle getzt wird, da
        // dann wird der Link nur nch mit Back angezeit
//        .navigationTitle("Nord Devices") // für den Back Button auf dem nächsten View
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesListView()
    }
}

