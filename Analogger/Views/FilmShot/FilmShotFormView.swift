//
//  FilmShotView.swift
//  Analogger
//
//  Created by Ben Pirt on 23/09/2024.
//

import SwiftUI

struct FilmShotFormView : View {

    @Binding var camera: Camera
    @Binding var lens: Lens?
    @Binding var fstop: String?
    @Binding var shutterSpeed: String?
    @Binding var evCompensation: String

    @StateObject private var cameraDataSource = CoreDataSource<Camera>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "model", ascending: true)])
    @StateObject private var lensDataSource = CoreDataSource<Lens>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "model", ascending: true)])
    @StateObject private var filmStockDataSource = CoreDataSource<FilmStock>()
        .sortKeys(sortKeys: [(key: "make", ascending: true), (key: "type", ascending: true)])
    
    private let fstops = ["f/1.4", "f/1.8", "f/2", "f/2.8", "f/4", "f/5.6", "f/8", "f/11", "f/16", "f/22"]
    private let shutterSpeeds = ["1/4000s", "1/2000s", "1/1000s", "1/500s", "1/250s", "1/125s", "1/60s", "1/30s", "1/15s", "1/8s", "1/4s", "1/2s", "1s"]
    private let evCompensations = ["+3", "+2 2/3", "+2 1/3", "+2", "+1 2/3", "+1 1/3", "+1", "+2/3", "+1/3", "None", "-1/3", "-2/3", "-1", "-1 1/3", "-1 2/3", "-2", "-2 1/3", "-2 2/3", "-3"]

    var body: some View {
                Section(header: Text("Film shot detail")){
                    Picker("Camera", selection: self.$camera) {
                        ForEach(self.cameraDataSource.objects) { camera in
                            Text("\(camera.make) \(camera.model)").tag(camera)
                        }
                    }
                    Picker("Lens", selection: self.$lens) {
                        Text("Select lens").tag(Optional<Lens>(nil))
                        ForEach(self.lensDataSource.objects) { lens in
                            Text("\(lens.make) \(lens.model)").tag(Optional(lens))
                        }
                    }
                    Picker("F Stop", selection: self.$fstop) {
                        Text("None selected").tag(Optional<String>(nil))
                        ForEach(self.fstops, id: \.hashValue) { fstop in
                            Text(fstop).tag(Optional(fstop))
                        }
                    }
                    Picker("Shutter Speed", selection: self.$shutterSpeed) {
                        Text("None selected").tag(Optional<String>(nil))
                        ForEach(self.shutterSpeeds, id: \.hashValue) { speed in
                            Text(speed).tag(Optional(speed))
                        }
                    }
                    Picker("EV Compensation", selection: self.$evCompensation) {
                        ForEach(self.evCompensations, id: \.hashValue) { ev in
                            Text(ev).tag(ev)
                        }
                    }
        }
    }
}
