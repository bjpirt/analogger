//
//  CameraAddView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct CameraAddView : View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var textMake: String = ""
    @State private var textModel: String = ""
    
    var body: some View {
        
        Form {
            
            CameraFormView(textMake: self.$textMake, textModel: self.$textModel)
        }
        .navigationBarTitle(Text("Add Camera"), displayMode: .large)
        .navigationBarItems(
            trailing: Button(action:{ self.saveAction() }) { Text("Save") }.disabled(!self.dirty())
        )
    }
    
    func cancelAction() {
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        
        _ = Camera.createCamera(make: self.textMake, model: self.textModel)
        self.cancelAction()
    }
    
    func dirty() -> Bool {
        
        return !self.textMake.isEmpty && !self.textModel.isEmpty
    }
}
