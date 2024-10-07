//
//  FilmShotView.swift
//  Analogger
//
//  Created by Ben Pirt on 23/09/2024.
//

import SwiftUI
import MapKit
import LocationPicker

struct FilmShotView : View {

    @Environment(\.managedObjectContext) private var viewContext

    @State var filmShot: FilmShot
    @State private var showLocationSheet = false
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)

    private let actions: AnaloggerActions = .shared

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
                        DatePicker("", selection: self.$filmShot.timestamp)
                            .labelsHidden()
                    }
                    VStack(alignment: .leading) {
                        Text("Location")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        if self.filmShot.lat == 0.0 && self.filmShot.lon == 0.0 {
                            Button("Select location") {
                                self.showLocationSheet.toggle()
                            }
                        }else{
                            let location = CLLocationCoordinate2D(
                                latitude: self.filmShot.lat,
                                longitude: self.filmShot.lon
                            )
                            let rect = MKMapRect(
                                origin: MKMapPoint(location),
                                size: MKMapSize(width: 1, height: 1)
                            )
                            Map(bounds: MapCameraBounds(centerCoordinateBounds: rect, minimumDistance: 20000, maximumDistance: 20000), interactionModes: []) {
                                Marker(coordinate: location, label: {})
                            }
                            .frame(height: 200)
                            .onTapGesture {
                                showLocationSheet = true
                            }
                        }
                    }
                }
                FilmShotFormView(camera: self.$filmShot.camera, lens: self.$filmShot.lens, fstop: self.$filmShot.fstop, shutterSpeed: self.$filmShot.shutterSpeed, evCompensation: self.$filmShot.evCompensation)
                
            }
        }
        .navigationBarTitle(Text("Film shot details"), displayMode: .large)
        .onDisappear(perform: {self.saveAction()})
        .sheet(isPresented: $showLocationSheet) {
            LocationPicker(instructions: "Tap to select location", coordinates: $coordinates, dismissOnSelection: true)
        }
        .onChange(of: self.coordinates, self.updateLocation)
    }

    func updateLocation() {
        self.filmShot.lat = self.coordinates.latitude
        self.filmShot.lon = self.coordinates.longitude
        self.filmShot.skipped = false
        actions.updateShotLocationDetails(filmShot: self.filmShot)
    }

    func saveAction() {
        self.filmShot.save()
    }
}
