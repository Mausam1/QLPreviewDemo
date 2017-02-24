//
//  QLPreview.swift
//  QLPreviewDemo
//
//  Created by Mausam on 2/15/17.
//  Copyright © 2017 Mausam. All rights reserved.
//

import UIKit
import QuickLook

class QLPreview: QLPreviewController, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    var previewUrl:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: QLPreview delegate methods
    
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        print("Getting item")
        return self.previewUrl as! QLPreviewItem
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
