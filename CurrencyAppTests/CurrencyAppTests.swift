//
//  CurrencyAppTests.swift
//  CurrencyAppTests
//
//  Created by Yeskendir on 10/05/2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import XCTest
@testable import CurrencyApp

class CurrencyAppTests: XCTestCase {
    func testLoadCurrenciesByEURBaseCurrency(){
        let viewModel = CurrencyViewModel()
        viewModel.loadCurrenciesByBaseCurrency(baseCurrency: "EUR")
        if let base = viewModel.currency?.base{
            XCTAssertEqual("EUR", base)
        }
    }
}
