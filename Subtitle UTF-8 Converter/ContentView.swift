//
//  ContentView.swift
//  Subtitle UTF-8 Converter
//
//  Created by Aref Aslani on 03.10.24.
//

import SwiftUI

let appName = "Subtitle UTF-8 Converter"

struct ContentView: View {
    var body: some View {
        VStack {
            DragAndDropView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
