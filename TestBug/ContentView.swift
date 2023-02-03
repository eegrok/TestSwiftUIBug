//
//  ContentView.swift
//  TestBug
//
//  Created by Kem Mason on 4/02/23.
//

import SwiftUI

struct MyItem: Identifiable {
    let id = UUID()
    let name: String
}

struct ContentView: View {
  @State private var selection: MyItem? = nil
    var body: some View {
      VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundColor(.accentColor)
        Text("Hello, world!")
        Button("Open Sheet") {
          self.selection = MyItem(name: "blah")
        }
        .sheet(item: $selection,
               onDismiss: { print("finished!") },
               content: { MySheet(item: $0) })
      
        }
        .padding()
    }
}

struct MySheet: View {
  let item: MyItem
  	@State private var day: String = ""
    @Environment (\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
          Spacer()
          Text("Item: \(item.name)")
          Menu(content: menuContents, label: menuLabel)
              .frame(width: 200)
            Text("Drag down to dismiss..., or")
          Spacer()
            Text("Tap to Dismiss")
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
            }
					Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
        .edgesIgnoringSafeArea(.all)
    }
  @ViewBuilder func menuContents() -> some View {
      Button("All Days") { self.day = "All Days"}
      
      Menu("Working Day") {
          Button("Monday") { self.day = "Monday" }
          Button("Tuesday") { self.day = "Tuesday" }
          Button("Wednesday") { self.day = "Wednesday" }
          Button("Thursday") { self.day = "Thursday" }
          Button("Friday") { self.day = "Friday" }
      }
      
      // This view is required to avoid SwiftUI merging menus "Working Day" and "Weekend"
      Color.clear.frame(width: 1, height: 1)
      
      Menu("Weekend") {
          Button("Saturday") { self.day = "Saturday" }
          Button("Sunday") { self.day = "Sunday" }
      }
  }
  
  @ViewBuilder func menuLabel() -> some View {
      HStack {
          Image(systemName: "calendar")
          
          Text("Select Day")
      }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
