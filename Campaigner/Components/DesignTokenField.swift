//
//  DesignTokenField.swift
//  Campaigner
//
//  Created by Macbook  on 03/07/2023.
//


import SwiftUI

/// A custom SwiftUI view representing a field for entering design tokens.
public struct DesignTokenField: View {
    
    private let size: Int
    
    private let isSecured: Bool
    
    private let emptyField: String = " "
    
    @State private var current: Int = 0
    
    @State private var text: String = ""
    
    @Binding private var token: String
    
    /// Initializes a new instance of `DesignTokenField` with the specified size.
    /// - Parameter size: The number of token fields.
    public init(
        size: Int,
        isSecured: Bool = false,
        token: Binding<String>
    ) {
        self.size = size
        self.isSecured = isSecured
        
        _token = token
    }
    
    /// The view hierarchy of the `DesignTokenField`.
    public var body: some View {
        HStack(spacing: DesignTokenDimen.leading) {
            let items = Array(0...(size - 1)).enumerated()
            ForEach(Array(items), id: \.offset) { item in
                renderTokenField(item.offset)
            }
        }
    }
    
    @ViewBuilder private func renderTokenField(_ offset: Int) -> some View {
        if (current == offset) {
            renderTextField(offset)
        } else {
            renderText(offset)
        }
    }
    
    @ViewBuilder private func renderTextField(_ offset: Int) -> some View {
        DesignToken(
            index: offset,
            label: getTokenValue(offset),
            isSecured: isSecured,
            text: $text.onChange(offset, onUpdate)
        ).font(.subheadline)
    }
    
    private func getToken(_ offset: Int) -> String {
        if (offset < token.count) {
            return token.stringAt(offset)
        }
        return emptyField
    }
    
    private func getTokenValue(_ offset: Int) -> String {
        let token = getToken(offset)
        return (isSecured && token != emptyField) ? "\u{2022}" : token
    }
    
    @ViewBuilder private func renderText(_ offset: Int) -> some View {
        Text(getTokenValue(offset))
            .font(.subheadline)
            .frame(maxWidth: .infinity, maxHeight: DesignTokenDimen.height)
            .overlay(background)
            .onTapGesture {
                current = min(offset, token.count)
            }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: DesignTokenDimen.radius)
            .stroke(
              //  DesignColor.border,
             //   lineWidth: DesignTokenDimen.lineWidth
            )
    }
    
    private func onUpdate(_ value: String, index: Int) {
        current = (index + 1) % size
        token = token.insertOrReplace(index, value.first!)
    }
}

/// A custom text field view.
struct DesignToken: View {
    private let index: Int
    private let label: String
    private let isSecured: Bool
    @Binding var text: String
    @State private var token: String = ""
    @FocusState private var isFocused: Bool

    /// Initializes a new instance of `DesignToken`.
    /// - Parameters:
    ///   - index: The view index.
    ///   - label: The label for the text field.
    ///   - text: The binding for the text field's text value.
    init(index: Int, label: String, isSecured: Bool, text: Binding<String>) {
        self.index = index
        self.label = label
        self.isSecured = isSecured
        _text = text
    }

    public var body: some View {
        ZStack {
            if isSecured {
                securedField
            } else {
                textField
            }
        }.frame(height: DesignTokenDimen.height)
            .overlay(background)
    }
    
    private var textField: some View {
        TextField(
            label,
            text: $token.onChange(index, onUpdate),
            prompt: prompt
        ).keyboardType(.numberPad)
            .frame(maxWidth: .infinity)
            .applyTokenStyle()
            .focused($isFocused)
            .multilineTextAlignment(.center).onAppear {
                isFocused = true
            }
    }
    
    private var prompt: Text {
        Text(label)
            .font(.subheadline)
           // .foregroundColor(DesignColor.text)
    }

    private var securedField: some View {
        SecureField(label, text: $token.onChange(index, onUpdate))
            .keyboardType(.numberPad)
            .frame(maxWidth: .infinity)
            .applyTokenStyle()
            .focused($isFocused)
            .multilineTextAlignment(.center).onAppear {
                isFocused = true
            }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: DesignTokenDimen.radius)
            .stroke(
              //  DesignColor.accentVarient,
              //  lineWidth: DesignTokenDimen.lineWidth
            )
    }
    
    private func onUpdate(_ value: String, index: Int) {
        if (value.isEmpty) {
            return
        }
        if (Int(value) == nil) {
            token = ""
        } else {
            text = value
        }
    }
}

/// A class to hold the dimensions for the `DesignTokenField`.
struct DesignTokenDimen {
    static let radius: CGFloat = 18
    static let height: CGFloat = 56
    static let padding: CGFloat = 24
    static let leading: CGFloat = 8
    static let lineWidth: CGFloat = 1
}

extension String {
    func stringAt(_ i: Int) -> String {
        return String(Array(self)[i])
    }
    
    func insertOrReplace(_ index: Int, _ value: Character) -> String {
        if (count <= index) {
            return "\(self)\(value)"
        }
        return replace(index, value)
    }
    
    private func replace(_ index: Int, _ value: Character) -> String {
        var chars = Array(self)
        self.enumerated().forEach { (key, entry) in
            if (key == index) {
                chars[key] = value
            } else {
                chars[key] = entry
            }
        }
        return String(chars)
    }
}

extension View {
    /// Applies the common style properties to the `DesignTextField`.
    internal func applyTokenStyle() -> some View {
        self
            .autocapitalization(.none)
            .font(.subheadline)
         //12   .foregroundColor(DesignColor.secondaryVariant)
            .contentShape(Rectangle())
    }
}

extension Binding {
    internal func onChange(
        _ index: Int,
        _ handler: @escaping (Value, Int) -> Void
    ) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue, index)
            }
        )
    }
}

struct DesignTokenField_Preview : PreviewProvider {
    
    static var previews: some View {
        
        @State var token: String = ""
        
        return DesignTokenField(
            size: 4,
            isSecured: false,
            token: $token
        ).padding(24)
    }
}

