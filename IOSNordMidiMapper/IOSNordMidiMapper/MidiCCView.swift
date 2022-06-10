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
                    Text(line);
                }
            }.navigationTitle("MidiCC")
        }
    }
}



struct MidiCCView_Previews: PreviewProvider {
    static var previews: some View {
        let m = NordStage3Node();
        MidiCCView(vModel: VModel( device: m))
    }
}
