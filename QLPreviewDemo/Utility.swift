//
//  Utility.swift
//  QLPreviewDemo
//
//  Created by Mausam on 2/13/17.
//  Copyright © 2017 Mausam. All rights reserved.
//

import Foundation
import UIKit

let fileManager = FileManager.default
let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

func createAlertWithOnlyOkay(title:String?, msg:String, style:UIAlertControllerStyle, callBackSelf:UIViewController) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: msg, preferredStyle: style)
    
    let cancelAction = UIAlertAction(title: "Okay", style: .cancel) { action in
        callBackSelf.dismiss(animated: true, completion: {
        })
    }
    alertController.addAction(cancelAction)
    return alertController
}


func getDocumentsDirectory() -> URL {
    let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

func createFolder(name:String) -> (Bool,URL?) {
    
    do {
        let dataPath = getDocumentsDirectory().appendingPathComponent(name)
        print("dataPath : \(dataPath.absoluteString)\n")
        if !FileManager.default.fileExists(atPath: (dataPath.absoluteString)) {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        }
        return (true,dataPath)
    } catch let error as NSError {
        print(error.localizedDescription);
        return (false,nil)
    }
}

func copyFilesToTheFolder(sourcePath:URL,destinationPath:URL)->Bool{
    do{
        let sourceFileData = try Data(contentsOf: sourcePath)
        let finalDestinationPath = destinationPath.appendingPathComponent(sourcePath.lastPathComponent)
        try sourceFileData.write(to: finalDestinationPath, options: .atomicWrite)
        return true
    }
    catch let error as NSError {
        print(error.localizedDescription);
        return false
    }
}

func removeFilesFromThePath(path:URL)->Bool{
    do{
        let arrayFiles = loadListOfFilesFromFolderPath(path: path)
        for url in arrayFiles!{
            try fileManager.removeItem(at: url)
        }
        return true
    }
    catch let error as NSError {
        print(error.localizedDescription);
        return false
    }
}

func removeFileFromPathAndGetNewList(path:URL)->(Bool,[URL]?){
    do{
    try fileManager.removeItem(at: path)
        var tempPath = path
        tempPath.deleteLastPathComponent()
        return (true,loadListOfFilesFromFolderPath(path: tempPath))
    }
    catch let error as NSError {
        print(error.localizedDescription);
        return (false,nil)
    }
}

func loadListOfFilesFromFolderPath(path:URL)->[URL]?{
    var urls : [NSURL] = []
    let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: path.path)!
    while let element = enumerator.nextObject() as? String {
        urls.append(path.appendingPathComponent(element) as NSURL)
    }
    return urls as Array<URL>?
}

extension UIViewController{
    
    
}

