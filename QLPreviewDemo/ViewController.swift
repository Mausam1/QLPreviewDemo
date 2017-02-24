//
//  ViewController.swift
//  QLPreviewDemo
//
//  Created by Mausam on 2/9/17.
//  Copyright © 2017 Mausam. All rights reserved.
//

import UIKit
import QuickLook


class ViewController: UIViewController, QLPreviewControllerDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func setUpQLPreview(){
        let ql = QLPreviewController()
        ql.dataSource  = self
        present(ql, animated: true, completion: nil)
    }
    
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController!) -> Int{
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        print("Getting item")
        return appDelegate.url as! QLPreviewItem
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

