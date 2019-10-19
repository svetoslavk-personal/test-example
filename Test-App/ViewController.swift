//
//  ViewController.swift
//  Test-App
//
//  Created by Boris Rashkov on 19.10.19.
//  Copyright © 2019 Boris Rashkov. All rights reserved.
// BATEEEEEEE

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var weather: UILabel?
    var cityTitle: UILabel?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLables()
        APIRequest()
        
    }

    
    fileprivate func initLables(){
        //Default Values
        weather = UILabel()
        weather?.text = "Unknow Weahter"
        self.view.addSubview(weather!)
        
        cityTitle = UILabel()
        cityTitle?.text = "Unknow City"
        self.view.addSubview(cityTitle!)
        
        //Constraints
        weather?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.topMargin).offset(50)
            make.left.equalTo(self.view.snp.left).offset(20)
            let weatherLabelWidth = (self.view.frame.width / 2) - 20
            make.width.equalTo(weatherLabelWidth)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.2)
        })
    
        cityTitle?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.topMargin).offset(50)
            make.left.equalTo(weather?.snp.right ?? self.view.snp.left)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.2)
        })
    }
    
    
    fileprivate func APIRequest() {
        
        let API_URL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=M%C3%BCnchen,DE&appid=5d95337e5f41118894ef12c9eae7fed1")
        
        guard let url = API_URL else {
            print (API_URL)
            return
        }
        
        let api_task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            
            guard let dataResponse = data else { return }
            
            do {
                let responseJson = try JSONSerialization.jsonObject(with: dataResponse, options: [])
        
                guard let dict = responseJson as? [String:Any] else { return }
                
                let city = dict["city"] as! [String:Any]
                DispatchQueue.main.async {
                    self.cityTitle?.text = city["country"] as! String
                }
            } catch let jsonError {
             print (jsonError)
            }
        }
        
        api_task.resume()
    }
    
}

struct Constants {
    static let API_KEY = "255d8eebb0515d3237de18f19d409ed1"
}
