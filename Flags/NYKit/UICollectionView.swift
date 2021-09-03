//
//  UICollectionView.swift
//  Fursat
//
//  Created by NY on 31/07/21.
//

import UIKit.UICollectionView

public func makeCollectionView(scrollDirection: UICollectionView.ScrollDirection, itemSize: CGSize = UICollectionViewFlowLayout.automaticSize, spacing: CGFloat = 10, sectionInset: UIEdgeInsets = UIEdgeInsets.zero, showsIndicatior: Bool = false, alwaysBounce: Bool = true) -> UICollectionView {
    
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = itemSize
    layout.estimatedItemSize = itemSize
    layout.scrollDirection = scrollDirection
    layout.minimumInteritemSpacing = spacing
    layout.minimumLineSpacing = spacing
    layout.sectionInset = sectionInset
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.alwaysBounceVertical = scrollDirection == .vertical
    cv.alwaysBounceHorizontal = scrollDirection == .horizontal
    cv.showsVerticalScrollIndicator = showsIndicatior
    cv.showsHorizontalScrollIndicator = showsIndicatior
    cv.contentInset = UIEdgeInsets.zero
    cv.backgroundColor = .clear
    
    return cv
}
