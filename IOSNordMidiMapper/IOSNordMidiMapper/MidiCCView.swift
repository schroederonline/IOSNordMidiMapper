//
//  MidiCCView.swift
//  IOSNordMidiMapper
//
//  Created by Marcel Schröder on 08.06.22.
//

import SwiftUI

struct MidiCCView: View {
    let ALL:  String  = "All";
    let GENERAL: String = "General";
    private var vModel: VModel;
    private var names: [String] = []
    private var choices: [String] = []
    @State private var searchText = ""
    @State var pickerIndex: Int = 0;
    
    init(vModel: VModel){
        self.vModel = vModel;
        self.names = vModel.midicc;
        self.choices = createFilterChoices();
    }
    
    var body: some View {
        VStack{
            if UIDevice.current.userInterfaceIdiom != .phone {
                iPadTitle
            }
            filterPicker
            List{
                ForEach(searchResults, id: \.self) { line in
                    MidiCCRowView(row: line)
                }
            }
            .navigationTitle(getNavigationTitle())
            .searchable(text: $searchText
//                            , placement: .navigationBarDrawer(displayMode: .always)
                )
            Spacer()
       }
    }
    
    /**
     * in der iPad Ansicht wird ein anderer Titel angezeigt
     */
    var iPadTitle: some View{
        HStack{
            VStack{
                Text("MIDI Controller").foregroundColor(Color.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    /**
     * Filter Button mit Icon und Filtername über die ganze breite anglickbar
     */
    var pickerLabel: some View {
        ZStack{
            HStack {
                let c = choices[pickerIndex];
                Spacer()
                Text(c).tag(pickerIndex)
                Spacer()
            }
            HStack {
                Image(systemName: "tag").foregroundColor(Color.gray)
                Spacer()
            }
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
        .stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal)
    }

    /**
     * Auswahlt der Filter
     */
    var filterPicker : some View{
        Menu {
            Picker( selection: $pickerIndex, label: EmptyView()) {
                ForEach(0 ..< choices.count) {i in
                    let tagName = choices[i];
                    Text(tagName).tag(i)
                }
            }
        } label: {
            pickerLabel
        }
    }
    
    func getNavigationTitle() -> String {
        if UIDevice.current.userInterfaceIdiom != .phone {
            return vModel.device.getName()
        }else{
            return "MIDI Controller"
        }
    }
    
    var searchResults: [String] {
        var result = names;
        if(pickerIndex != 0){
            result = result.filter{ $0.starts(with: choices[pickerIndex])}
        }
        if !searchText.isEmpty {
            result =  result.filter { $0.uppercased().contains(searchText.uppercased()) }
        }
        return result;
    }
    
    private func createFilterChoices() -> [String] {
        var result: [String] = [];
        result.append(ALL)
//        FIXME General implementieren
//        result.append(GENERAL)
        let values:[String] = self.names;
        values.forEach { value in
            let s = value.trim();
            let split: Int = s.indexOf(needle: " ");
            if (split > 0) {
                let cutString: String = s.substring(fromIndex: 0, toIndex: split);
                if (!result.contains(cutString)) {
                    let count = countElementsStartsWith(needle: cutString);
                    if (count > 2) {
                        result.append(cutString);
                    }
                }
            }
        }
        return result;
    }
    
    func countElementsStartsWith(needle: String) -> Int{
        var result = 0;
        self.names.forEach { value in
            if(value.starts(with: needle)){
                result += 1;
            }
        }
        return result;
    }
}

struct MidiCCView_Previews: PreviewProvider {
    static var previews: some View {
        MidiCCView(vModel: VModel( device: NordStage3Node()))
    }
}
