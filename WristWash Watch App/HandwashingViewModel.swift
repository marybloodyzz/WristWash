//
//  HandwashingViewModel.swift
//  WristWash Watch App
//
//  Created by 张力哲 on 3/18/23.
//

import Foundation
import CoreMotion
import Combine
import CoreML

class HandwashingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    
    private let motionManager = CMMotionManager()
    private let yourModel = DummyModel()
    
    init() {
        startAccelerometerUpdates()
    }
    
    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0 / 60.0 // 60 Hz
            
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data else { return }
                
                // Preprocess the data if needed
                let processedData = self?.preprocessData(data: data)
                
                // Make a prediction using your trained model
                self?.predictStep(data: processedData)
            }
        }
    }
    
    func preprocessData(data: CMAccelerometerData) -> MLMultiArray? {
        let arraySize = 3
        let arrayData: [Double] = [data.acceleration.x, data.acceleration.y, data.acceleration.z]

        guard let processedData = try? MLMultiArray(shape: [NSNumber(integerLiteral: arraySize)], dataType: .double) else {
            return nil
        }

        for (index, value) in arrayData.enumerated() {
            processedData[index] = NSNumber(value: value)
        }

        return processedData
    }

    
    func predictStep(data: MLMultiArray?) {
        guard let data = data else { return }
        
        if let prediction = yourModel.prediction(input: data) {
            DispatchQueue.main.async {
                // Update the current step based on the model's output
                self.currentStep = prediction.step
            }
        }
    }
    
    func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }


}


