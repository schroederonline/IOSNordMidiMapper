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
        }.navigationViewStyle(StackNavigationViewStyle())//Damit beim iPad keine leere Seite am Anfang erscheint
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesListView()
            
    }
}
