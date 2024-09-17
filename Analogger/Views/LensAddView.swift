//
//  LensAddView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct LensAddView : View {

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var textMake: String = ""
    @State private var textModel: String = ""
    @State private var intFocalLength: Int16 = 0

    var body: some View {

        Form {

            LensFormView(textMake: self.$textMake, textModel: self.$textModel, intFocalLength: self.$intFocalLength)
        }
        .navigationBarTitle(Text("Add Lens"), displayMode: .large)
        .navigationBarItems(
            trailing: Button(action:{ self.saveAction() }) { Text("Save") }.disabled(!self.dirty())
        )
    }

    func cancelAction() {

        self.presentationMode.wrappedValue.dismiss()
    }

    func saveAction() {

        _ = Lens.createLens(make: self.textMake, model: self.textModel, focalLength: self.intFocalLength)
        self.cancelAction()
    }

    func dirty() -> Bool {

        return !self.textMake.isEmpty && !self.textModel.isEmpty
    }
}
