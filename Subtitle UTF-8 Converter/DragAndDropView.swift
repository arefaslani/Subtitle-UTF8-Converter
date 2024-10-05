//
//  DragAndDropView.swift
//  Subtitle UTF-8 Converter
//
//  Created by Aref Aslani on 05.10.24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DragAndDropView: View {
    @State private var dropInfo: String = "Drag and drop files here"
    
    var body: some View {
        VStack {
            Text(dropInfo)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.clear)
                .border(Color.clear, width: 5) // Clear border for the frame
            
            // Create the drop area
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .frame(width: 300, height: 200)
                .background(Color.clear)
                .overlay(
                    Text("Drag & Drop Here")
                        .font(.headline)
                )
                .onDrop(of: [(UTType.fileURL)], delegate: DropViewDelegate(dropInfo: $dropInfo)) // Allow both types
                .padding()
        }
    }
}
