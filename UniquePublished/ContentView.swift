//
//  ContentView.swift
//  UniquePublished
//
//  Created by Oskar Groth on 2021-04-22.
//

import SwiftUI

class MyState: ObservableObject {
    
    @UniquePublished var uniqueState: Int = 0
    @Published var normalState: Int = 0
    
}

struct ContentView: View {
    
    @StateObject var state = MyState()
    @State var unique = false
    
    var body: some View {
        VStack {
            Text("\(unique ? state.uniqueState : state.normalState)")
                .font(.title)
            Toggle("Unique", isOn: $unique)
            HStack {
                ForEach(1..<4) { number in
                    Button("\(number)") {
                        if unique {
                            state.uniqueState = number
                        } else {
                            state.normalState = number
                        }
                    }
                }
            }
        }
        .padding(100)
        .background(Color.random.opacity(0.2))
    }

}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
