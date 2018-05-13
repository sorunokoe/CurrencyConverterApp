//
//  CurrencyView.swift
//  CurrencyApp
//
//  Created by Yeskendir on 10/05/2018.
//  Copyright © 2018 Yeskendir. All rights reserved.
//

import Foundation
import Cartography
import Hue
import UIKit


class CurrencyView: UIView{
    
    var fromCurrencyView: UIView!
    var fromCurrencyBadge: UIImageView!
    var fromCurrencyCode: UILabel!
    
    var toCurrencyView: UIView!
    var toCurrencyBadge: UIImageView!
    var toCurrencyCode: UILabel!
    
    var badgeConvert: UIImageView!
    var valueCurrencyField: UITextField!
    var convertBtn: UIButton!
    
    var resultFromCurrencyLabel: UILabel!
    var resultToCurrencyLabel: UILabel!
    var resultCurrencyLabel: UILabel!
    var resultDateCurrencyLabel: UILabel!
    
    var currencyOptionView = UIView()
    var currencyOptionsTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        addViews()
        setConstrains()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews(){
        
        self.backgroundColor = UIColor(hex: Constants.default_background_color)
        
        
        fromCurrencyView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        toCurrencyView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        fromCurrencyBadge = {
            let badge = UIImageView()
            badge.contentMode = .scaleAspectFit
            return badge
        }()
        fromCurrencyCode = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 18)
            return label
        }()
    
        toCurrencyBadge = {
            let badge = UIImageView()
            badge.contentMode = .scaleAspectFit
            return badge
        }()
        toCurrencyCode = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 18)
            return label
        }()
        
        badgeConvert = {
            let badge = UIImageView()
            badge.contentMode = .scaleAspectFit
            badge.image = #imageLiteral(resourceName: "reload")
            return badge
        }()
        valueCurrencyField = {
            let field = UITextField()
            field.keyboardType = .decimalPad
            field.placeholder = "Amount"
            field.textAlignment = .center
            field.backgroundColor = .white
            field.font = UIFont.systemFont(ofSize: 20)
            return field
        }()
        convertBtn = {
            let btn = UIButton()
            btn.backgroundColor = UIColor(hex: Constants.brand_color)
            btn.setImage(#imageLiteral(resourceName: "arrow-point-to-right"), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.imageEdgeInsets = .init(top: 7, left: 30, bottom: 7, right: 5)
            return btn
        }()
        
        
        resultFromCurrencyLabel = {
           let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor.lightGray
            return label
        }()
        resultToCurrencyLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = UIColor.lightGray
            return label
        }()
        resultCurrencyLabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 26)
            label.textColor = UIColor(hex: Constants.brand_color)
            return label
        }()
        resultDateCurrencyLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = UIColor.lightGray
            return label
        }()

        
        self.currencyOptionsTableView.isHidden = true
        self.currencyOptionView.isHidden = true
        self.currencyOptionsTableView.separatorStyle = .none
        self.currencyOptionsTableView.awakeFromNib()
        self.currencyOptionView.backgroundColor = UIColor(red: CGFloat(0.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(0.0/255.0), alpha: CGFloat(0.3))
        
    }
    func addViews(){
        [fromCurrencyCode, fromCurrencyBadge].forEach{
            fromCurrencyView.addSubview($0)
        }
        [toCurrencyCode, toCurrencyBadge].forEach{
            toCurrencyView.addSubview($0)
        }
        
        [fromCurrencyView, toCurrencyView, badgeConvert,
         valueCurrencyField, convertBtn,
         resultFromCurrencyLabel, resultCurrencyLabel, resultToCurrencyLabel, resultDateCurrencyLabel, currencyOptionView, currencyOptionsTableView].forEach{
            self.addSubview($0)
        }
    }
    func setConstrains(){
        
        constrain(fromCurrencyView, badgeConvert, toCurrencyView){
            $0.top == $0.superview!.top+100
            $0.left == $0.superview!.left+30
            $0.width == 120
            $0.height == 35
            
            $1.centerY == $0.centerY
            $1.centerX == $1.superview!.centerX
            $1.width == 20
            $1.height == 20
            
            $2.top == $2.superview!.top+100
            $2.right == $2.superview!.right-30
            $2.width == 120
            $2.height == 35
        }
        
        constrain(fromCurrencyView, valueCurrencyField, convertBtn){
            $2.top == $0.bottom+20
            $2.right == $2.superview!.right-30
            $2.height == 35
            $2.width == 60
            
            $1.top == $0.bottom+20
            $1.left == $1.superview!.left+30
            $1.right == $2.left-15
            $1.height == 35
        }
        
        constrain(valueCurrencyField, resultFromCurrencyLabel,
                  resultToCurrencyLabel, resultCurrencyLabel){
                    
                    $3.top == $0.bottom+15
                    $3.centerX == $3.superview!.centerX+35
                    
                    $1.centerY == $3.centerY
                    $1.right == $3.left-5
                    
                    $2.centerY == $3.centerY
                    $2.left == $3.right+5
        }
        
        constrain(resultCurrencyLabel, resultDateCurrencyLabel){
            $1.centerX == $1.superview!.centerX
            $1.top == $0.bottom+5
        }
        
        constrain(fromCurrencyBadge, fromCurrencyCode){
            $0.centerY == $0.superview!.centerY
            $0.left == $0.superview!.left+5
            $0.width == 45
            $0.height == 30
            
            $1.centerY == $1.superview!.centerY
            $1.right == $1.superview!.right-15
        }
        constrain(toCurrencyBadge,toCurrencyCode){
            $0.centerY == $0.superview!.centerY
            $0.right == $0.superview!.right-5
            $0.width == 45
            $0.height == 30
            
            $1.centerY == $1.superview!.centerY
            $1.left == $1.superview!.left+15
        }
        
        constrain(currencyOptionView, currencyOptionsTableView){
            $0.top == $0.superview!.top
            $0.bottom == $0.superview!.centerY
            $0.left == $0.superview!.left
            $0.right == $0.superview!.right
            
            
            $1.top == $1.superview!.centerY
            $1.left == $1.superview!.left
            $1.right == $1.superview!.right
            $1.bottom == $1.superview!.bottom
        }
        
        
    }
    
}
