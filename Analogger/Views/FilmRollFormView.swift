//
//  CameraFormView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmRollFormView: View {

    @Binding var textName: String
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Name: ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter name of film roll", text: self.$textName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
