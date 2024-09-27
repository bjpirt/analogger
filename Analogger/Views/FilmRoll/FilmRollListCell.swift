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
                if self.filmRoll.camera != nil {
                    HStack {
                        Text("\((self.filmRoll.camera?.make)!) \((self.filmRoll.camera?.model)!)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                if self.filmRoll.lens != nil {
                    HStack {
                        Text("\((self.filmRoll.lens?.make)!) \((self.filmRoll.lens?.model)!) (\((self.filmRoll.lens?.focalLength)!)mm)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                if self.filmRoll.filmStock != nil {
                    HStack {
                        Text("\((self.filmRoll.filmStock?.make)!) \((self.filmRoll.filmStock?.type)!)")
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

                        Text("\((self.filmRoll.filmShots?.count ?? 0)!) shots")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }

    func addShotAction(){
        print("Calling shared logshot from cell")
        actions.logShot(filmRoll: self.filmRoll)
    }
}

#Preview {
    FilmRollListCell(filmRoll: FilmRoll.createFilmRoll(name: "New Film Roll"))
}
