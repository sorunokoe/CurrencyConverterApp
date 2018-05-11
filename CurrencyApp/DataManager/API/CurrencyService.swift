//
//  CurrencyService.swift
//  CurrencyApp
//
//  Created by Yeskendir on 10/05/2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import SwiftyJSON

class CurrencyService{
    
    let disposeBag = DisposeBag()
    
    func convert(currencyValue: String, currencyCode: String, completion: (_ value: Double) -> Void){
        
        

            RxAlamofire.requestJSON(.get, Constants.base_url)
                .debug()
                .subscribe(onNext: { [weak self] (r, json) in
                        if let dict = json as? [String: AnyObject] {
                            let valDict = dict["rates"] as! Dictionary<String, AnyObject>
                            if let conversionRate = valDict[currencyCode] as? Double {
                                let result = conversionRate * Double(currencyValue)!
                            }
                        }
                    })
                .disposed(by: disposeBag)
            
   
        
    }
    
}
