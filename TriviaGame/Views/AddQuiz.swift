//
//  AddQuiz.swift
//  TriviaGame
//
//  Created by kuet on 20/11/23.
//
import Firebase
import SwiftUI

struct AddQuiz: View {
    @State var option1:String=""
    @State var option2:String=""
    @State var option3:String=""
    @State var option4:String=""
    @State var quizid:String=""
    @State var question:String=""
    @State private var timestamp: TimeInterval = 0.0
    @State var isActive=false
    
  
    
    @State var clicked1=false
    @State var clicked2=false
    @State var clicked3=false
    @State var clicked4=false
    
    @State var uid=""
    var body: some View {
        VStack{
            Spacer().frame(height: 50)
            VStack{
                
                
                Text("Add Quiz")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(Color("AccentColor"))
                
                
                TextField("Add a question",text: $question)
                    .padding()
                    .frame(width: 350,height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                Spacer().frame(height: 25)

                
                VStack{
                    HStack{
                        TextField("Option 1",text: $option1)
                            .padding()
                            .frame(width: 320,height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            clicked1=true
                            clicked2=false
                            clicked3=false
                            clicked4=false
                        }, label: {
                            Image(systemName: clicked1  ?  "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(clicked1 ? .green : .red)
                        })
                    }
                    
                    
                    HStack{
                        TextField("Option 2",text: $option2)
                            .padding()
                            .frame(width: 320,height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            clicked1=false
                            clicked2=true
                            clicked3=false
                            clicked4=false
                            
                        }, label: {
                            Image(systemName: clicked2  ?  "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(clicked2 ? .green : .red)
                        })
                        
                    }
                    
                    HStack{
                        TextField("Option 3",text: $option3)
                            .padding()
                            .frame(width: 320,height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            clicked1=false
                            clicked2=false
                            clicked3=true
                            clicked4=false
                            
                        }, label: {
                            Image(systemName: clicked3  ?  "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(clicked3 ? .green : .red)
                        })
                    }
                    
                    HStack{
                        TextField("Option 4",text: $option4)
                            .padding()
                            .frame(width: 320,height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            clicked1=false
                            clicked2=false
                            clicked3=false
                            clicked4=true
                        
                            
                        }, label: {
                            Image(systemName: clicked4  ?  "checkmark.circle.fill" : "x.circle.fill")
                                .foregroundColor(clicked4 ? .green : .red)
                        })
                    }
                    
                    
                    
                }
                
                Button(action: {
                    storeQuestion()
                }, label:  {
                    Text("Add")
                        .frame(width: 150, height: 50)
                })
                .foregroundColor(.white)
                .frame(width: 150,height: 50)
                .background(Color("AccentColor"))
                .cornerRadius(10)
                .padding()
                        
                
                Spacer()
                
                Text("Quiz id: \(quizid)")
                    .font(.title2)
                    .bold()
                    .padding()
                    .foregroundColor(Color("AccentColor"))
                //.bold()
            }
        }
        //.frame(maxWidth: .infinity,maxHeight: .infinity)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("Background"))
        .padding(.bottom,80)
        .onAppear {
                    timestamp = Date().timeIntervalSince1970
                    let date = Date(timeIntervalSince1970: timestamp)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyyMMddHHmmss"
                    quizid = dateFormatter.string(from: date)
                
                   
                
               }
    }
    
        
    
    func storeQuestion(){
        let db = Database.database().reference()
        
            let options = [
                        option1: clicked1,
                        option2: clicked2,
                        option3: clicked3,
                        option4: clicked4
                    ]
            // Update messages in Firebase
        db.child("quizes").child(quizid).child("question").child(question).setValue(options) { error, _ in
                if let error = error {
                    print("Error storing data to Firebase: \(error.localizedDescription)")
                } else {
                    print("Question added to database.")
                    isActive=true
                    option1 = ""
                    option2 = ""
                    option3 = ""
                    option4 = ""
                    question = ""
                    
                    clicked1 = false
                    clicked2 = false
                    clicked3 = false
                    clicked4 = false
                }
            }
        
       
       
    }
        
    
}
   



struct AddQuiz_Previews: PreviewProvider {
    static var previews: some View {
        AddQuiz()
    }
}
