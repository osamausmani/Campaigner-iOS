//
//  SurveyAttemptScreenView.swift
//  Campaigner
//
//  Created by Osama Usmani on 01/11/2023.


import Foundation

import SwiftUI
import SwiftAlertView

struct SurveyAttemptScreenView: View {
    
    @State var surveyQuestionsArray = [SurveyQuestion]()
    @State var surveyData : SurveyData?
    
    @State var surveyID :String?
    @State var QuestionIDs : [String] = []
    @State var Answers : [String] = []
    @State var AnswerOptions : [String] = []
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        
        VStack{ VStack(alignment: .leading, spacing: 20) {
            ScrollView{
                
                ForEach(surveyQuestionsArray.indices, id: \.self) { index in
                    let question = surveyQuestionsArray[index]
                    
                    if question.question_type == 1 {
                        QuestionCardView(title: "Q \(index + 1): \(question.question_title ?? "")", content: {
                            ForEach(question.question_option ?? [], id: \.question_option_id_text) { option in
                                CheckboxView(
                                    option: option,
                                    isChecked: bindingForOption(option: option, qIndex: index),
                                    checkboxChanged: { selected in
                                        self.updateAnswerOption(option: option.question_option!, qIndex: index, question: question)
                                    }
                                )
                                
                            }
                            
                        })
                    }
                    
                    
                    
                    if question.question_type == 2 {
                        QuestionCardView(title: "Q \(index + 1): \(question.question_title ?? "")", content: {
                            HStack{
                                TFView(
                                    label: "True",
                                    isChecked: bindingForTFOption(qIndex: index, value: "True"),
                                    checkboxChanged: { selected in
                                        self.updateTFOption(qIndex: index, question: question, value: true)
                                    }
                                )
                                Spacer()
                                TFView(
                                    label: "False",
                                    isChecked: bindingForTFOption(qIndex: index, value: "False"),
                                    checkboxChanged: { selected in
                                        self.updateTFOption(qIndex: index, question: question, value: false)
                                    }
                                )
                                Spacer()
                            }
                        })
                    }
                    
                    //
                    if question.question_type == 3 {
                        QuestionCardView(title: "Q \(index + 1): \(question.question_title ?? "")", content: {
                            TextEditor(text: $Answers[index])
                                .frame(height: 100)
                                .border(Color.gray, width: 1)
                                .onChange(of: Answers[index]) { newValue in
                                    if QuestionIDs[index] == ""{
                                        QuestionIDs[index] = question.question_id_text!
                                    }
                                }
                        })
                    }
                }
                
                
                
                
                
                
                
            }
            
            
            // Buttons
            HStack {
                Button("Cancel") {
                    // Handle cancel
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Submit") {
                    //                    print("QuestionIDs  ", QuestionIDs)
                    //                    print("Answer Options: ", AnswerOptions)
                    //                    print("Answers ", Answers)
                    var questions = QuestionIDs.filter({ $0 != ""})
                    if  questions.count == 0 {
                        SwiftAlertView.show(title: "Alert", message: "Survey is incomplete.", buttonTitles: "OK")
                    }else{
                        SwiftAlertView.show(title: "Alert",
                                            message: "Are you sure to submit this survey?",
                                            buttonTitles: "Cancel", "OK")
                        .onButtonClicked { _, buttonIndex in
                            print("Button Clicked At Index \(buttonIndex)")
                            if buttonIndex == 1 {
                                SubmitSurvey()
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(CColors.MainThemeColor)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }.onAppear{
            GetSurveysData()
        }
        }
    }
    
    
    func updateTFOption(qIndex: Int, question: SurveyQuestion, value:Bool) {
        Answers.indices.forEach { index in
            if index == qIndex {
                
                Answers[index] = value ? "True" : "False"
                QuestionIDs[index] = question.question_id_text!
            }
        }
    }
    
    func bindingForTFOption(qIndex: Int, value: String) -> Bool {
        return Answers[qIndex] == value
    }
    
    
    func bindingForOption(option: SurveyQuestionOption, qIndex: Int)  -> Bool {
        if AnswerOptions[qIndex] == option.question_option!{
            return true
        }
        else{
            return false
        }
    }
    
    func updateAnswerOption(option: String, qIndex: Int, question: SurveyQuestion) {
        AnswerOptions.indices.forEach { index in
            if index == qIndex {
                AnswerOptions[index] = option
                QuestionIDs[index] = question.question_id_text!
            }
        }
    }
    
    func SubmitSurvey(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "survey_id": surveyID!,
            "is_anon": "0",
            "question_id": QuestionIDs.joined(separator: "8C%qO"),
            "answer": Answers.joined(separator: "8C%qO"),
            "answer_option": AnswerOptions.joined(separator: "8C%qO"),
        ]
        let ViewModel = SurveyViewModel()
        ViewModel.SubmitSurveyAnswers(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    
                    SwiftAlertView.show(title: "Alert",
                                        message: response.message,
                                        buttonTitles: "OK")
                    .onButtonClicked { _, buttonIndex in
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
                
            }
        }
    }
    
    func GetSurveysData(){
        let parameters: [String:Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "survey_id": surveyID!
        ]
        let ViewModel = SurveyViewModel()
        ViewModel.GetSurveyDetails(parameters: parameters ) { result in
            switch result {
            case .success(let response ):
                if response.rescode == 1 {
                    
                    surveyQuestionsArray = response.data![0].question_data!
                    surveyData = response.data![0]
                    for _ in surveyQuestionsArray{
                        QuestionIDs.append("")
                        Answers.append("")
                        AnswerOptions.append("")
                    }
                    
                }else{
                    SwiftAlertView.show(title: "Alert", message: response.message, buttonTitles: "OK")
                    
                }
            case .failure(let error):
                SwiftAlertView.show(title: "Alert", message: error.localizedDescription, buttonTitles: "OK")
            }
        }
    }
}

struct RadioButtonGroup: View {
    let label: String
    let isChecked: Bool
    var checkboxChanged: ((Bool) -> Void)?
    
    var body: some View {
        Button(action: {
            checkboxChanged?(!isChecked)
        }) {
            HStack {
                Circle()
                    .strokeBorder(Color.black, lineWidth: 1)
                    .background(Circle().fill(isChecked ? CColors.MainThemeColor : Color.clear))
                    .frame(width: 20, height: 20)
                Text(label)
            }
        }
        .foregroundColor(Color.black)
    }
}

struct TFView: View {
    let label: String
    let isChecked: Bool
    var checkboxChanged: ((Bool) -> Void)?
    
    var body: some View {
        HStack {
            Button(action: {
                checkboxChanged?(!isChecked)
            }) {
                HStack {
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 1)
                        .background(Circle().fill(isChecked ? CColors.MainThemeColor : Color.clear))
                        .frame(width: 20, height: 20)
                    Text(label)
                }
            }
        }
    }
}


struct CheckboxView: View {
    let option: SurveyQuestionOption
    let isChecked: Bool
    var checkboxChanged: ((Bool) -> Void)?
    
    var body: some View {
        HStack {
            Button(action: {
                checkboxChanged?(!isChecked)
            }) {
                HStack {
                    Image(systemName: isChecked ? "checkmark.square" : "square")
                    Text(option.question_option ?? "")
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct QuestionCardView<Content: View>: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.leading, 0)
            
            content()
            
        }.frame(maxWidth: .infinity)
            .padding(8)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
    }
}

struct SurveyAttemptScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyAttemptScreenView()
    }
}
