//
//  ViewController.swift
//  sunset
//
//  Created by usr0600429 on 2016/09/08.
//  Copyright © 2016年 GMO Pepabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let formatter = DateFormatter()
        // 初期値 (今日の日付を元に、navigationBarのタイトルを決める)
        formatter.dateFormat = "MMM yyyy"
        self.title = formatter.string(from: Date())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

