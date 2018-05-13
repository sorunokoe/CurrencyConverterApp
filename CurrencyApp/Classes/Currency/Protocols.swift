//
//  Protocols.swift
//  CurrencyApp
//
//  Created by Mac on 13.05.2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import Foundation

protocol CurrencyDelegate{
    var base: String{ get set}
    var date: String{get set}
    var rates: [String: Double]{get set}
}
