//
//  PhotoLibraryAdapter.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import Photos

class PhotoLibraryAdapter: Adapter {
    let manager = PHImageManager.defaultManager() // TODO make this a caching manager

    func retrieveMetadata(completion: ([Memorable]) -> Void) {
        let assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        var photoMemorables = [Memorable]()
        assets.enumerateObjectsUsingBlock({ (obj, index, stop) in
            // TODO add extension to PHFetchResult so we don't have to enumerate these objects and just add them directly?
            if let asset = obj as? PHAsset {
                photoMemorables.append(MemorablePhoto(adapter: self, metadata: asset, creationDate: asset.creationDate!))
            }
        })
        completion(photoMemorables)
    }

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> Void) {
        manager.requestImageForAsset(source as! PHAsset, targetSize: dimensions, contentMode: .AspectFit, options: nil, resultHandler: { (result, info) -> Void in
            completion(result as UIImage!)
        })
    }
}