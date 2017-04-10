//
//  ImageViewController.swift
//  Cassini
//
//  Created by Younoussa Ousmane Abdou on 1/13/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        
        didSet {
            
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    var imageURL: URL? {
        didSet {
            
            image = nil
            
            if view.window != nil {
                
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        
        if let url = imageURL {
            
            spinner?.startAnimating()
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                let contentOfURL = NSData(contentsOf: url)
                
                DispatchQueue.main.async {
                    
                    if url == self.imageURL {
                        
                        if let imageData = contentOfURL {
                            
                            self.image = UIImage(data: imageData as Data)
                        } else {
                            
                            self.spinner?.stopAnimating()
                        }
            
                    }
            
                }
            }
            
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            
            return imageView.image
        }
        set {
            
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if image == nil {
            
            fetchImage()
        }
    }
    
}
