//
//  DeviceView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 27.05.22.
//

import SwiftUI

struct DeviceView: View {
    
    var device: GenericDeviceModel;
    
    init(device: GenericDeviceModel){
        self.device = device;
    }
    
    var body: some View {
           VStack {
              

               VStack(alignment: .leading) {
                   Text(self.device.getName())
                       .font(.title)

                   Text("Program Calculator").foregroundColor(Color.gray)
                   Text("")
                   Text("")
                   HStack(){
                       TextField("A:01", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/) .font(.title2)
                       Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                           Text("Program Mode").tag(1)
                           Text("Song Mode").tag(2)
                           Text("Live Mode").tag(3)
                       }.font(.title2)
                   }
                   Text("")
                   Text("")
                   Divider()
               }.padding()
               
               
               VStack(alignment: .leading) {
                   
                   Text("Midi (1-128)" ).foregroundColor(Color.gray)
                   Text("")
                   Text("")
                   
                   HStack(){
                       TextField("1", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/) .font(.title2)
                       Text("Bank").font(.title2)
                   }
                   Text("")
                   Text("")
                   
                   HStack(){
                       TextField("1", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/) .font(.title2)
                       Text("SubBank").font(.title2)
                   }
                   Text("")
                   Text("")
                   HStack(){
                       TextField("1", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/) .font(.title2)
                       Text("Program").font(.title2)
                   }
                   
               }.padding()
             
               

               Spacer()
           }
       }
}

struct DeviceView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceView(device :NordStage3Node())
    }
}
