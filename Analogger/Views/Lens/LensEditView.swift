//
//  LensEditView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct LensEditView : View {

    var lens: Lens

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var textMake: String = ""
    @State private var textModel: String = ""
    @State private var intFocalLength: Int16 = 0

    var body: some View {

        VStack {
            Form {
                Section(footer: HStack {
                    Spacer()
                    Button(
                        role: .destructive,
                        action: { self.deleteAction() },
                        label: { Text("Delete").frame(maxWidth: .infinity) }
                    )
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }) {
                    LensFormView(textMake: self.$textMake,
                                 textModel: self.$textModel,
                                 intFocalLength: self.$intFocalLength)
                }
            }
        }
        .onAppear(perform: { self.onAppear() })
        .onDisappear(perform: {self.saveAction()})            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
        .navigationBarTitle(Text("Edit Lens Details"), displayMode: .automatic)
        .navigationBarItems(trailing: Button(action:{ self.cancelAction() }) { Text("Cancel") })
    }

    func onAppear() {
        self.textMake = self.lens.make
        self.textModel = self.lens.model
        self.intFocalLength = self.lens.focalLength
    }

    func cancelAction() {
        self.presentationMode.wrappedValue.dismiss()
    }

    func saveAction() {
        self.lens.update(make: self.textMake, model: self.textModel, focalLength: self.intFocalLength)
        self.cancelAction()
    }

    func deleteAction() {
        self.lens.delete()
        self.cancelAction()
    }
}
