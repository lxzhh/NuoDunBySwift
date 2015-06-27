//
//  ViewController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/6/20.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit
class ViewController: UIViewController ,NSXMLParserDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(parser: NSXMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?){
        
    }
}

