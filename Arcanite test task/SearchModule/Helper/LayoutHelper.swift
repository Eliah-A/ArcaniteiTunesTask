//
//  LayoutHelper.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation
import UIKit

class LayoutHelper {
    static let shared = LayoutHelper()
    
    private init() {}
    
    func collectionViewCellSize(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 76)
    }
    
    func collectionViewSectionInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
    }
    
    func collectionViewLineSpacing() -> CGFloat {
        return 8
    }
}
