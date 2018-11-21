//
//  ViewController.swift
//  APM
//
//  Created by Mbongeni NDLOVU on 2018/10/05.
//  Copyright © 2018 mndlovu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageArray: [UIImage] = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    // display alert message
    func createAlert(_ message: String) {
        let msg = "Cannot Access to " + message
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert,animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK : collection delegate

extension ViewController: UICollectionViewDelegate {
    // when you select an image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destVC = mainStoryboard.instantiateViewController(withIdentifier: "MyScrollView") as! MyScrollView
        destVC.image = self.imageArray[indexPath.item]
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}


// MARK : collection dataSource

extension ViewController: UICollectionViewDataSource {
    // number of row
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.images.count
    }
    
    // display cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.spinner.isHidden = false
        cell.spinner.startAnimating()
        let url = URL(string: Data.images[indexPath.item])!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.createAlert(Data.images[indexPath.item])
                return
            }
            DispatchQueue.main.async {
                cell.myImageView.image = UIImage(data: data!)
                cell.spinner.stopAnimating()
                cell.spinner.isHidden = true
                self.imageArray.append(UIImage(data: data!)!)
            }
        }.resume()
        return cell
    }
}

