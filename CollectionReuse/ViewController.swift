//
//  ViewController.swift
//  CollectionReuse
//
//  Created by Antoni on 14/11/19.
//  Copyright © 2019 aiwiguna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    var headerView:CustomCollectionReusableView?
    
    var headerItems:[Int] = []{
        didSet{
            DispatchQueue.main.async {
                self.headerView?.collectionView.reloadData()
            }
        }
    }
    
    var items:[Int] = []{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func addHeaderCell(_ sender: Any) {
        headerItems.append(0)
    }
    @IBAction func addCell(_ sender: Any) {
        items.append(0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return items.count
        }else{
            return headerItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CustomCollectionReusableView
            self.headerView = headerView
            headerView.collectionView.delegate = self
            headerView.collectionView.dataSource = self
            return headerView
        default:
        return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath)
            return cell        }
    }
    

}

