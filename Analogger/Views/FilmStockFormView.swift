//
//  FilmStockFormView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct FilmStockFormView: View {

    @Binding var textMake: String
    @Binding var textType: String
    @Binding var intAsa: Int16
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Make: ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Film Stock Make", text: self.$textMake)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
        VStack {
            HStack {
                Text("Type: ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Film Stock Type", text: self.$textType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
        VStack {
            HStack {
                Text("Speed (ASA): ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Film Speed", value: self.$intAsa, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
