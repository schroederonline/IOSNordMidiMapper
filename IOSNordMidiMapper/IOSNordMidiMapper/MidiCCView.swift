//
//  MidiCCView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 08.06.22.
//

import SwiftUI

struct MidiCCView: View {
    var vModel: VModel;
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vModel.midicc, id: \.self) { line in
                    let index = line.lastIndex(of: " ");
                    let name = line.substring(fromIndex: 0, toIndex: index);
                    let ccNumber = line.substring(fromIndex: index + 1, toIndex: line.length())
                    HStack{
                        Text(name)
                        Spacer()
                        Text(ccNumber)
                    }
                }
            }.navigationTitle("MIDI-Controls")
        }
    }
}



struct MidiCCView_Previews: PreviewProvider {
    static var previews: some View {
        MidiCCView(vModel: VModel( device: NordStage3Node()))
    }
}
