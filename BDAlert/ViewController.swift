//
//  ViewController.swift
//  BDAlert
//
//  Created by 诸葛游 on 2017/3/20.
//  Copyright © 2017年 诸葛游. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickedToPresent(_ sender: Any) {

        let content = UIView()
        content.backgroundColor = UIColor.red
        let edgeInset = UIEdgeInsets(top: 200, left: 100, bottom: 100, right: 100)
        
//        let alert = BDAlertController(withSystemModalTransitionType: .coverVertical, contentView: content, contentEdgeInset: edgeInset)
        let alert = BDAlertController(withCustomModalTransitionType: .crossDissolve_custom, contentView: content, contentEdgeInset: edgeInset, durarion: 0.25)
        
//        alert.couldTouchDissmiss = false
        present(alert, animated: true, completion: nil)
    }

}

