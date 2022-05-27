//
//  DeviceView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import SwiftUI

struct DeviceView: View {
    
    var deviceName: String;
    
    init(name: String){
        self.deviceName = name;
    }
    
    var body: some View {
           VStack {
              

               VStack(alignment: .leading) {
                   Text(self.deviceName)
                       .font(.title)

                   Divider()

                   Text("Program Calculator")
                       .font(.title2)
                   Text("Descriptive text goes here.")
               }
               .padding()

               Spacer()
           }
       }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(name: "A Device Name")
    }
}
