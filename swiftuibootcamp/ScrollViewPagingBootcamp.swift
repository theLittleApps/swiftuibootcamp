//
//  ScrollViewPagingBootcamp.swift
//  swiftuibootcamp
//
//  Created by YEN-JU HUANG on 2026/6/18.
//

import SwiftUI

struct ScrollViewPagingBootcamp: View {
    
    @State private var scrollPosition: Int? = nil
    
    var body: some View {
        VStack {
            Button("SCROLL TO") {
                scrollPosition = (0..<20).randomElement()
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(0..<20) { index in
                        Rectangle()
                            .frame(width: 300, height: 300)
                            .cornerRadius(10)
                            .overlay {
                                Text("\(index)")
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .id(index)
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.2)
//                                    .offset(y: phase.isIdentity ? 0 : -100)
                            }
//                            .containerRelativeFrame(.horizontal, alignment: .center)
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
    //        .scrollTargetBehavior(.paging)
            .scrollTargetBehavior(.viewAligned)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .animation(.smooth, value: scrollPosition)
        }
        
// TikTok like interface
//        ScrollView {
//            VStack(spacing: 0) {
//                ForEach(0..<20) { index in
//                    Rectangle()
//                        .overlay {
//                            Text("\(index)")
//                                .foregroundStyle(.white)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .containerRelativeFrame(.vertical, alignment: .center)
//                }
//            }
//        }
//        .ignoresSafeArea()
//        .scrollTargetLayout()
//        .scrollTargetBehavior(.paging)
//        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    ScrollViewPagingBootcamp()
}
