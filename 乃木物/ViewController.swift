//
//  ViewController.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        _ = HttpClient_Alamofire.dataList(params: nil, success: { (dataObjc) in
            print(dataObjc)
            if let models = Mapper<DataListModel>().mapArray(JSONObject: dataObjc.results){
            print(models)
                for item in models{
                    print(item.delivery)
                    print(item.title)
                    print(item.subtitle)
                    print(item.summary)
                }
            }
        }, failed: { (err) in
            
        }, errorClo: { (code, msg) in
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

