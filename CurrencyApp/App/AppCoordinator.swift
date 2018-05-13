//
//  AppCoordinator.swift
//  CurrencyApp
//
//  Created by Yeskendir on 10/05/2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import UIKit

class AppCoordinator{
    
    private var window: UIWindow
    private let navigationController = UINavigationController()
    
    
    init(window: UIWindow){
        self.window = window
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
    
    
    public func start(){
        let vc = CurrencyController()
        self.navigationController.viewControllers = [vc]
    }
    
}
