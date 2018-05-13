//
//  LocalCurrencyService.swift
//  CurrencyApp
//
//  Created by Mac on 13.05.2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import Foundation
import RealmSwift

class LocalCurrencyService{
    static func loadCurrencies(completion: (CurrencyRealm?) -> Void){
        let realm = RealmService().realm
        completion(realm.objects(CurrencyRealm.self).last)
    }
    static func saveCurrencies(currency: Currency){
        if let base = currency.base, let date = currency.date, let rates = currency.rates{
            let new = CurrencyRealm(base: base, date: date, rates: rates)
            RealmService().create(new)
        }
    }
    
}
