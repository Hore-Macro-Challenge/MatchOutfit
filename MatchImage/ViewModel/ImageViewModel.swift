//
//  QuestionViewModel.swift
//  Duolingo
//
//  Created by GOURAVM on 22/08/22.

import SwiftUI

class ImageViewModel:NSObject, ObservableObject {
    @Published var steers: [ImageMatch] = [ImageMatch(value: "Steer1", offset_x: 0, offset_y: -50, width: 100, height: 100),
                                           ImageMatch(value: "Steer2", offset_x: -75, offset_y: 0, width: 50, height: 155),
                                           ImageMatch(value: "Steer3", offset_x: 75, offset_y: 0, width: 50, height: 155),
                                           ImageMatch(value: "Steer4", offset_x: 0, offset_y: 50, width: 100, height: 100)]
    
    @Published var progress : CGFloat = 0
    @Published var shuffledRows: [[ImageMatch]] = []
    @Published var rows: [[ImageMatch]] = []
    
    @Published var animateWrong = false
    @Published var droppedCount: CGFloat = 0
 
    func generateGrid() -> [[ImageMatch]] {
        var gridArray: [[ImageMatch]] = []
        var tempArray: [ImageMatch] = []
        var currentWidth: CGFloat = 0
        let totalScreenWidth:CGFloat = CGFloat(UIScreen.main.bounds.width - 30)
        
        for steer in steers {
            if currentWidth < totalScreenWidth {
                tempArray.append(steer)
            }else {
                gridArray.append(tempArray)
                tempArray = []
                tempArray.append(steer)
            }
        }
        
        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        
        return gridArray
        
    }
    
    func shuffleArray() {
        if rows.isEmpty {
            rows =  generateGrid()
            steers =  steers.shuffled()
            shuffledRows =  generateGrid()
        }
    }
    
    func updateSuffledArray(character:ImageMatch) {
        for index in shuffledRows.indices {
            for subIndex in shuffledRows[index].indices {
                if shuffledRows[index][subIndex].id == character.id {
                    shuffledRows[index][subIndex].isShowing = true
                }
            }
        }
    }
}
