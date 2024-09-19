//
//  CameraAddView.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//

import SwiftUI

struct FilmRollAddView : View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var filmRoll = DraftFilmRoll(name: "")
    
    var body: some View {
        Form {
            FilmRollFormView(filmRoll: self.$filmRoll)
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
        let newRoll = FilmRoll.createFilmRoll(name: self.filmRoll.name)
        if self.filmRoll.camera != nil {
            newRoll.camera = self.filmRoll.camera
        }
        newRoll.save()
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        return !self.filmRoll.name.isEmpty
    }
}
