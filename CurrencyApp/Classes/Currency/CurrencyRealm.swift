//
//  CurrencyRealm.swift
//  CurrencyApp
//
//  Created by Mac on 13.05.2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import Foundation
import RealmSwift

class RatesRealm: Object{
    @objc dynamic var key: String? = nil
    @objc dynamic var value: String? = nil
    
    convenience init(key: String, value: Double) {
        self.init()
        self.key = key
        self.value = "\(value)"
    }
}
class CurrencyRealm: Object{
    @objc dynamic var base: String? = nil
    @objc dynamic var date: String? = nil
    var rates = List<RatesRealm>()
    
    convenience init(base: String, date: String, rates: [String: Double]){
        self.init()
        self.base = base
        self.date = date
        let result = List<RatesRealm>()
        rates.forEach { (key, value) in
            result.append(RatesRealm(key: key, value: value))
        }
        self.rates = result
    }
}
