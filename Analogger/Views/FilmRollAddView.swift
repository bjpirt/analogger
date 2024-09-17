//
//  CameraAddView.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//

import SwiftUI

struct FilmRollAddView : View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var textName: String = ""
    
    var body: some View {
        Form {
            
            FilmRollFormView(textName: self.$textName)
        }
        .navigationBarTitle(Text("Add Film Roll"), displayMode: .large)
        .navigationBarItems(
            trailing: Button(action:{ self.saveAction() }) { Text("Save") }.disabled(!self.dirty())
        )
    }
    
    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        _ = FilmRoll.createFilmRoll(name: self.textName)
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        return !self.textName.isEmpty
    }
}
