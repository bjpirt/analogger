//
//  FilmShotView.swift
//  Analogger
//
//  Created by Ben Pirt on 23/09/2024.
//

import SwiftUI

struct FilmShotAddView : View {
    
    @Environment(\.dismiss) var dismiss
    
    private let actions: AnaloggerActions = .shared
    
    let filmRoll: FilmRoll

    @State var camera: Camera
    @State var lens: Lens? = nil
    @State var fstop: String? = nil
    @State var shutterSpeed: String?
    @State var evCompensation: String = "None"
    
    init(filmRoll: FilmRoll, camera: Camera) {
        self.filmRoll = filmRoll
        self.camera = filmRoll.camera
        self.lens = filmRoll.lens
    }

    var body: some View {
                List {
                    FilmShotFormView(camera: self.$camera, lens: self.$lens, fstop: self.$fstop, shutterSpeed: self.$shutterSpeed, evCompensation: self.$evCompensation)
                    Section(){
                        Button(
                            action: { self.saveAction() },
                            label: { Text("Save").frame(maxWidth: .infinity) }
                        )
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }
                    Section(){
                        Button(
                            role: .cancel,
                            action: { dismiss() },
                            label: { Text("Cancel").frame(maxWidth: .infinity) }
                        )
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                }
        
            
        .navigationBarTitle(Text("New film shot"), displayMode: .large)
    }

    func saveAction() {
        print("Saving sheet")
        let filmShot = actions.logShot(filmRoll: self.filmRoll)
        filmShot.camera = self.camera
        filmShot.lens = self.lens
        filmShot.fstop = self.fstop
        filmShot.shutterSpeed = self.shutterSpeed
        filmShot.evCompensation = self.evCompensation
        filmShot.save()
        dismiss()
    }
}
