//
//  ContentView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 10.04.21.
//

import SwiftUI

struct DeviceNameView: View {
    
    var body: some View {
        Text("Midi Mapper for Nord Keyboards")
            .padding()
        
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail view")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: DetailView()) {
                Text("Show detail view")
            }
            .navigationBarTitle("Master view")
        }
    }
}

struct DeviceSelection: View {
    
    let deviceNodeModelItems = DeviceNodeModelItems.init();
    

    var body: some View {
        
        NavigationView {
            List {
                let deviceModels = deviceNodeModelItems.getAvailableDeviceModels();
                ForEach(0 ..< deviceModels.count) {
                    let device = deviceModels[$0];
                    let deviceName = device.getName();
                    NavigationLink(destination: DeviceView( vModel: VModel( device: device))) {
                        Text(deviceName).padding()
                    }
                    .navigationBarTitle("Devices")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       // ContentView()
        DeviceSelection()
    }
}

