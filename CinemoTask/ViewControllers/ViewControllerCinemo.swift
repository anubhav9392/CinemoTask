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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleData()
        tableViewImages?.delegate = self
        tableViewImages?.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectOptions))
    }
    
    @objc func selectOptions(){
        let refreshAlert = UIAlertController(title: "Import image", message: "", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Gallary", style: .default, handler: { (action: UIAlertAction!) in
            self.importPicture()
        }))
        refreshAlert.addAction(UIAlertAction(title: "iCloud", style: .cancel, handler: { (action: UIAlertAction!) in
            self.openiCloudDocuments()
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func openiCloudDocuments(){
        let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        imageDataList.append(ImageData(photo: image)!)
        print(imageDataList.count)
        self.tableViewImages.reloadData()
    }
    
     public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let myURL = urls.first else {
                return
            }
        let data = try? Data(contentsOf: myURL)
        if let imageData = data {
            let image = UIImage(data: imageData)
            imageDataList.append(ImageData(photo: image)!)
        }
        self.tableViewImages.reloadData()
    }


    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.rowHeight = 300
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataList.count
    }

     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellCinemo", for: indexPath) as? TableViewCellCinemo else {
                fatalError("The dequeued cell is not an instance of TableViewCellCinemo.")
           }
           let images = imageDataList[indexPath.row]
           cell.imageViewPanel.image = images.photo
           return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = imageDataList[indexPath.item].photo
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
      
    private func loadSampleData() {
        for index in 1...3 {
            let imageName = "imaget"+String(index)
            imageDataList.append(ImageData(photo: UIImage(contentsOfFile: Bundle.main.path(forResource: imageName, ofType: "tiff") ?? ""))!)
        }
    }
}
