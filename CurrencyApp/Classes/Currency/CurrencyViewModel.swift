//
//  CurrencyViewModel.swift
//  CurrencyApp
//
//  Created by Yeskendir on 10/05/2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

enum CurrencyType{
    case from, to
}
protocol CurrencyViewModelDelegate{
    func setSubscribeOnViews(view: UIView)
}
class CurrencyViewModel{
    
    var currencyToogle: CurrencyType?
    
    var fromCurrencyBadge = Variable<UIImage>(UIImage())
    var fromCurrencyCode = Variable<String>(String())
    
    var toCurrencyBadge = Variable<UIImage>(UIImage())
    var toCurrencyCode = Variable<String>(String())
    
    var optionsCurrency = Variable<[String]>([String]())
    
    var currencyValue = Variable<Double>(Double())
    
    var result = Variable<String>(String())
    var resultFrom = Variable<String>(String())
    var resultTo = Variable<String>(String())
    var resultDate = Variable<String>(String())
    
    let disposeBag = DisposeBag()
    var currency: Currency?{
        didSet{
            if let currency = currency{
                self.optionsCurrency.value = currency.rates!
                    .filter({ (key, value) -> Bool in
                        if self.getImageByCode(key) != nil && self.getCurrencyNameByCode(key) != nil{
                            return true
                        }
                        return false
                    })
                    .map({ (arg) -> String in
                    let (key, _) = arg
                    return key
                })
                if let code = currency.base{
                    self.fromCurrencyCode.value = code
                    if let image = self.getImageByCode(code){
                        self.fromCurrencyBadge.value = image
                    }
                }
            }
        }
    }
    
    func convert(){
        
        SVProgressHUD.show()
        self.currency?.rates!.forEach { (key, value) in
            if key == self.toCurrencyCode.value{
                self.result.value = "\(round(1000*self.currencyValue.value*Double(value))/1000)"
                self.resultFrom.value = "\(self.currencyValue.value) \(self.fromCurrencyCode.value) ="
                self.resultTo.value = "\(self.toCurrencyCode.value)"
                if let date = self.currency?.date{
                    self.resultDate.value = "\(date)"
                }
            }
        }
        SVProgressHUD.dismiss()
        
        
        
        // API Method
        //Access Restricted - Your current Subscription Plan does not support this API Function.
//        SVProgressHUD.show()
//        CurrencyService.convert(value: self.currencyValue.value, from:self.fromCurrencyCode.value, to: self.toCurrencyCode.value) { (result, error) in
//                SVProgressHUD.dismiss()
//                if error == nil{
//                    self.result.value = result!
//                }
//            }
    }
    func loadCurrenciesByBaseCurrency(baseCurrency: String){
        //SVProgressHUD.show()
        CurrencyService.loadCurrencies(baseCurrency: baseCurrency) { (currency, error) in
            //SVProgressHUD.dismiss()
            if error == nil{
                if let currency = currency{
                    LocalCurrencyService.saveCurrencies(currency: currency)
                    self.currency = currency
                }
            }else{
                //TODO: represent error or log it
            }
        }
    }
    func loadLocalCurrencies(){
        SVProgressHUD.show()
        LocalCurrencyService.loadCurrencies() { (currency) in
            SVProgressHUD.dismiss()
            if let currency = currency{
                var new = Currency()
                new.base = currency.base
                new.date = currency.date
                var map = [String: Double]()
                currency.rates.forEach({ (rates) in
                    map[rates.key!] = Double(rates.value!)
                })
                new.rates = map
                self.currency = new
            }
        }
    }
    
