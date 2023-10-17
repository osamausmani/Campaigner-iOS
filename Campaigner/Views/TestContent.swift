import SwiftUI


import SwiftUI

struct TestContent: View {
    var body: some View {
        NavigationView {
            TabView {
                // Tab 1
                Text("Tab 1")
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("Tab 1")
                    }
                
                // Tab 2
                Text("Tab 2")
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Tab 2")
                    }
                
                // Tab 3
                Text("Tab 3")
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Tab 3")
                    }
            }
            .navigationBarTitle("Tabs at Top", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // This positions the tabs at the top
    }
}



struct TestContent_Previews: PreviewProvider {
    static var previews: some View {
        TestContent()
    }
}
