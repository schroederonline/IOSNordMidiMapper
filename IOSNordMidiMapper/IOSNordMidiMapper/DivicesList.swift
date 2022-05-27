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
    let devices = ["Nord Stage 3", "Nord Stage 2", "Nord Lead 4"]
    

    var body: some View {
        
        NavigationView {
            List {
                ForEach(0 ..< devices.count) {
                    let deviceName: String = self.devices[$0]
                    NavigationLink(destination: DeviceView(name: deviceName)) {
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

