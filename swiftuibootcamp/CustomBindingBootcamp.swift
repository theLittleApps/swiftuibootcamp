//
//  CustomBindingBootcamp.swift
//  swiftuibootcamp
//
//  Created by YEN-JU HUANG on 2025/11/27.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
    
//    init(value: Binding<String?>) {
//        self.init {
//            value.wrappedValue != nil
//        } set: { newValue in
//            if !newValue {
//                value.wrappedValue = nil
//            }
//            
//        }
//    }
}

struct CustomBindingBootcamp: View {
    
    @State var title: String = "Start Binding"
    
    // use custom binding to simplfy it
    @State private var errorTitle: String?
//    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            Text(title)
            ChildView(title: $title)
            ChildView2(title: title) { newTitle in
                title = newTitle
            }
            ChildView3(title: $title)
            ChildView3(title: Binding(get: {
                return title
            }, set: { newValue in
                title = newValue
            }))
            
            Button("CLICK ME") {
                errorTitle = "NEW ERROR!!!!"
//                showError.toggle()
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
        }
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            Button("OK") {
                
            }
        }
//        .alert(errorTitle ?? "Error", isPresented: Binding(get: {
//            errorTitle != nil
//        }, set: { newValue in
//            if !newValue {
//                errorTitle = nil
//            }
//        })) {
//            Button("OK") {
//                
//            }
//        }
//        .alert(errorTitle ?? "Error", isPresented: $showError) {
//            Button("OK") {
//                
//            }
//        }
    }
}

// using binding wrapper @Binding that get/set property automatically
struct ChildView: View {
    
    @Binding var title: String
    
    var body: some View {
        VStack {
            Text(title)
            
            Button("Change Title 1") {
                title = "New Binding 1"
            }
            .font(.title)
            .buttonStyle(.bordered)
        }
        
    }
}

// manually get/set property
struct ChildView2: View {
    
    let title: String
    let setTitle: (String) -> Void
    
    var body: some View {
        VStack {
            Text(title)
            
            Button("Change Title 2") {
                setTitle("New Binding 2")
            }
            .font(.title)
            .buttonStyle(.bordered)
        }
    }
}

// declare binding directly
struct ChildView3: View {
    
    let title: Binding<String>
    
    var body: some View {
        VStack {
            Text(title.wrappedValue)
            
            Button("Change Title 3") {
                title.wrappedValue = "New Binding 3"
            }
            .font(.title)
            .buttonStyle(.bordered)
        }
    }
    
}

#Preview {
    CustomBindingBootcamp()
}
