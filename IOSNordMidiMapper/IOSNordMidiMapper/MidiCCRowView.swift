//
//  MidiCCRowView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 09.06.22.
//

import SwiftUI

struct MidiCCRowView: View , Identifiable{
    var id: String
    let name: String;
    let cc: String;
    
    var body: some View {
        HStack{
            Text(name)
            Spacer()
            Text(cc)
        }
        .padding(.horizontal)
    }
    
    init(row: String){
        self.id = UUID().uuidString
        let index: Int = row.lastIndex(of: " ");
        self.name = row.substring(fromIndex: 0, toIndex: index);
        self.cc = row.substring(fromIndex: (index+1), toIndex: row.length())
    }
}

struct MidiCCRowView_Previews: PreviewProvider {
    static var previews: some View {
        MidiCCRowView(row: "DrawbarUpper 1 17")
    }
}
