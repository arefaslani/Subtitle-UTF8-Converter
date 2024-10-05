//
//  DropViewDelegate.swift
//  Subtitle UTF-8 Converter
//
//  Created by Aref Aslani on 05.10.24.
//

import SwiftUI
import UniformTypeIdentifiers
import AppKit

struct DropViewDelegate: DropDelegate {
    @Binding var dropInfo: String
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
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
                        alertMessage = "Error: \(error.localizedDescription)"
                        showAlert = true
                        return
                    }
                    
                    // Handle if the item is a URL
                    if let url = item as? URL {
                        if url.pathExtension.lowercased() == "srt" {
                            dropInfo = "File encoding is being processed..."
                            writeUTFEncoded(to: url)
                        } else {
                            alertMessage = "Dropped file is not an SRT file."
                            showAlert = true
                        }
                        
                    }
                    // Handle if the item is raw data (_NSSwiftData)
                    else if let data = item as? Data, let urlString = String(data: data, encoding: .utf8), let url = URL(string: urlString) {
                        if url.pathExtension.lowercased() == "srt" {
                            dropInfo = "File encoding is being processed..."
                            writeUTFEncoded(to: url)
                        } else {
                            alertMessage = "Dropped file is not an SRT file."
                            showAlert = true
                        }
                    } else if let data = item {
                        alertMessage = "Dropped item is not a URL. Type: \(type(of: data))"
                        showAlert = true
                    } else {
                        alertMessage = "No valid item received"
                        showAlert = true
                    }
                }
            }
            return true
        }
        
        alertMessage = "No valid file dropped"
        showAlert = true
        return false
    }
    
    // Function to convert file encoding
    private func writeUTFEncoded(to url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let usedEncoding: String.Encoding = .utf8
            if let _ = String(data: data, encoding: usedEncoding) {
                if usedEncoding == .utf8 {
                    alertMessage = "File is already UTF-8 encoded."
                    showAlert = true
                    return
                }
            }
            let stringContents = Windows1256.convert(data)
            
            guard !stringContents.isEmpty else {
                alertMessage = "Failed to convert file content."
                showAlert = true
                return
            }
            
            // Show the save dialog to the user before overwriting the file
            let savePanel = NSSavePanel()
            savePanel.directoryURL = url.deletingLastPathComponent() // Set the default directory to the current file location
            savePanel.nameFieldStringValue = url.lastPathComponent    // Default file name
            savePanel.prompt = "Save"
            
            // Define a custom UTType for .srt
            let srtUTType = UTType(filenameExtension: "srt") ?? UTType.plainText
            savePanel.allowedContentTypes = [srtUTType]
            
            DispatchQueue.main.async {
                savePanel.begin { response in
                    if response == .OK, let saveUrl = savePanel.url {
                        do {
                            try stringContents.write(to: saveUrl, atomically: true, encoding: .utf8)
                            alertMessage = "File successfully converted and saved."
                            showAlert = true
                        }
                        catch {
                            alertMessage = "Error during file conversion: \(error.localizedDescription)"
                            showAlert = true
                        }
                    }
                }
            }
        }
        catch {
            alertMessage = "Error during file conversion: \(error.localizedDescription)"
            showAlert = true
        }
    }
}
