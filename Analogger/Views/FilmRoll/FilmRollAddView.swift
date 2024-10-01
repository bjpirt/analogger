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
    @State private var cameraAsa: Int16 = 100
    @State private var useFilmAsa: Bool = true

    @StateObject private var cameraDataSource = CoreDataSource<Camera>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "model", ascending: true)])

    @StateObject private var lensDataSource = CoreDataSource<Lens>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "model", ascending: true)])

    @StateObject private var filmStockDataSource = CoreDataSource<FilmStock>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "type", ascending: true)])
    
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

                VStack {
                    VStack(alignment: .leading) {
                        Toggle("Use film ASA", isOn: self.$useFilmAsa)
                    }
                    if !self.useFilmAsa {
                        HStack {
                            Text("Camera film speed (ASA):").foregroundColor(.gray)
                            Spacer()
                        }
                        TextField("Enter camera film speed", value: self.$cameraAsa, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
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
        self.cameraAsa = self.useFilmAsa ? self.filmStock!.asa : self.cameraAsa
        _ = FilmRoll.createFilmRoll(name: self.name, camera: self.camera!, filmStock: self.filmStock!, lens: self.lens, cameraAsa: self.cameraAsa)
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        return !self.name.isEmpty && self.camera != nil && self.filmStock != nil
    }
}
