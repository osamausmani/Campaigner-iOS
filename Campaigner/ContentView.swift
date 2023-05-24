import SwiftUI

struct ContentView: View {

    
    @StateObject public var alertService = AlertService()

    var body: some View {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(height: geometry.size.height / 2)
                    
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(height: geometry.size.height / 2)
                }
            }
        }
        

    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
