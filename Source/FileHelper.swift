//
//  FileHelper.swift
//  PrefsMate
//
//  Created by 蔡越 on 07/10/2017.
//

import UIKit

class FileHelper {
    
    // MARK: - Singleton
    
    static let `default` = FileHelper()
    
    // MARK: - Functions that related to file transfer
    
    /// Return the transferredUrl in Document directory against the given originUrl
    func destinationUrl(from originUrl: URL) throws -> URL {
        let fileManager = FileManager.default
        let originLastComponent = originUrl.lastPathComponent
        let documentDir = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let destinationUrl = documentDir.appendingPathComponent(originLastComponent)
        return destinationUrl
    }
    
    /// Transfer the data of originUrl and write to destinationUrl, for the very first time. Otherwise
    /// Return the data of destinationUrl.
    func transferFileFrom(_ originUrl: URL) throws -> Data {
        
        let fileManager = FileManager.default
        let destinationUrl = try FileHelper.default.destinationUrl(from: originUrl)
        
        // If the file already exists in given path, return
        if fileManager.fileExists(atPath: destinationUrl.path) {
            let data = try Data(contentsOf: destinationUrl)
            return data
        }
        
        // If not exists, copy the origin file content and write to destination URL
        let data = try Data(contentsOf: originUrl)
        try data.write(to: destinationUrl)
        return data
    }
}
