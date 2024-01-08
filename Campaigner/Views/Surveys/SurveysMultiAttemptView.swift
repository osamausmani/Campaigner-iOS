//
//  SurveysMultiAttemptView.swift
//  Campaigner
//
//  Created by Macbook  on 18/12/2023.
//

import SwiftUI

struct SurveysMultiAttemptView: View {
    var surveyID: String?
    @State private var surveyAttemptScreenView = false
    @State var surveyListArray = [SurveyListData]()
    @State var attemptedSurveysList = [SurveyData]()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack{
         
            
            VStack{
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        
                        Image("back_arrow")
                            .resizable()
                            .frame(width: 24, height: 24).tint(CColors.MainThemeColor)
                        Spacer()
                        Text(surveyListArray.first?.survey_title ?? "").tint(CColors.MainThemeColor).font(.system(size: 18))
                        Spacer()
                        
                        
                        
                    }
                    
                }
                .foregroundColor(.black)
                .padding()
                dividerline()
                    .padding(.bottom,10)
                
                VStack {
                  
                    
                    NavigationLink(destination: SurveyAttemptScreenView(surveyID: surveyID), isActive: $surveyAttemptScreenView) {
                    }
                    ScrollView {
                        ForEach(attemptedSurveysList.flatMap { $0.getMergedQuestionAndAnswerData() }, id: \.self) { (pair: QuestionAnswerPair) in
                            CustomAttemptedSurvey(question: pair.question, answer: pair.answer)
                                .padding(.leading,10 )
                             
                        }
                    }
                   
                    
                    Spacer()
                  
                    
                    HStack {
                        Spacer()
                        AddButton(action: {
                            surveyAttemptScreenView.toggle()
                        }, label: "")
                        .padding(.trailing, 10)
                        .padding(.bottom,20)
                    }
                }
                .navigationBarHidden(true)
                .background(CColors.CardBGColor)
               
           
            }
    }
        .onAppear { GetAttemptedSurveys() }

        
    }
    
    func GetAttemptedSurveys() {
        let parameters: [String: Any] = [
            "plattype": Global.PlatType,
            "user_id": UserDefaults.standard.string(forKey: Constants.USER_ID)!,
            "survey_id": surveyID!
        ]
        
        let viewModel = SurveyViewModel()
        viewModel.ListSurveyDetails(parameters: parameters) { result in
            var userID = UserDefaults.standard.string(forKey: Constants.USER_ID)
            print(surveyID)
            switch result {
            case .success(let response):
                if response.rescode == 1 {
                    var surveyArray = [SurveyData]()
                    surveyArray = response.data!
                    
                    attemptedSurveysList.removeAll()
                    attemptedSurveysList = surveyArray
                    print("attemptedSurveysList is \(attemptedSurveysList)")
                } else {
                    attemptedSurveysList.removeAll()
                }
            case .failure(let error):
                print(error)
              
            }
        }
    }
}

struct QuestionAnswerPair: Hashable {
    var question: String
    var answer: String
}


#Preview {
    SurveysMultiAttemptView()
}
extension SurveyData {
    func getMergedQuestionAndAnswerData() -> [QuestionAnswerPair] {
        guard let questions = question_data, let answers = answer_data else {
            return []
        }

        var questionMap = [String: String]()
        for question in questions {
            if let questionID = question.question_id_text, let title = question.question_title {
                questionMap[questionID] = title
            }
        }

        return answers.compactMap { answer in
            guard let questionID = answer.questionIDText,
                  let answerString = answer.surveyAnswer,
                  let questionTitle = questionMap[questionID] else {
                return nil
            }
            return QuestionAnswerPair(question: questionTitle, answer: answerString)
        }
    }
}
