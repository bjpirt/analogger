//
//  ContentView.swift
//  AnaloggerWatch Watch App
//
//  Created by Ben Pirt on 03/10/2024.
//

import SwiftUI

struct ContentView: View {
    let watchComms = WatchComms()
    @State var logging = false
    @State var loaded = false
    @State var shotCount: Int16 = 0
    @State var rollName: String = "Film Name"

    var body: some View {
        VStack{
            if loaded {
                Text("\(self.shotCount) shots")
                    .bold()
                Spacer()
                if self.logging {
                    Button {
                    }label: {
                        Label("Logging", systemImage: "camera")
                            .padding()
                    }.buttonStyle(BorderedButtonStyle(tint: .blue))
                }else{
                    Button {
                        logShot()
                    }label: {
                        Label("Log a shot", systemImage: "camera")
                            .padding()
                    }.buttonStyle(BorderedButtonStyle(tint: .blue))
                }
                Spacer()
                Text(self.rollName)
                    .font(.subheadline)
            } else {
                Text("Connecting...").bold()
            }
        }.onAppear(perform: { self.onAppear() })
    }
    
    func onAppear(){
        DispatchQueue.main.async {
            self.loadData()
        }
    }

    func loadData(){
        print("Loading data")
        self.loaded = false
        self.watchComms.session.sendMessage(["action": "getData"], replyHandler: self.receiveReply, errorHandler: { error in
            print("Error loading data \(error)")
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                print("Repeating")
                self.loadData()
            }
            RunLoop.main.add(timer, forMode: .common)
        })
    }

    func logShot(){
        self.logging = true
        self.watchComms.session.sendMessage(["action": "logShot"], replyHandler: self.receiveReply)
    }

    func receiveReply(resp: [String: Any]){
        if resp["result"] != nil && resp["data"] != nil && resp["result"] as! String == "success" {
            let data = resp["data"] as! [String: Any]
            self.rollName = data["rollName"] as? String ?? "Error"
            self.shotCount = data["shotCount"] as? Int16 ?? 0
        }
        self.loaded = true
        self.logging = false
    }
}

#Preview {
    ContentView()
}
