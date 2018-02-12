//
//  MainTableViewController.swift
//  flicKI
//
//  Created by Volodymyr Grytsenko on 10.02.2018.
//  Copyright © 2018 Volodymyr Grytsenko. All rights reserved.
//

import UIKit
import Kingfisher
import LLSpinner

class MainTableViewController: UITableViewController  {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var model: [(filters: String,photos: [Photo])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addNewRowWithFilters(filters: String)
    {
        LLSpinner.style = .whiteLarge
        LLSpinner.spin()
        NetworkHandler.getPublicFeedPhoto(filters: filters, completion: { (photos) in
            self.model.append((filters: filters, photos: photos))
            DispatchQueue.main.async {
                LLSpinner.stop()
                self.tableView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photo = sender as? Photo,
            let detailView = segue.destination as? DetailViewController
        {
            detailView.photo = photo
        }
    }
}

extension MainTableViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionViewCell", for: indexPath)
        guard let collectionCell = cell as? CollectionTableViewCell else{
            return cell
        }
        collectionCell.filtersLabel.text = self.model[indexPath.row].filters
        return collectionCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? CollectionTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model[collectionView.tag].photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell",
                                                      for: indexPath)
        if let photoCell = cell as? PhotoCollectionViewCell
        {
            let photo = self.model[collectionView.tag].photos[indexPath.item]
            
            photoCell.photoImageView.kf.indicatorType = .activity
            photoCell.photoImageView.kf.setImage(with: photo.imagePreviewLink, options: [.transition(.fade(0.2))])
            photoCell.photoName.text = photo.title
            return photoCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailViewSegue", sender: self.model[collectionView.tag].photos[indexPath.row])
    }
    
}

extension MainTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.searchTextField {
            self.addNewRowWithFilters(filters: textField.text!)
            textField.resignFirstResponder()
            textField.text = ""
            return false
        }
        return true
    }
}
