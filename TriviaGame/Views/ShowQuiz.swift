//
//  ShowQuiz.swift
//  TriviaGame
//
//  Created by kuet on 26/11/23.
//

import SwiftUI
import Firebase
struct ShowQuiz: View {
    
    @State var questionTxt=""
    
    private var databaseRef = Database.database().reference()
    @State var options = [[String: Any]]()
    @State var question = [String]()
    @State var ansOption = [String]()
    @State var ans = [Bool]()
    @State var selected = [false,false,false,false]
    public var quizid:String
    @State var index:Int = 0
    
    @State private var isSelected = false
    @State private var iscorrect = false
    @State private var isComplete = false
    
    @State  var op1 = false
    @State  var op2 = false
    @State  var op3 = false
    @State  var op4 = false
    @State var result = 0
    
    
    

    // Custom colors
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.711)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    init(id:String){
        quizid = id
    }
    
    

    var body: some View {
        ZStack{
            VStack(spacing: 40) {
                Spacer().frame(height: 50)
                
                HStack {
                    Text("Trivia Game")
                        .lilacTitle()
                    
                    Spacer()
                    
                    Text("\(index + 1) out of \(question.count)")
                        .foregroundColor(Color("AccentColor"))
                        .fontWeight(.heavy)
                }
                
                ProgressBar(progress: CGFloat(Double((index + 1)) / Double(question.count) * 350))
                
               
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(question.count > index ? question[index] : "-")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 20) {
                        Image(systemName: "circle.fill")
                            .font(.caption)
                        
                        Text(ansOption.count > index ? ansOption[0] : "-")
                            .bold()
                        
                        if selected[0] {
                            Spacer()
                            
                            Image(systemName: ans[0] ? "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(ans[0] ? green : red)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(isSelected ? (selected[0] ? Color("AccentColor") : .gray) : Color("AccentColor"))
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: selected[0] ? ans[0] ? green : red : .gray, radius: 5, x: 0.5, y: 0.5)
                    .onTapGesture {
                        if !isSelected {
                            isSelected = true
                            selected[0]=true
                            selected[1]=false
                            selected[2]=false
                            selected[3]=false
                            if ans[0] {
                                result = result + 1
                            }
                            //triviaManager.selectAnswer(answer: answer)

                        }
                    }
                    
                    HStack(spacing: 20) {
                        Image(systemName: "circle.fill")
                            .font(.caption)
                        
                        Text(ansOption.count > index ? ansOption[1] : "-")
                            .bold()
                        
                        if selected[1] {
                            Spacer()
                            
                            Image(systemName: ans[1] ? "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(ans[1] ? green : red)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(isSelected ? (selected[1] ? Color("AccentColor") : .gray) : Color("AccentColor"))
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: selected[1] ? ans[1] ? green : red : .gray, radius: 5, x: 0.5, y: 0.5)
                    .onTapGesture {
                        if !isSelected {
                            isSelected = true
                            selected[0]=false
                            selected[1]=true
                            selected[2]=false
                            selected[3]=false
                            
                            if ans[1] {
                                result = result + 1
                            }

                        }
                    }
                    HStack(spacing: 20) {
                        Image(systemName: "circle.fill")
                            .font(.caption)
                        
                        Text(ansOption.count > index ? ansOption[2] : "-")
                            .bold()
                        
                        if selected[2] {
                            Spacer()
                            
                            Image(systemName: ans[2] ? "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(ans[2] ? green : red)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(isSelected ? (selected[2] ? Color("AccentColor") : .gray) : Color("AccentColor"))
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: selected[2] ? ans[2] ? green : red : .gray, radius: 5, x: 0.5, y: 0.5)
                    .onTapGesture {
                        if !isSelected {
                            isSelected = true
                            selected[0]=false
                            selected[1]=false
                            selected[2]=true
                            selected[3]=false
                            
                            if ans[2] {
                                result = result + 1
                            }

                        }
                    }
                    HStack(spacing: 20) {
                        Image(systemName: "circle.fill")
                            .font(.caption)
                        
                        Text(ansOption.count > index ? ansOption[3] : "-")
                            .bold()
                        
                        if selected[3] {
                            Spacer()
                            
                            Image(systemName: ans[3] ? "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(ans[3] ? green : red)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(isSelected ? (selected[3] ? Color("AccentColor") : .gray) : Color("AccentColor"))
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: selected[3] ? ans[3] ? green : red : .gray, radius: 5, x: 0.5, y: 0.5)
                    .onTapGesture {
                        if !isSelected {
                            isSelected = true
                            selected[0]=false
                            selected[1]=false
                            selected[2]=false
                            selected[3]=true
                            if ans[3] {
                                result = result + 1
                            }

                        }
                    }
                    
//                    ForEach(triviaManager.answerChoices, id: \.id) { answer in
//                        AnswerRow(answer: answer)
//                            .environmentObject(triviaManager)
//                    }
                    
                    
                    
                }
                
                Button {
                    index += 1
                    isSelected = false
                    selected[0]=false
                    selected[1]=false
                    selected[2]=false
                    selected[3]=false
                    
                    if index == question.count {
                        isComplete=true
                    }
                    else
                    {
                        accessData()
                    }
                    
                    
                    
                    //triviaManager.goToNextQuestion()
                } label: {
                    PrimaryButton(text: "Next", background: isSelected ? Color("AccentColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                }
                .disabled(!isSelected)
                
                Spacer()
            }
            .padding()
            //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .navigationBarHidden(true)
            .onAppear{
                fetchData()
            }
            
            if isComplete {
                ResultView(score: result, totalQues: question.count, quizId: quizid)
            }
            
        }
    }
    func fetchData() {
        databaseRef.child("quizes").child(quizid).child("question")
            .observeSingleEvent(of: .value) { (snapshot,err) in
                    guard let data = snapshot.value as? [String: [String: Bool]] else {
                        print("Error: Unable to parse data from Firebase")
                        return
                    }

                options = data.compactMap { key, value in
                        return value
                    }
                
                var i = 0
                
                    for key in data.keys{
                        //print(key)
                        question.append(key)
                        print(question[i])
                        i=i+1
                    }

                    // Print the retrieved questions to the console
                    for (index, opt) in self.options.enumerated() {
                        print("Question \(index + 1):")
                        for (key, value) in opt {
                            print("  - \(key): \(value)")
                        }
                        print("\n")
                    }
                accessData()
        }
        
        
    }
    
    func accessData(){
        ansOption.removeAll()
        ans.removeAll()
        for (key,value) in options[index]{
            ansOption.append(key)
            print(key)
            let b = value as! Bool
            print(b)
            ans.append(b)
        }
    }
    
}

struct ShowQuiz_Previews: PreviewProvider {
    static var previews: some View {
        ShowQuiz(id:"---")
    }
}
