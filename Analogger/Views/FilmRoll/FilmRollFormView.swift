//
//  CameraFormView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollFormView: View {

    @Binding var filmRoll: DraftFilmRoll
    
    @StateObject private var cameraDataSource = CoreDataSource<Camera>()
        .sortKeys(sortKey1: "make", sortKey2: "model")

    @StateObject private var lensDataSource = CoreDataSource<Lens>()
        .sortKeys(sortKey1: "make", sortKey2: "model")

    @StateObject private var filmStockDataSource = CoreDataSource<FilmStock>()
        .sortKeys(sortKey1: "make", sortKey2: "type")

    var body: some View {
        VStack {
            HStack {
                Text("Name: ").foregroundColor(.gray)
                Spacer()
            }

            TextField("Enter name of film roll", text: self.$filmRoll.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Spacer()

            Picker("Camera", selection: self.$filmRoll.camera) {
                Text("Select camera").tag(Optional<Camera>(nil))

                ForEach(self.cameraDataSource.objects) { camera in
                    Text("\(camera.make) \(camera.model)").tag(Optional(camera))
                }
            }

            Spacer()

            Picker("Lens", selection: self.$filmRoll.lens) {
                Text("Select lens").tag(Optional<Lens>(nil))

                ForEach(self.lensDataSource.objects) { lens in
                    Text("\(lens.make) \(lens.model)").tag(Optional(lens))
                }
            }

            Spacer()

            Picker("Film Stock", selection: self.$filmRoll.filmStock) {
                Text("Select film stock").tag(Optional<FilmStock>(nil))

                ForEach(self.filmStockDataSource.objects) { filmStock in
                    Text("\(filmStock.make) \(filmStock.type)").tag(Optional(filmStock))
                }
            }
        }
    }
}
