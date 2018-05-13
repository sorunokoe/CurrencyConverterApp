//
//  Currency.swift
//  CurrencyApp
//
//  Created by Yeskendir on 10/05/2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//


import Unbox


struct Currency{
    var base: String?
    var date: String?
    var rates: [String: Double]?
}
extension Currency: Unboxable{
    init(unboxer: Unboxer) throws {
        self.base = try unboxer.unbox(key: "base")
        self.date = try unboxer.unbox(key: "date")
        self.rates = try unboxer.unbox(key: "rates")
    }
}
