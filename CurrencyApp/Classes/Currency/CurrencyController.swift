//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Yeskendir on 10/05/2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import UIKit



class CurrencyController: UIViewController {

    let viewModel = CurrencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadLocalCurrencies()
        viewModel.loadCurrenciesByBaseCurrency(baseCurrency: "EUR")
        configView()
    }
    func configView(){
        let view = CurrencyView(frame: self.view.frame)
        let viewGesture = UITapGestureRecognizer(target: self, action:  #selector(self.hideCurrencyOptions (_:)))
        view.currencyOptionView.addGestureRecognizer(viewGesture)
        
        let fromCurrencyGesture = UITapGestureRecognizer(target: self, action:  #selector(self.fromCurrencyOptions (_:)))
        view.fromCurrencyView.addGestureRecognizer(fromCurrencyGesture)
        
        let toCurrencyGesture = UITapGestureRecognizer(target: self, action:  #selector(self.toCurrencyOptions (_:)))
        view.toCurrencyView.addGestureRecognizer(toCurrencyGesture)
        
        view.convertBtn.addTarget(self, action: #selector(self.convert), for: .touchDown)
        
        self.view = view
        self.navigationItem.title = "Currency Converter"
        viewModel.setSubscribeOnViews(view: self.view)
        
        viewModel.toCurrencyBadge.value = viewModel.getImageByCode("JPY")!
        viewModel.toCurrencyCode.value = "JPY"
    }
    
    @objc func hideCurrencyOptions(_ sender:UITapGestureRecognizer){
        if let view = self.view as? CurrencyView{
            view.currencyOptionsTableView.isHidden=true
            view.currencyOptionView.isHidden=true
        }
    }
    @objc func fromCurrencyOptions(_ sender:UITapGestureRecognizer){
        
        let alert = UIAlertController(title: "Alert", message: "Access Restricted - Your current Subscription Plan does not support this API Function.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        //Access Restricted - Your current Subscription Plan does not support this API Function.
//        if let view = self.view as? CurrencyView{
//            view.currencyOptionsTableView.isHidden=false
//            view.currencyOptionView.isHidden=false
//        }
//        viewModel.currencyToogle = .from
    }
    @objc func toCurrencyOptions(_ sender:UITapGestureRecognizer){
        if let view = self.view as? CurrencyView{
            view.currencyOptionsTableView.isHidden=false
            view.currencyOptionView.isHidden=false
            view.resultDateCurrencyLabel.isHidden = true
            view.resultFromCurrencyLabel.isHidden = true
            view.resultToCurrencyLabel.isHidden = true
            view.resultCurrencyLabel.isHidden = true
        }
        viewModel.currencyToogle = .to
    }
    
    @objc func convert(){
        print(viewModel.currencyValue.value)
        viewModel.convert()
    }
    

}

