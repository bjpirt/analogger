//
//  FilmShotView.swift
//  Analogger
//
//  Created by Ben Pirt on 23/09/2024.
//

import SwiftUI

struct FilmShotView : View {

    @Environment(\.managedObjectContext) private var viewContext

    @State var filmShot: FilmShot

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack {
            List {
                Section(header: Text("Metadata")){
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
                }
                FilmShotFormView(camera: self.$filmShot.camera, lens: self.$filmShot.lens, fstop: self.$filmShot.fstop, shutterSpeed: self.$filmShot.shutterSpeed, evCompensation: self.$filmShot.evCompensation)
                
            }
        }
        .navigationBarTitle(Text("Film shot details"), displayMode: .large)
        .onDisappear(perform: {self.saveAction()})
    }

    func saveAction() {
        self.filmShot.save()
    }
}
