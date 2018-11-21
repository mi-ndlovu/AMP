//
//  MyScrollView.swift
//  APM
//
//  Created by Mbongeni NDLOVU on 2018/10/05.
//  Copyright © 2018 mndlovu. All rights reserved.
//

import UIKit

class MyScrollView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        imageView.image = image
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size
        scrollView.maximumZoomScale = 100
        scrollView.minimumZoomScale = 0.3
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
