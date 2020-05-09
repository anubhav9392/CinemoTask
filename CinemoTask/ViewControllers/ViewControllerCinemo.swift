//
//  ViewControllerCinemo.swift
//  CinemoTask
//
//  Created by Vinculum on 6/5/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit

class ViewControllerCinemo: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate {
    
    @IBOutlet weak var tableViewImages: UITableView!
    var imageDataList = [ImageData]()
    var message = "Click on image to share"
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleData() //intial loding of default tiff files locally
        tableViewImages?.delegate = self  // initialization of delegate to tableView
        tableViewImages?.dataSource = self   // initialization of dataSource to tableView
        
        // adding add button on navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectOptions))
        
        // default info message
        featuresImplemeted()
    }
    
    //alert box to select importing of image from gallery or icloud
    @objc func selectOptions(){
        let refreshAlert = UIAlertController(title: "Import image", message: "", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action: UIAlertAction!) in
            self.importPicture()
        }))
        refreshAlert.addAction(UIAlertAction(title: "iCloud", style: .cancel, handler: { (action: UIAlertAction!) in
            self.openiCloudDocuments()
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    // information alert box
    func featuresImplemeted(){
           let refreshAlert = UIAlertController(title: "Information", message: message, preferredStyle: UIAlertController.Style.alert)
           refreshAlert.addAction(UIAlertAction(title: "Thanks", style: .default, handler: { (action: UIAlertAction!) in
           }))
           present(refreshAlert, animated: true, completion: nil)
    }
    
    // alert box with configuarable message
    func alertMessages(message : String){
           let refreshAlert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
           refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
           }))
           present(refreshAlert, animated: true, completion: nil)
    }
    
    // image picker from gallery
    func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // open iCloud to access data
    @objc func openiCloudDocuments(){
        let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    // imagePickerController listener when image is selected from gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        imageDataList.append(ImageData(photo: image)!)
        print(imageDataList.count)
        self.tableViewImages.reloadData()
    }
    
    // documentPicker listner when image selected
     public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let myURL = urls.first else {
                return
            }
        
        let fileName = myURL.lastPathComponent
        
        if(!fileName.contains(".tiff")){
            return self.alertMessages(message: "Please do select only .tiff files")
        }
        
        
        let data = try? Data(contentsOf: myURL)
        if let imageData = data {
            let image = UIImage(data: imageData)
            imageDataList.append(ImageData(photo: image)!)
        }
        self.tableViewImages.reloadData()
    }

    // documentPickerWasCancelled listne when doc picker cancel
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // tableview number of section with default row height
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.rowHeight = 300
        return 1
    }

    // dynamic number of row count in UITableView according to number of images selected
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataList.count
    }

     
    // return of each cell with image on it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellCinemo", for: indexPath) as? TableViewCellCinemo else {
                fatalError("The dequeued cell is not an instance of TableViewCellCinemo.")
           }
           let images = imageDataList[indexPath.row]
           cell.imageViewPanel.image = images.photo
           return cell
    }
    
    // click lister on every cell of UITableView to share image
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = imageDataList[indexPath.item].photo
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
      
    // default load sample data image of tiff format
    private func loadSampleData() {
        for index in 1...4 {
            let imageName = "imaget"+String(index)
            imageDataList.append(ImageData(photo: UIImage(contentsOfFile: Bundle.main.path(forResource: imageName, ofType: "tiff") ?? ""))!)
        }
    }
}
