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
                    Text("\(camera.make!) \(camera.model!)").tag(Optional(camera))
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
}
