//
//  CameraListCell.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollListCell: View {
    
    var filmRoll: FilmRoll
    
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
            }
        }
    }
}

#Preview {
    FilmRollListCell(filmRoll: FilmRoll.createFilmRoll(name: "New Film Roll"))
}
