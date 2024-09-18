//
//  LensFormView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct LensFormView: View {

    @Binding var textMake: String
    @Binding var textModel: String
    @Binding var intFocalLength: Int16

    var body: some View {

        VStack {
            HStack {
                Text("Make: ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Lens Make", text: self.$textMake)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }

        VStack {
            HStack {
                Text("Model: ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Lens Model", text: self.$textModel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }

        VStack {
            HStack {
                Text("Focal Length (mm): ").foregroundColor(.gray)
                Spacer()
            }
            TextField("Enter Focal Length", value: self.$intFocalLength, format: .number)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
