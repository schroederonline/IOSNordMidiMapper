//
//  MidiCCView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 08.06.22.
//

import SwiftUI

struct MidiCCView: View {
    private var vModel: VModel;
    private var names: [String] = []
    @State private var searchText = ""
    
    init(vModel: VModel){
        self.vModel = vModel;
        self.names = vModel.midicc;
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(searchResults, id: \.self) { line in
                    MidiCCRowView(row: line)
                }
            }
            .navigationTitle("MIDI Controller")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.uppercased().contains(searchText.uppercased()) }
        }
    }
}



struct MidiCCView_Previews: PreviewProvider {
    static var previews: some View {
        MidiCCView(vModel: VModel( device: NordStage3Node()))
    }
}
