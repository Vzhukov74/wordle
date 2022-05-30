//
//  RidleProvider.swift
//  wordle
//
//  Created by v.s.zhukov on 01.03.2022.
//

import Foundation

final class RidleProvider {
    
    private static var riddle = Ridle.defaultRiddle()
    
    func fetch(completion: @escaping (_ ridle: Ridle?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion(RidleProvider.riddle)
        }
    }
}
