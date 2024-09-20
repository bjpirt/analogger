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

    @State private var draftFilmRoll: DraftFilmRoll

    init(filmRoll: FilmRoll){
        self.filmRoll = filmRoll
        self.draftFilmRoll = DraftFilmRoll(
            name: filmRoll.name,
            filmStock: filmRoll.filmStock,
            camera: filmRoll.camera,
            lens: filmRoll.lens
        )
    }
    
    var body: some View {
        VStack {
            Form {
                FilmRollFormView(filmRoll: self.$draftFilmRoll)
            }
        }
        .onDisappear(perform: {self.saveAction()})            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
        .navigationBarTitle(Text("Edit Film Roll"), displayMode: .automatic)
        .navigationBarItems(trailing: Button(action:{ self.cancelAction() }) { Text("Cancel") })
    }
    
    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        self.filmRoll.updateFromDraft(draftFilmRoll: self.draftFilmRoll)
        self.cancelAction()
    }
}

