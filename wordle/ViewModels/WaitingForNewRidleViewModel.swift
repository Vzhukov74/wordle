//
//  WaitingForNewRidleViewModel.swift
//  wordle
//
//  Created by v.s.zhukov on 30.05.2022.
//

import SwiftUI
import Combine

class WaitingForNewRidleViewModel: ObservableObject {
    @Published var availableAfter: String = ""
    
    private let unavailableUntil: String
    private var timer: Timer?
    
    init(unavailableUntil: String) {
        self.unavailableUntil = unavailableUntil
        self.calculateAvailableAfterTime()
    }
    
    func startCountDown() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.calculateAvailableAfterTime()
        }
        self.timer = timer
    }
    
    private func calculateAvailableAfterTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let unavailableUntilDate = dateFormatter.date(from: unavailableUntil) else { return }
        
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: unavailableUntilDate)
        
        var availableAfterStr = ""
        
        if let hour = diffComponents.hour, hour > 0 {
            availableAfterStr += hour < 10 ? "0\(hour):" : "\(hour):"
        }
        
        if let minute = diffComponents.minute, minute > 0 {
            availableAfterStr += minute < 10 ? "0\(minute):" : "\(minute):"
        }
        
        if let second = diffComponents.second {
            availableAfterStr += second < 10 ? "0\(second)" : "\(second)"
        }
        
        self.availableAfter = availableAfterStr
    }
}
