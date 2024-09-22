//
//  CameraAddView.swift
//  Analogger
//
//  Created by Ben Pirt on 17/09/2024.
//

import SwiftUI

struct FilmRollAddView : View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var name = ""
    @State private var camera: Camera? = nil
    @State private var lens: Lens? = nil
    @State private var filmStock: FilmStock? = nil

    @StateObject private var cameraDataSource = CoreDataSource<Camera>()
        .sortKeys(sortKey1: "make", sortKey2: "model")

    @StateObject private var lensDataSource = CoreDataSource<Lens>()
        .sortKeys(sortKey1: "make", sortKey2: "model")

    @StateObject private var filmStockDataSource = CoreDataSource<FilmStock>()
        .sortKeys(sortKey1: "make", sortKey2: "type")
    
    var body: some View {
        Form {
            VStack {
                HStack {
                    Text("Name: ").foregroundColor(.gray)
                    Spacer()
                }

                TextField("Enter name of film roll", text: self.$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Spacer()

                Picker("Camera", selection: self.$camera) {
                    Text("Select camera").tag(Optional<Camera>(nil))

                    ForEach(self.cameraDataSource.objects) { camera in
                        Text("\(camera.make) \(camera.model)").tag(Optional(camera))
                    }
                }

                Spacer()

                Picker("Lens", selection: self.$lens) {
                    Text("Select lens").tag(Optional<Lens>(nil))

                    ForEach(self.lensDataSource.objects) { lens in
                        Text("\(lens.make) \(lens.model)").tag(Optional(lens))
                    }
                }

                Spacer()

                Picker("Film Stock", selection: self.$filmStock) {
                    Text("Select film stock").tag(Optional<FilmStock>(nil))

                    ForEach(self.filmStockDataSource.objects) { filmStock in
                        Text("\(filmStock.make) \(filmStock.type)").tag(Optional(filmStock))
                    }
                }
            }
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
        _ = FilmRoll.createFilmRoll(name: self.name, camera: self.camera!, filmStock: self.filmStock!, lens: self.lens)
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        return !self.name.isEmpty && self.camera != nil && self.filmStock != nil
    }
}
