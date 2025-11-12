//
//  ViewBuilderBootcamp.swift
//  swiftuibootcamp
//
//  Created by YEN-JU HUANG on 2025/11/12.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            if let description {
                Text(description)
                    .font(.callout)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content:View>: View {
    
    let title: String
    let content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric2<Content:View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "New Title", description: "Hello!")
            
            HeaderViewRegular(title: "Another Title", description: nil)
            
            HeaderViewGeneric(title: "Generic Title", content: Text("hello swift"))
            
            HeaderViewGeneric(title: "Generic 2", content: Image(systemName: "heart.fill"))
            
            HeaderViewGeneric(title: "Generic 3", content: HStack{
                Text("Hello")
                Image(systemName: "bolt.fill")
            })
            
            HeaderViewGeneric2(title: "Generic with @ViewBuilder") {
                VStack {
                    Text("Hello")
                    Image(systemName: "heart.fill")
                }
            }
            
            Spacer()
        }
    }
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder
    private var headerSection: some View {
        if type == .one {
            viewOne
        } else if type == .two {
            viewTwo
        } else if type == .three {
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("one!")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("two!")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}

#Preview {
    VStack {
        ViewBuilderBootcamp()
        
        LocalViewBuilder(type: .two)
    }
    
}
