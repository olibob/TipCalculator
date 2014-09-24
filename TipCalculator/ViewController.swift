//
//  ViewController.swift
//  TipCalculator
//
//  Created by Olivier Robert on 23/9/14.
//  Copyright (c) 2014 Olibob Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt: Double, total: Double)>()
    var sortedKeys = Array<Int>()
    
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var taxPctLabel: UILabel!
    @IBOutlet weak var taxPctSlider: UISlider!
    @IBOutlet weak var tipTableView: UITableView!
    
    @IBAction func calculateTapped(sender: AnyObject) {
        possibleTips = tipCalc.returnPossibleTips()
        println("\(possibleTips)")
        sortedKeys = sorted(possibleTips.keys)
        tipTableView.reloadData()
    }
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value / 100)
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
    }
    

    @IBAction func billChanged(sender: UITextField) {
        var toto: Double = (sender.text as NSString).doubleValue
        tipCalc = TipCalculatorModel(total: (sender.text as NSString).doubleValue, taxPct: Double(taxPctSlider.value / 100))
        tipTableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: funcs
    
    func refreshUI() {
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        tipTableView.reloadData()
    }
    
    //MARK UITableView Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("bobid") as UITableViewCell
        
        let tipPct = sortedKeys[indexPath.row]
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let grandTotal = possibleTips[tipPct]!.total
        
        cell.textLabel?.text = "\(tipPct)%: "
        cell.detailTextLabel?.text = String(format: "Tip: %0.2f, Total: %0.2f", tipAmt, grandTotal)
        
        return cell
    }
}