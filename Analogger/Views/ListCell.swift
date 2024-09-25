//
//  CameraListCell.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct ListCell: View {
    
    var main: String
    var sub: String
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(main)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(sub)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
        }
    }
    
    
}
