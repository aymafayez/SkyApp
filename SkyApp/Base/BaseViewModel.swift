//
//  BaseViewModel.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation

class BaseViewModel {
    let reachability = try! Reachability()
    var isInternetConnected: Bool = true
    
    init() {
        reachability.whenReachable = { reachability in
            self.isInternetConnected = true
        }
        reachability.whenUnreachable = { _ in
            self.isInternetConnected = false
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
