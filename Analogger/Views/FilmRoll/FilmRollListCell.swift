//
//  CameraListCell.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollListCell: View {
    
    var filmRoll: FilmRoll
    
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
                if self.filmRoll.filmStock != nil {
                    HStack {
                        Text("\(self.filmRoll.filmStock?.make ?? "") \(self.filmRoll.filmStock?.type ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                if !self.filmRoll.complete {
                    HStack() {
                        Image(systemName: "camera")
                            .font(.system(size: 30))
                            .onTapGesture {
                                self.addShotAction()
                            }
                        
                        Spacer()
                        
                        NavigationLink(destination: FilmShotAddView(filmRoll: filmRoll, camera: filmRoll.camera)) {
                            HStack {
                                Image(systemName: "camera.viewfinder")
                                    .font(.system(size: 30))
                                Image(systemName: "pencil")
                                    .font(.system(size: 30))
                            }
                        }
                        
                        
                        Spacer()

                        Text("\((self.filmRoll.filmShots?.count ?? 0)!) shots")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }

    func addShotAction(){
        print("Calling shared logshot from cell")
        _ = actions.logShot(filmRoll: self.filmRoll)
    }
}

#Preview {
    FilmRollListCell(filmRoll: FilmRoll.createFilmRoll(name: "New Film Roll"))
}
