//
//  FilmShotView.swift
//  Analogger
//
//  Created by Ben Pirt on 23/09/2024.
//

import SwiftUI

struct FilmShotView : View {

    @State var filmShot: FilmShot

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
                Section(header: Text("Film shot detail")){
                    VStack(alignment: .leading) {
                        Text("Created")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(dateFormatter.string(from: self.filmShot.timestamp))
                    }
                    VStack(alignment: .leading) {
                        Text("Latitude")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(self.filmShot.lat)")
                    }
                    VStack(alignment: .leading) {
                        Text("Longitude")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(self.filmShot.lon)")
                    }
                    Picker("Camera", selection: self.$filmShot.camera) {
                        ForEach(self.cameraDataSource.objects) { camera in
                            Text("\(camera.make) \(camera.model)").tag(camera)
                        }
                    }
                    Picker("Lens", selection: self.$filmShot.lens) {
                        Text("Select lens").tag(Optional<Lens>(nil))

                        ForEach(self.lensDataSource.objects) { lens in
                            Text("\(lens.make) \(lens.model)").tag(Optional(lens))
                        }
                    }
                }

                Section(){
                    Button(
                        role: .destructive,
                        action: { self.deleteAction() },
                        label: { Text("Delete Film Shot").frame(maxWidth: .infinity) }
                    )
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
        }
        .navigationBarTitle(Text("Film shot details"), displayMode: .large)
        .onDisappear(perform: {self.saveAction()})
    }

    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }

    func saveAction() {
        self.filmShot.save()
        self.cancelAction()
    }

    func deleteAction() {
        self.filmShot.delete()
        self.cancelAction()
    }
}
