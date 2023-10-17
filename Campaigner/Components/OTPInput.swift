import SwiftUI

struct OTPInput: View {
    @State private var otp: String = ""
    @State private var isOTPCorrect: Bool = false
    
    var onOTPCorrect: (String) -> Void
    
    @State private var digitTextFields: [UITextField] = []
    
    var body: some View {
        VStack {
            Text("Enter OTP")
                .font(.title)
            
            HStack(spacing: 10) {
                ForEach(0..<4) { index in
                    DigitTextField(text: $otp)
                                        .frame(width: 50, height: 50)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                }
            }
        }
        .onChange(of: otp, perform: { code in
            if code.count == 4 {
                isOTPCorrect = true
                onOTPCorrect(code)
            } else {
                isOTPCorrect = false
            }
        })
    }
    
    private func digitBinding(_ index: Int) -> Binding<String> {
        let digitIndex = otp.index(otp.startIndex, offsetBy: index, limitedBy: otp.endIndex) ?? otp.endIndex
        let digit: String
        
        if otp.indices.contains(digitIndex) {
            digit = String(otp[digitIndex])
        } else {
            digit = ""
        }
        
        return Binding<String>(
            get: { digit },
            set: { newValue in
                if newValue.count <= 1 {
                    if otp.indices.contains(digitIndex) {
                        otp.replaceSubrange(digitIndex...digitIndex, with: newValue)
                    } else {
                        otp.insert(contentsOf: newValue, at: digitIndex)
                    }
                    
                    if newValue.count == 1 && index < 3 {
                        DispatchQueue.main.async {
                            let nextIndex = otp.index(digitIndex, offsetBy: 1)
                            let nextTextField = digitTextFields[index + 1]
                            nextTextField.becomeFirstResponder()
                        }
                    }
                }
            }
        )
    }
}
