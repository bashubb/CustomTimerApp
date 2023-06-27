//
//  ContentView.swift
//  CustomTimerApp
//
//  Created by HubertMac on 26/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model = ViewModewl()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let width: Double = 250
    
    var body: some View {
        VStack {
            Text("\(model.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 4))
                .alert("Timer done!", isPresented: $model.showingAlert){
                    Button("Conitinue", role: .cancel) {
                        //
                    }
                    
                }
            Slider(value: $model.minutes, in: 1...25, step: 1)
                .padding()
                .frame(width:width)
                .disabled(model.isActive)
                .animation(.easeInOut, value: model.minutes)
            
            HStack (spacing: 50) {
                Button("Start") {
                    model.start(minutes: model.minutes)
                }
                .disabled(model.isActive)
                
                Button("Reset") {
                    model.reset()
                }
                .tint(.red)
                
            }
            .frame(width: width)
        }
        .onReceive(timer) { _ in
            model.updateCountdown()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
