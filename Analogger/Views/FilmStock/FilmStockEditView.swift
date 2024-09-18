//
//  FilmStockEditView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmStockEditView : View {
    
    var filmStock: FilmStock
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var textMake: String = ""
    @State private var textType: String = ""
    @State private var intAsa: Int16 = 100
    
    var body: some View {
        
        VStack {
            Form {
                Section(footer: HStack {
                    Spacer()
                    Button(
                        role: .destructive,
                        action: { self.deleteAction() },
                        label: { Text("Delete").frame(maxWidth: .infinity) }
                    )
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }) {
                    FilmStockFormView(textMake: self.$textMake,
                                   textType: self.$textType,
                                      intAsa: self.$intAsa)
                }
            }
                
            
        }
        .onAppear(perform: { self.onAppear() })
        .onDisappear(perform: {self.saveAction()})            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
        .navigationBarTitle(Text("Edit Film Stock Details"), displayMode: .automatic)
        .navigationBarItems(trailing: Button(action:{ self.cancelAction() }) { Text("Cancel") })
    }
    
    func onAppear() {
        self.textMake = self.filmStock.make
        self.textType = self.filmStock.type
        self.intAsa = self.filmStock.asa
    }
    
    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        self.filmStock.update(make: self.textMake, type: self.textType, asa: self.intAsa)
        self.cancelAction()
    }
    
    func deleteAction() {
        
        self.filmStock.delete()
        self.cancelAction()
    }
}

