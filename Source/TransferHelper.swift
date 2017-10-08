//
//  TransferHelper.swift
//  PrefsMate
//
//  Created by 蔡越 on 07/10/2017.
//

import UIKit

/// Due to the limitation of the sandbox mechanism in iOS, we can only read the plist
/// file in the bundle. We can not WRITE to it.
/// So we transfer the plist file from the bundle to the Document directory, then we can
/// read and write it for free.
/// And, a specific situation is taken into consideration: when the plist file in the
/// bundle is updated. So we created a "source/" subdirectory in Document directory to
/// record the last one plist file in the bundle. And when bundle file is updated, both
/// the file in Document directory and "source/" subdirectory should be updated too.

/// For the convenience of explanation, the following test cases are listed:
/// 1. the plist file is created both in the Document directory and "source/" subdirectory
/// for the very first time.
/// 2. when user update the plist file in the Document directory(e.g. change the switch status), the change is persisted in
/// the file.
/// 3. when the plist file in the bundle is updated, it should trigger the update of
/// "source/" and the file in the Document directory.

class TransferHelper {
    
    // MARK: - Singleton
    
    public static let `default` = TransferHelper()
    private let fileManager = FileManager.default
    
    private lazy var sourceDir: URL = {
        let destinationDir = documentDir.appendingPathComponent("source/")
        return destinationDir
    }()
    
    public lazy var documentDir: URL = {
        return try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }()
    
    // MARK: - Functions that related to file transfer
    
    /// The plist file in the "source/" subdirectory should always keep the same to the current
    /// plist file in the bundle. The plist file in the Document directory also need to sync
    /// when the plist file in the bundle is updated.
    private func storeOriginFile(from originUrl: URL) throws {
        if !fileManager.fileExists(atPath: sourceDir.path) {
            try fileManager.createDirectory(atPath: sourceDir.path, withIntermediateDirectories: false, attributes: nil)
        }
        
        let destinationUrl = sourceDir.appendingPathComponent(originUrl.lastPathComponent)
        if !fileManager.contentsEqual(atPath: destinationUrl.path, andPath: originUrl.path) {
            let data = try Data(contentsOf: originUrl)
            try data.write(to: destinationUrl)
            try data.write(to: documentDir.appendingPathComponent(originUrl.lastPathComponent))
        }
        
        return
    }
    
    
    public func transferFile(from originUrl: URL) throws -> Data {
        let destinationUrl = documentDir.appendingPathComponent(originUrl.lastPathComponent)
        do {
            try TransferHelper.default.storeOriginFile(from: originUrl)
        } catch {
            print(error.localizedDescription)
        }
        
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