    func getImageByCode(_ code: String) -> UIImage?{
        if let path = Bundle.main.path(forResource: "CountryData", ofType: "plist"){
            if let listArray = NSArray(contentsOfFile: path){
                let filteredCountryData = listArray.filtered(using: NSPredicate(format : "code = %@", code))
                
                if let object = filteredCountryData.last as? [String:Any]{
                    if let country = object["country"]{
                        let image = UIImage.init(named: "\(country).png")
                        return image
                    }
                }
            }
        }
        return nil
    }
    func getCurrencyNameByCode(_ code: String) -> String?{
        if let path = Bundle.main.path(forResource: "CountryData", ofType: "plist"){
            if let listArray = NSArray(contentsOfFile: path){
                let filteredCountryData = listArray.filtered(using: NSPredicate(format : "code = %@", code))
                
                if let object = filteredCountryData.last as? [String:Any]{
                    if let name = object["name"] as? String{
                        return name
                    }
                }
            }
        }
        return nil
    }
    func getCurrencySymbolByCode(_ code: String) -> String?{
        if let path = Bundle.main.path(forResource: "CountryData", ofType: "plist"){
            if let listArray = NSArray(contentsOfFile: path){
                let filteredCountryData = listArray.filtered(using: NSPredicate(format : "code = %@", code))
                
                if let object = filteredCountryData.last as? [String:Any]{
                    if let symbol = object["symbol"] as? String{
                        return symbol
                    }
                }
            }
        }
        return nil
    }
}
extension CurrencyViewModel: CurrencyViewModelDelegate{
    func setSubscribeOnViews(view: UIView) {
        if let view = view as? CurrencyView{
            
            self.fromCurrencyCode.asObservable()
                .bind(to: view.fromCurrencyCode.rx.text)
                .disposed(by: self.disposeBag)
            
            self.fromCurrencyBadge.asObservable()
                .bind(to: view.fromCurrencyBadge.rx.image)
                .disposed(by: self.disposeBag)
            
            self.toCurrencyCode.asObservable()
                .bind(to: view.toCurrencyCode.rx.text)
                .disposed(by: self.disposeBag)
            
            self.toCurrencyBadge.asObservable()
                .bind(to: view.toCurrencyBadge.rx.image)
                .disposed(by: self.disposeBag)
            
            view.currencyOptionsTableView.delegate = nil
            view.currencyOptionsTableView.dataSource = nil
            view.currencyOptionsTableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrentCell")

            self.optionsCurrency
                .asObservable()
                .bind(to: view.currencyOptionsTableView.rx.items(cellIdentifier: "CurrentCell", cellType: CurrencyCell.self)){(row, element, cell) in
                    if let flag = self.getImageByCode(element), let code = self.getCurrencyNameByCode(element){
                        cell.setData(flag: flag, code: code)
                    }
                    }.disposed(by: self.disposeBag)
            
            
            view.currencyOptionsTableView.rx.itemSelected
                .subscribe(onNext: {indexPath in
                    view.currencyOptionsTableView.deselectRow(at: indexPath, animated: true)
                    view.currencyOptionsTableView.isHidden=true
                    view.currencyOptionView.isHidden=true
                    self.setCurrency(code: self.optionsCurrency.value[indexPath.row])
                    view.valueCurrencyField.text = ""
                }).disposed(by: disposeBag)
            
            
            view.valueCurrencyField.addTarget(self, action: #selector(currencyValueChanged), for: .editingChanged)
            
            
            self.result.asObservable()
                .do(onNext: { (_) in
                    view.resultCurrencyLabel.isHidden = false
                })
                .bind(to: view.resultCurrencyLabel.rx.text)
                .disposed(by: self.disposeBag)
            self.resultFrom.asObservable()
                .do(onNext: { (_) in
                    view.resultFromCurrencyLabel.isHidden = false
                })
                .bind(to: view.resultFromCurrencyLabel.rx.text)
                .disposed(by: self.disposeBag)
            self.resultTo.asObservable()
                .do(onNext: { (_) in
                    view.resultToCurrencyLabel.isHidden = false
                })
                .bind(to: view.resultToCurrencyLabel.rx.text)
                .disposed(by: self.disposeBag)
            self.resultDate.asObservable()
                .do(onNext: { (_) in
                    view.resultDateCurrencyLabel.isHidden = false
                })
                .bind(to: view.resultDateCurrencyLabel.rx.text)
                .disposed(by: self.disposeBag)
        }
    }
   
    
    func setCurrency(code: String){
        if self.currencyToogle == .from{
            self.fromCurrencyCode.value = code
            self.fromCurrencyBadge.value = self.getImageByCode(code)!
        }
        if self.currencyToogle == .to{
            self.toCurrencyCode.value = code
            self.toCurrencyBadge.value = self.getImageByCode(code)!
        }
    }
    @objc func currencyValueChanged(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting(code: self.fromCurrencyCode.value, currencyValue: currencyValue) {
            textField.text = amountString
        }
    }
    
}
extension String{
    
    func currencyInputFormatting(code: String, currencyValue: Variable<Double>) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencyCode = code
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
            return ""
        }
        currencyValue.value = Double(truncating: number)
        return formatter.string(from: number)!
    }
}









