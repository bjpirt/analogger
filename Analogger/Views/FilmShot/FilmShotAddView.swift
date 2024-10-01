//
//  FilmShotView.swift
//  Analogger
//
//  Created by Ben Pirt on 23/09/2024.
//

import SwiftUI

struct FilmShotAddView : View {
    
    private let actions: AnaloggerActions = .shared
    
    let filmRoll: FilmRoll

    @State var camera: Camera
    @State var lens: Lens? = nil
    @State var fstop: String? = nil
    @State var shutterSpeed: String?
    @State var evCompensation: String = "0"
    
    init(filmRoll: FilmRoll, camera: Camera) {
        self.filmRoll = filmRoll
        self.camera = filmRoll.camera
        self.lens = filmRoll.lens
    }

    var body: some View {
        Form{
            VStack {
                List {
                    FilmShotFormView(camera: self.$camera, lens: self.$lens, fstop: self.$fstop, shutterSpeed: self.$shutterSpeed, evCompensation: self.$evCompensation)
                }
            }
        }
        .navigationBarTitle(Text("New film shot"), displayMode: .large)
        .onDisappear(perform: {self.saveAction()})
    }

    func saveAction() {
        let filmShot = actions.logShot(filmRoll: self.filmRoll)
        filmShot.camera = self.camera
        filmShot.lens = self.lens
        filmShot.fstop = self.fstop
        filmShot.shutterSpeed = self.shutterSpeed
        filmShot.evCompensation = self.evCompensation
    }
}
