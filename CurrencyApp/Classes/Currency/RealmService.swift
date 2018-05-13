//
//  RealmService.swift
//  CurrencyApp
//
//  Created by Mac on 13.05.2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService{
    
    //private init() {}
    //static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T){
        do{
            try realm.write{
                realm.add(object)
            }
        }catch{
            print(error)
        }
    }
}















