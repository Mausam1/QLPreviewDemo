//
//  QLPreviewVC.swift
//  QLPreviewDemo
//
//  Created by Mausam on 2/10/17.
//  Copyright © 2017 Mausam. All rights reserved.
//

import UIKit
import QuickLook

class QLPreviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mainTableView: UITableView!
    var navBar:UINavigationBar?
    var arrayFileList:Array<URL> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        self.navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60))
        self.navBar?.tintColor = UIColor.lightGray
        let navItem = UINavigationItem(title: "Previously Opened Files")
        self.navBar?.items = [navItem]
        self.view.addSubview(navBar!)
        let path = getDocumentsDirectory().appendingPathComponent("Files")
        if let temp = loadListOfFilesFromFolderPath(path: path){
            self.arrayFileList = temp
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.displayLaunchDetails),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func displayLaunchDetails() {
        if appDelegate.url != nil && appDelegate.strSourceApplicationName != ""{
            let fileResult = createFolder(name: "Files")
            if  fileResult.0 == true && fileResult.1 != nil{
                if copyFilesToTheFolder(sourcePath: appDelegate.url!, destinationPath: fileResult.1!){
                    let pathInbox = getDocumentsDirectory().appendingPathComponent("Inbox")
                    _ = removeFilesFromThePath(path: pathInbox)
                    print("appdel url: \(appDelegate.url?.absoluteString)")
                    print("local url: \(fileResult.1!.absoluteString)")
                    appDelegate.strSourceApplicationName = ""
                    let path = getDocumentsDirectory().appendingPathComponent("Files")
                    if let temp = loadListOfFilesFromFolderPath(path: path){
                        self.arrayFileList = temp
                    }
                    let ql = QLPreview()
                    ql.previewUrl = fileResult.1!.appendingPathComponent((appDelegate.url?.lastPathComponent)!)
                    self.present(ql, animated: true, completion: nil)
                    mainTableView.reloadData()
                }
            }
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
    }
    
    //MARK: UITableview delegate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.mainTableView.dequeueReusableCell(withIdentifier: "cell")!
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    private func configureCell(cell: UITableViewCell, indexPath:NSIndexPath){
        cell.textLabel?.text = arrayFileList[indexPath.row].lastPathComponent as String
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ql = QLPreview()
        ql.previewUrl = self.arrayFileList[indexPath.row] as URL?
        print("opening file : \(ql.previewUrl)")
        self.present(ql, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let tempResult = removeFileFromPathAndGetNewList(path: self.arrayFileList[indexPath.row])
            if tempResult.0 == true{
                self.arrayFileList = tempResult.1!
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
            }
        }
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
