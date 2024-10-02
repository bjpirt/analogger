//
//  CameraListCell.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollListCell: View {
    
    var filmRoll: FilmRoll
    
    @State private var showingSheet = false
    
    private let actions: AnaloggerActions = .shared

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(self.filmRoll.name)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(dateFormatter.string(from: self.filmRoll.created))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                HStack {
                    Text("\(self.filmRoll.camera.make) \(self.filmRoll.camera.model)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                if self.filmRoll.lens != nil {
                    HStack {
                        Text("\(self.filmRoll.lens?.make ?? "") \(self.filmRoll.lens?.model ?? "") (\(self.filmRoll.lens?.focalLength ?? 0)mm)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                HStack {
                    Text("\(self.filmRoll.filmStock.make) \(self.filmRoll.filmStock.type)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                if !self.filmRoll.complete {
                    HStack() {
                        Image(systemName: "camera")
                            .font(.system(size: 30))
                            .onTapGesture {
                                self.addShotAction()
                            }
                        
                        Spacer()
                        
                        Image(systemName: "camera.badge.ellipsis")
                            .font(.system(size: 30))
                            .onTapGesture {
                                showingSheet.toggle()
                            }
                        
                        Spacer()

                        Image(systemName: "arrow.forward.square")
                            .font(.system(size: 30))
                            .onTapGesture {
                                self.skipShotAction()
                            }

                        Spacer()

                        Text("\((self.filmRoll.filmShots?.count ?? 0)!) shots")
                            .foregroundColor(.black)
                    }
                }
            }
        }.sheet(isPresented: $showingSheet) {
            FilmShotAddView(filmRoll: filmRoll, camera: filmRoll.camera)
        }
    }

    func addShotAction(){
        _ = actions.logShot(filmRoll: self.filmRoll)
    }

    func skipShotAction(){
        _ = actions.skipShot(filmRoll: self.filmRoll)
    }
}

#Preview {
    FilmRollListCell(filmRoll: FilmRoll.createFilmRoll(name: "New Film Roll"))
}
