//
//  DetailViewController.swift
//  flicKI
//
//  Created by Volodymyr Grytsenko on 12.02.2018.
//  Copyright © 2018 Volodymyr Grytsenko. All rights reserved.
//

import UIKit
import LLSpinner

class DetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var metaDataTextView: UITextView!
    
    var photo: Photo?
    var imageProperties: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func shareButtonWasPressed(_ sender: Any) {
        if let image = self.photoImageView.image
        {
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: [])
            self.present(activityController, animated: true)
        }
    }
    @IBAction func infoButtonWasPressed(_ sender: Any) {
        self.metaDataTextView.isHidden = !self.metaDataTextView.isHidden
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.photoImageView.kf.indicatorType = .activity
        self.photoImageView.kf.setImage(with: photo?.imageLink, options: [.transition(.fade(0.2))], completionHandler: {
            (image, error, cacheType, imageUrl) in
            if let image = image {
                let imageData: Data = UIImageJPEGRepresentation(image, 1)!
                
                let cgImgSource: CGImageSource = CGImageSourceCreateWithData(imageData as CFData, nil)!
                if let metadata = CGImageSourceCopyPropertiesAtIndex(cgImgSource, 0, nil) {
                    self.metaDataTextView.text = String(describing: metadata)
                }
            }
        })
        
        self.navigationItem.title = photo?.title

    }
    
    @IBAction func goButtonWasPressed(_ sender: Any) {
        if let link = photo?.link {
            UIApplication.shared.open(link)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
