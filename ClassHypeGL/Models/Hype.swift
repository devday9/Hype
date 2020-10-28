//
//  Hype.swift
//  ClassHypeGL
//
//  Created by Deven Day on 10/5/20.
//

import UIKit
import CloudKit

struct HypeStrings {
    static let recordTypeKey = "Hype"
    fileprivate static let bodyKey = "body"
    fileprivate static let timestampKey = "timestamp"
    fileprivate static let userReferenceKey = "userReference"
    fileprivate static let photoAssetKey = "photoAsset"
    
}//END OF STRUCT

class Hype {
    var body: String
    var timestamp: Date
    var recordID: CKRecord.ID
    var userReference: CKRecord.Reference?
    var hypePhoto: UIImage? {
        get {
            guard let data = photoData else {return nil}
            return UIImage(data: data)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var  photoData: Data?
    
    var photoAsset: CKAsset? {
        get {
            guard let data = photoData else {return nil}
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            do {
                try data.write(to: fileURL)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init(body: String, timestamp: Date = Date(), recordID:
            CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), userReference: CKRecord.Reference?, hypePhoto: UIImage? = nil) {
        self.body = body
        self.timestamp = timestamp
        self.recordID = recordID
        self.userReference = userReference
        self.hypePhoto = hypePhoto
    }
}//END OF CLASS

//MARK: - Extensions
/// Hype Extension for failable init
extension Hype {
    
    convenience init?(ckRecord: CKRecord) {
        guard let body = ckRecord[HypeStrings.bodyKey] as? String,
              let timestamp = ckRecord[HypeStrings.timestampKey] as? Date else {return nil}
        
        let reference = ckRecord[HypeStrings.userReferenceKey] as? CKRecord.Reference
        
        var foundPhoto: UIImage?
        
        if let photoAsset = ckRecord[HypeStrings.photoAssetKey] as? CKAsset {
            do {
                let data = try Data(contentsOf: photoAsset.fileURL!)
                foundPhoto = UIImage(data: data)
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        
        self.init(body: body, timestamp: timestamp, recordID: ckRecord.recordID, userReference: reference, hypePhoto: foundPhoto)
    }
}//END OF EXTENSION

/// Hype Extension for equatable
extension Hype: Equatable {
    static func == (lhs: Hype, rhs: Hype) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}//END OF EXTENSION

extension CKRecord {
    convenience init(hype: Hype) {
        self.init(recordType: HypeStrings.recordTypeKey, recordID: hype.recordID)
        
        self.setValuesForKeys([
            HypeStrings.bodyKey : hype.body,
            HypeStrings.timestampKey : hype.timestamp
        ])
        
        if let userReference = hype.userReference {
            setValue(userReference, forKey: HypeStrings.userReferenceKey)
        }
        
        if hype.photoAsset != nil {
            setValue(hype.photoAsset, forKey: HypeStrings.photoAssetKey)
        }
    }
}//END OF EXTENSION
