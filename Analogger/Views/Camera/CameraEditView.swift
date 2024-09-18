//
//  CameraEditView.swift
//  Analogger
//
//  Created by Ben Pirt on 16/09/2024.
//

import SwiftUI

struct CameraEditView : View {
    
    var camera: Camera
    
//    @StateObject private var dataSource = CoreDataSource<Attribute>(predicateKey: "camera")
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var textMake: String = ""
    @State private var textModel: String = ""
    
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
                    CameraFormView(textMake: self.$textMake,
                                   textModel: self.$textModel)
                }
            }
                
            
        }
        .onAppear(perform: { self.onAppear() })
        .onDisappear(perform: {self.saveAction()})            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
        .navigationBarTitle(Text("Edit Camera Details"), displayMode: .automatic)
        .navigationBarItems(trailing: Button(action:{ self.cancelAction() }) { Text("Cancel") })
    }
    
    func onAppear() {
        
        self.textMake = self.camera.make!
        self.textModel = self.camera.model!
    }
    
    func cancelAction() {
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func saveAction() {
        
        self.camera.update(make: self.textMake, model: self.textModel)
        self.cancelAction()
    }
    
    func deleteAction() {
        
        self.camera.delete()
        self.cancelAction()
    }
}

