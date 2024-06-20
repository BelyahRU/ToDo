//
//  FileManager + Ext.swift
//  ToDo
//
//  Created by Александр Андреев on 20.06.2024.
//

import Foundation
extension FileManager {
    
    public func getUrl(from fileName: String) -> URL? {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentDirectory = urls.first else {
            return nil
        }
        let url = documentDirectory.appendingPathComponent(fileName)
        
        return url
    }
}
