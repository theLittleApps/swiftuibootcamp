//
//  KeypathsBootcamp.swift
//  swiftuibootcamp
//
//  Created by YEN-JU HUANG on 2025/12/2.
//

import SwiftUI

struct MyDataModel {
    let id = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

struct KeypathsBootcamp: View {
    
    @State private var screenTitle: String = ""
    
    var body: some View {
        Text(screenTitle)
            .onAppear {
                let item = MyDataModel(title: "one", count: 1, date: .now)
                let title = item.title
                let title2 = item[keyPath: \.title]
                screenTitle = title2
                print("value: \($screenTitle)")
            }
    }
}

#Preview {
    KeypathsBootcamp()
}
