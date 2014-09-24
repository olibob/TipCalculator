//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Olivier Robert on 23/9/14.
//  Copyright (c) 2014 Olibob Software. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    var total: Double = 0.0
    var taxPct: Double = 0.0
    var subTotal: Double {
        return total / (taxPct + 1)
    }
    
    init(total: Double, taxPct: Double){
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return subTotal * tipPct
    }
    
    func returnPossibleTips() -> [Int: (tipAmt: Double, total: Double)] {
        let possibleTips = [0.15, 0.18, 0.20]
        var retVal = Dictionary<Int, (tipAmt: Double, total: Double)>()
        
        for tip in possibleTips {
            var intPct = Int(tip * 100)
            var tipAmount = calcTipWithTipPct(tip)
            retVal[intPct] = (tipAmount, (total + tipAmount))
        }
        return retVal
    }
}