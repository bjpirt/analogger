//
//  FilmRollEditView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollEditView : View {
    
    var filmRoll: FilmRoll
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var textName: String = ""
    
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
                    FilmRollFormView(textName: self.$textName)
                }
            }
                
            
        }
        .onAppear(perform: { self.onAppear() })
        .onDisappear(perform: {self.saveAction()})            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
        .navigationBarTitle(Text("Edit Film Roll Details"), displayMode: .automatic)
        .navigationBarItems(trailing: Button(action:{ self.cancelAction() }) { Text("Cancel") })
    }
    
    func onAppear() {
        self.textName = self.filmRoll.name
    }
    
    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        self.filmRoll.update(name: self.textName)
        self.cancelAction()
    }
    
    func deleteAction() {
        self.filmRoll.delete()
        self.cancelAction()
    }
}

