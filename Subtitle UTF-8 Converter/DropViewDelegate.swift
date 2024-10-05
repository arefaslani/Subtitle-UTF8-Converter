//
//  DropViewDelegate.swift
//  Subtitle UTF-8 Converter
//
//  Created by Aref Aslani on 05.10.24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DropViewDelegate: DropDelegate {
    @Binding var dropInfo: String
    
    func validateDrop(info: DropInfo) -> Bool {
        return info.hasItemsConforming(to: ["public.file-url"]) // Check both types
    }
    
    func dropEntered(info: DropInfo) {
        dropInfo = "Release to drop"
    }
    
    func dropExited(info: DropInfo) {
        dropInfo = "Drag and drop files here"
    }
    
    func performDrop(info: DropInfo) -> Bool {
        // Extract the first file URL from the drop
        if let itemProvider = info.itemProviders(for: [UTType.fileURL]).first {
            itemProvider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { (item, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        dropInfo = "Error: \(error.localizedDescription)"
                        return
                    }
                    
                    // Handle if the item is a URL
                    if let url = item as? URL {
                        if url.pathExtension.lowercased() == "srt" {
                            dropInfo = "File encoding is being processed..."
                            writeUTFEncoded(to: url)
                        } else {
                            dropInfo = "Dropped file is not an SRT file."
                        }
                        
                    }
                    // Handle if the item is raw data (_NSSwiftData)
                    else if let data = item as? Data, let urlString = String(data: data, encoding: .utf8), let url = URL(string: urlString) {
                        if url.pathExtension.lowercased() == "srt" {
                            dropInfo = "File encoding is being processed..."
                            writeUTFEncoded(to: url)
                        } else {
                            dropInfo = "Dropped file is not an SRT file."
                        }
                    } else if let data = item {
                        dropInfo = "Dropped item is not a URL. Type: \(type(of: data))"
                    } else {
                        dropInfo = "No valid item received"
                    }
                }
            }
            return true
        }
        
        dropInfo = "No valid file dropped"
        return false
    }
    
    // Function to convert file encoding
    private func writeUTFEncoded(to url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let usedEncoding: String.Encoding = .utf8
            if let _ = String(data: data, encoding: usedEncoding) {
                if usedEncoding == .utf8 {
                    return
                }
            }
            let stringContents = Windows1256.convert(data)
            try stringContents.write(to: url, atomically: true, encoding: .utf8)
        }
        catch {
            print("ERROR")
        }
    }
}
