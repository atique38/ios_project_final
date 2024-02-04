//
//  ResultView.swift
//  TriviaGame
//
//  Created by kuet on 26/11/23.
//

import SwiftUI
import Firebase

struct ResultView: View {
    var score: Int = 0
    var totalQues: Int = 0
    var quizId: String = ""
     @State var goHome = false
    
    init(score: Int, totalQues: Int, quizId:String ) {
        self.score = score
        self.totalQues = totalQues
        self.quizId = quizId
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 20) {
                Text("Result")
                    .lilacTitle()

                Text("Congrats, you have completed the quiz! 🥳")
                
                Text("You scored \(score) out of \(totalQues)")
                
                Button (action: {
                    goHome = true
                }, label: {
                    PrimaryButton(text: "Finish")
                })
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .onAppear{
                storeScore()
            }
            
            if goHome {
                Home()
            }
        }
        
    }
    
    func storeScore(){
        let db = Database.database().reference()
        var uid=""
        
        if let user = Auth.auth().currentUser {
            uid = user.uid
            
            let res : [String:String] = [
                        "score": String(score),
                        "length": String(totalQues),
                        "quizid": quizId
                        
                    ]
            
            db.child("userinfo").child(uid).child("participated").setValue(res) { error, _ in
                    if let error = error {
                        print("Error storing data to Firebase: \(error.localizedDescription)")
                    } else {
                        print("Score added to database.")
                        
                    }
                }
            
        }
            
        
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(score: 0 , totalQues: 0, quizId: "_")
    }
}
