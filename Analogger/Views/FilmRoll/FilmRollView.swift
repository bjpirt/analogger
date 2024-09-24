//
//  FilmRollEditView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollView : View {
    
    @State var filmRoll: FilmRoll

    @StateObject private var cameraDataSource = CoreDataSource<Camera>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "model", ascending: true)])
    @StateObject private var lensDataSource = CoreDataSource<Lens>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "model", ascending: true)])
    @StateObject private var filmStockDataSource = CoreDataSource<FilmStock>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "type", ascending: true)])
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack {
            List {
                Section(header: Text("Film roll detail")){
                    VStack(alignment: .leading) {
                        Text("Name")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Enter name of film roll", text: self.$filmRoll.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Toggle("Complete", isOn: self.$filmRoll.complete)
                    }
                    VStack(alignment: .leading) {
                        Text("Created")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(dateFormatter.string(from: self.filmRoll.created))
                    }
                    Picker("Camera", selection: self.$filmRoll.camera) {
                        Text("Select camera").tag(Optional<Camera>(nil))

                        ForEach(self.cameraDataSource.objects) { camera in
                            Text("\(camera.make) \(camera.model)").tag(Optional(camera))
                        }
                    }
                    Picker("Lens", selection: self.$filmRoll.lens) {
                        Text("Select lens").tag(Optional<Lens>(nil))

                        ForEach(self.lensDataSource.objects) { lens in
                            Text("\(lens.make) \(lens.model)").tag(Optional(lens))
                        }
                    }
                    Picker("Film Stock", selection: self.$filmRoll.filmStock) {
                        Text("Select film stock").tag(Optional<FilmStock>(nil))

                        ForEach(self.filmStockDataSource.objects) { filmStock in
                            Text("\(filmStock.make) \(filmStock.type)").tag(Optional(filmStock))
                        }
                    }
                }

                if self.filmRoll.filmShots != nil {
                    Section(header: Text("Shots")){
                        let shots = self.filmRoll.filmShots?.sortedArray(
                            using: [NSSortDescriptor(key: "timestamp", ascending: true)]) as? [FilmShot] ?? []
                        ForEach(0..<shots.count, id: \.self) { filmShotIndex in
                            NavigationLink(destination: FilmShotView(filmShot: shots[filmShotIndex])) {
                                Text("\(filmShotIndex + 1) - \(dateFormatter.string(from: shots[filmShotIndex].timestamp))")
                            }
                        }
                    }
                }
                Section(){
                    Button(
                        role: .destructive,
                        action: { self.deleteAction() },
                        label: { Text("Delete Film Roll").frame(maxWidth: .infinity) }
                    )
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
        }
        .navigationBarTitle(Text("Film roll details"), displayMode: .large)
        .onDisappear(perform: {self.saveAction()})
    }

    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }

    func saveAction() {
        self.filmRoll.save()
        self.cancelAction()
    }

    func deleteAction() {
        self.filmRoll.delete()
        self.cancelAction()
    }
}

