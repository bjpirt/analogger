//
//  FilmRollEditView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollShowView : View {
    
    var filmRoll: FilmRoll
    
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
                        Text("Created")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(dateFormatter.string(from: self.filmRoll.created))
                    }
                    VStack(alignment: .leading) {
                        Text("Camera")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(self.filmRoll.camera != nil ? "\(self.filmRoll.camera!.make) \(self.filmRoll.camera!.model)" : "No camera selected")
                    }
                    VStack(alignment: .leading) {
                        Text("Lens")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(self.filmRoll.lens != nil ? "\(self.filmRoll.lens!.make) \(self.filmRoll.lens!.model)" : "No lens selected")
                    }
                    VStack(alignment: .leading) {
                        Text("Film Stock")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(self.filmRoll.filmStock != nil ? "\(self.filmRoll.filmStock!.make) \(self.filmRoll.filmStock!.type)" : "No film stock selected")
                    }
                }
                if self.filmRoll.filmShots != nil {
                    Section(header: Text("Shots")){
                        let shots = self.filmRoll.filmShots?.sortedArray(
                            using: [NSSortDescriptor(key: "timestamp", ascending: true)]) as? [FilmShot] ?? []
                        ForEach(0..<shots.count, id: \.self) { filmShotIndex in
                            Text("\(filmShotIndex + 1) - \(dateFormatter.string(from: shots[filmShotIndex].timestamp))")
                        }
                    }
                }
                Section(){
                    Button(
                        role: .destructive,
                        action: { self.deleteAction() },
                        label: { Text("Delete").frame(maxWidth: .infinity) }
                    )
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }         /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
        .navigationBarTitle(Text(self.filmRoll.name), displayMode: .automatic)
        .navigationBarItems(trailing: NavigationLink("Edit") {
            FilmRollEditView(filmRoll: self.filmRoll)
        })
    }

    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }

    func deleteAction() {
        self.filmRoll.delete()
        self.cancelAction()
    }
}
