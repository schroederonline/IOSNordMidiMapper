//
//  ContentView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 10.04.21.
//

import SwiftUI


struct DeviceSelection: View {
    
    let deviceNodeModelItems = DeviceNodeModelItems.init();
    
    var body: some View {
        NavigationView {
            HStack{
        
            List {
                let deviceModels = deviceNodeModelItems.getAvailableDeviceModels();
                ForEach(0 ..< deviceModels.count) {
                    let device = deviceModels[$0];
                    let deviceName = device.getName();
                    NavigationLink(destination: DeviceView( vModel: VModel( device: device))) {
                        Text(deviceName)
                    }.navigationTitle("Nord Devices")
                        .navigationBarTitleDisplayMode(.inline)
//                    .navigationBarTitle("Devices")
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

