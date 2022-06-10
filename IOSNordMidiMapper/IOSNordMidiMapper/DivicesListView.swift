//
//  ContentView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 10.04.21.
//

import SwiftUI


struct DeviceSelection: View {
    let deviceModels: [GenericDeviceModel] = DeviceNodeModelItems().getAvailableDeviceModels();
    var body: some View {
        NavigationView {
            HStack{
                List {
                    ForEach(deviceModels) { device in
                        let deviceName = device.getName();
                        NavigationLink(destination: DeviceView( vModel: VModel( device: device))) {
                            Text(deviceName)
                        }.navigationTitle("Nord Devices").navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSelection()
    }
}

