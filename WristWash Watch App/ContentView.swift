//
//  ContentView.swift
//  WristWash Watch App
//
//  Created by 张力哲 on 3/18/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HandwashingViewModel()
    @State private var isRecording = false
    @State private var showSteps = false
    
    var body: some View {
        VStack {
            if showSteps {
                VStack {
                    Text("Handwashing Step:")
                    Text("\(viewModel.currentStep)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            Spacer()
            
            if !isRecording {
                Button(action: {
                    withAnimation {
                        isRecording = true
                        showSteps = true
                    }
                    viewModel.startAccelerometerUpdates()
                }) {
                    Text("Start")
                        .font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
                .padding(.horizontal)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                Button(action: {
                    withAnimation {
                        isRecording = false
                        showSteps = false
                    }
                    viewModel.stopAccelerometerUpdates()
                }) {
                    Text("Finish")
                        .font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                }
                .padding(.horizontal)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding()
    }
}
