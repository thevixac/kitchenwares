//
//  ShopAisleViewController.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit

class ShopAisleViewController: UICollectionViewController {
    private let eventHandler: ShopAisleEventHandler
    private var items: [ShopItem] = []
    private let padding: CGFloat = 0
    private let flowLayout: UICollectionViewFlowLayout
    private var idMap: [String: Int] = [:]
    init(eventHandler: ShopAisleEventHandler) {
        self.eventHandler = eventHandler
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle(for: ShopAisleCell.self)
        collectionView?.register(UINib(nibName: "ShopAisleCell", bundle: bundle), forCellWithReuseIdentifier: ShopAisleCell.id)
        title = "Dishwashers"
        view.backgroundColor = .white
        collectionView?.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        view.setNeedsUpdateConstraints()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopAisleCell.id, for: indexPath) as? ShopAisleCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.row]
        cell.update(title: item.title, price: String(item.price), identifier: item.productId)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? ShopAisleCell else {
            return
        }
        guard let productId = cell.cellIdentifer() else {
            return
        }
        guard let row = idMap[productId] else {
            return
        }
        //VXTODO do we need this
        guard items.count > row else  {
            return
        }
        let item = items[row]
        eventHandler.itemWillAppear(item: item)
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //VXTODO tell eventHandler about productId of selected.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        flowLayout.itemSize = getCellSize()
        flowLayout.invalidateLayout()
    }
    private func getCellSize() -> CGSize {
        let orientation = UIDevice.current.orientation
        guard let collectionView = collectionView else {
            return .zero
        }
        let fullWidth = collectionView.bounds.width
        if isPad {
            
            if orientation == .landscapeLeft || orientation == .landscapeRight {
                return getCellSize(columns: 4, from: fullWidth)
            } else {
                return getCellSize(columns: 2, from: fullWidth)
            }
        } else {
            if orientation == .landscapeLeft || orientation == .landscapeRight {
                return getCellSize(columns: 1, from: view.bounds.width)
            }
            return getCellSize(columns: 1, from: min(view.bounds.width, view.bounds.height))
        }
    }
    private func getCellSize(columns: CGFloat, from width: CGFloat) -> CGSize {
        return CGSize(width: (width / columns) - (padding * columns * 2.0), height: 300)
    }
}

extension ShopAisleViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return getCellSize()
    }
 
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
 
extension ShopAisleViewController: ShopAisleView {
    func display(items: [ShopItem]) {
        
        self.items = items
        for (index, item) in items.enumerated() {
            idMap[item.productId] = index
        }

        DispatchQueue.main.async {
            self.title = "Dishwashers (\(items.count))"
            self.collectionView?.reloadData()
        }
    }
    
    func displayImage(productId: ProductId, image: UIImage) {
        guard let row = idMap[productId] else {
            return
        }
        guard let cell = collectionView?.cellForItem(at: IndexPath(row: row, section: 0)) as? ShopAisleCell else {
            return
        }
        cell.setImage(image: image)
    }
}
