//
//  FilmStockAddView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmStockAddView : View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var textMake: String = ""
    @State private var textType: String = ""
    @State private var intAsa: Int16 = 100
    
    var body: some View {
        
        Form {
            
            FilmStockFormView(textMake: self.$textMake, textType: self.$textType, intAsa: self.$intAsa)
        }
        .navigationBarTitle(Text("Add Film Stock"), displayMode: .large)
        .navigationBarItems(
            trailing: Button(action:{ self.saveAction() }) { Text("Save") }.disabled(!self.dirty())
        )
    }
    
    func cancelAction() {
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        
        _ = FilmStock.createFilmStock(make: self.textMake, type: self.textType, asa: self.intAsa)
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        
        return !self.textMake.isEmpty && !self.textType.isEmpty
    }
}
