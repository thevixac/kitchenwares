//
//  ShopAisleViewController.swift
//  KitchenWares
//
//  Created by vic on 15/06/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCallback = (UIImage) -> Void
class ShopAisleViewController: UICollectionViewController {
    private let eventHandler: ShopAisleEventHandler
    private var items: [ShopItemDisplayable] = []
    private let padding: CGFloat = 0
    private let flowLayout: UICollectionViewFlowLayout
    private var imageCallbacks: [String: ImageCallback] = [:]
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
        cell.update(title: item.title, price: item.price, identifier: item.productId)
        imageCallbacks[item.productId] = { [weak cell] image in
            guard let cell = cell else { return }
            cell.setImage(image: image)
        }
        eventHandler.itemWillAppear(item: item)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Tell eventHandler about productId of selected.
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
        return CGSize(width: (width / columns) - (padding * columns * 2.0), height: 350)
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
    func display(items: [ShopItemDisplayable]) {
        self.items = items
        DispatchQueue.main.async {
            self.title = "Dishwashers (\(items.count))"
            self.collectionView?.reloadData()
        }
    }
    
    func displayImage(identifier: String, image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            guard let cb = self.imageCallbacks[identifier] else { return }
            cb(image)
        }
    }
}
