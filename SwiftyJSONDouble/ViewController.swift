//
//  ViewController.swift
//  SwiftyJSONDouble
//
//  Created by Rex Sikora on 11/10/17.
//  Copyright © 2017 DrunkDogs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getBitcoinData(url: "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD")
    }


    
    //MARK: - Networking
    /***************************************************************/
    
    func getBitcoinData (url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Success! Got the bitcoin data")
                    let bitcoinJSON : JSON = JSON(response.result.value!)
                    self.updateBitcoinData(json: bitcoinJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
        
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitcoinData(json : JSON) {
        
        print(json["last"])
        
        let doubleValueLast = json["last"].doubleValue
        let doubleLast = json["last"].double
        print(".doubleValue:",doubleValueLast,".double:", doubleLast)
        
        if let lastValue = json["last"].double {
            bitcoinPriceLabel.text = "$" + String(lastValue)
        } else {
            print("typecast failed")
            bitcoinPriceLabel.text = "Price Unavailable"
        }
        
        
    }


}

