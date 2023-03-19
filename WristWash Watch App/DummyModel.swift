//
//  DummyModel.swift
//  WristWash Watch App
//
//  Created by 张力哲 on 3/18/23.
//

import Foundation
import CoreML

class DummyModel {
    func prediction(input: MLMultiArray) -> StepPrediction? {
        let sum = input[0].doubleValue + input[1].doubleValue + input[2].doubleValue
        let step = Int.random(in: 1...5)
        return StepPrediction(step: step)
    }
    
    struct StepPrediction {
        let step: Int
    }
}

