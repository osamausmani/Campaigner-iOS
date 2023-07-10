import SwiftUI

struct CheckBoxOptionView: View {
    let questions: [Question]
    @Binding var selectedOptions: [UUID: String]
    
    var body: some View {
        VStack {
            ForEach(questions) { question in
                QuestionWithOptionsView(question: question, selectedOption: binding(for: question))
            }
        }
        .padding()
    }
    
    private func binding(for question: Question) -> Binding<String?> {
        Binding<String?>(
            get: {
                selectedOptions[question.id]
            },
            set: {
                selectedOptions[question.id] = $0
            }
        )
    }
}

struct Question: Identifiable {
    let id: UUID
    let question: String
    let options: [String]
}

struct QuestionWithOptionsView: View {
    let question: Question
    @Binding var selectedOption: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            ForEach(question.options, id: \.self) { option in
                CheckboxOptionView(option: option, selectedOption: $selectedOption)
                    .onTapGesture {
                        handleOptionSelection(option)
                    }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.vertical, 8)
    }
    
    private func handleOptionSelection(_ option: String) {
        if selectedOption == option {
            selectedOption = nil
        } else {
            selectedOption = option
        }
    }
}

struct CheckboxOptionView: View {
    let option: String
    @Binding var selectedOption: String?
    
    var body: some View {
        HStack {
            Image(systemName: selectedOption == option ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(selectedOption == option ? .blue : .gray)
            
            Text(option)
                .font(.body)
                .foregroundColor(.black)
                .padding(.leading, 8)
            
            Spacer()
        }
        .onTapGesture {
            handleOptionSelection()
        }
    }
    
    private func handleOptionSelection() {
        if selectedOption == option {
            selectedOption = nil
        } else {
            selectedOption = option
        }
    }
}
