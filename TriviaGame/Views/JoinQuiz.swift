//
//  JoinQuiz.swift
//  TriviaGame
//
//  Created by kuet on 23/11/23.
//

import SwiftUI
import Firebase
struct JoinQuiz: View {
    private var databaseRef = Database.database().reference()
    @State var quizId:String=""
    @State var isNodeExist:Bool=false
    var body: some View {
        ZStack{
            VStack{
                Text("Join Quiz")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(Color("AccentColor"))
                
                
                TextField("Enter join id",text: $quizId)
                    .padding()
                    .frame(width: 350,height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                

                
                Button(action: {
                    idValidation()
                }, label:  {
                    Text("Join")
                        .frame(width: 150, height: 50)
                })
                .foregroundColor(.white)
                .frame(width: 150,height: 50)
                .background(Color("AccentColor"))
                .cornerRadius(10)
                .padding()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color("Background"))
            
            
            if(isNodeExist){
                VStack{
                    ShowQuiz(id:quizId)
                }
                .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        }
        
    }
    func idValidation(){
        databaseRef.child("quizes").child(quizId).observeSingleEvent(of: .value) { snapshot in
            isNodeExist = snapshot.exists()
            
            if isNodeExist{
                print("id found")
                
            }
            else{
                print("id not found")
            }
        }
        
    }
}

struct JoinQuiz_Previews: PreviewProvider {
    static var previews: some View {
        JoinQuiz()
    }
}
