//
//  CameraListCell.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct CameraListCell: View {
    
    var make: String
    var model: String
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(make)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(model)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
        }
    }
}
