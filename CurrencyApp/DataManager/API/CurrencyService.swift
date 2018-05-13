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
import Unbox

class CurrencyService{
    
    let session = URLSession.shared
    let disposeBag = DisposeBag()
    
    static func convert(value: String, from:  String, to: String, completion: @escaping (_ result: String?, _ error: String?) -> Void){
        _ = request(.get, Constants.base_url+"convert"+Constants.access_key+"&from="+from+"&to="+to+"&amount="+value)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (response) in
                if response.result.isSuccess{
                    if let value = response.value{
                        print(value)
                        let dict = JSON(value)
                        print(dict)
                        completion(dict["result"].string!, nil)
                    }
                }else{
                    completion(nil, response.result.error?.localizedDescription)
                }
            })
        
    }
    
    static func loadCurrencies(baseCurrency: String, completion: @escaping (Currency?, String?) -> ()){
        
//        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        configuration.timeoutIntervalForRequest = 10 // seconds
//        configuration.timeoutIntervalForResource = 10
//        self.alamoFireManager = Alamofire.Manager(configuration: configuration)
        
        
        
        _ = request(.get, Constants.base_url+"latest"+Constants.access_key)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (response) in
                if let error = response.result.error{
                    completion(nil, error.localizedDescription)
                }else{
                    if let data = response.value as? NSDictionary{
                        do{
                            completion(try unbox(dictionary: data as! UnboxableDictionary), nil)
                        }catch let error as NSError{
                            completion(nil, error.localizedDescription)
                        }
                    }
                }
            })
    }
    
}
