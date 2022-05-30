//
//  LastRidleIdStore.swift
//  wordle
//
//  Created by v.s.zhukov on 28.04.2022.
//

import Foundation

final class LastRidleIdStore {
    
    private let key = "com.wordle.last.ridle.id.key"
    private let userDefaults = UserDefaults.standard
    
    func saveLastRidle(id: String) {
        userDefaults.set(id, forKey: key)
    }
    
    func getLastRidleId() -> String? {
        userDefaults.string(forKey: key)
    }
}
