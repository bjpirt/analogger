//
//  CameraFormView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct CameraFormView: View {

    @Binding var textMake: String
    @Binding var textModel: String
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Make: ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Camera Make", text: self.$textMake)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
        VStack {
            HStack {
                Text("Model: ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Camera Model", text: self.$textModel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
