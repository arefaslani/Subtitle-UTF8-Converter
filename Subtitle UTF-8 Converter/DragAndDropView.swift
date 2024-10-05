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
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .frame(width: 300, height: 200)
                .background(Color.clear)
                .overlay(
                    Text(dropInfo)
                        .font(.headline)
                )
                .onDrop(of: [(UTType.fileURL)], delegate: DropViewDelegate(dropInfo: $dropInfo, showAlert: $showAlert, alertMessage: $alertMessage)) // Allow both types
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(appName), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }
    }
}
