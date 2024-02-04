//
//  Home.swift
//  TriviaGame
//
//  Created by kuet on 8/11/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct Home: View {
    @StateObject var triviaManager = TriviaManager()
    @State var score : [ String:String] = [:]
    @State var quizId = ""
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer().frame(height: 50)
                Text("QuizWizz")
                .font(.custom(
                        "AmericanTypewriter",
                        fixedSize: 27))
                        //.bold()
                .foregroundColor(Color("AccentColor"))
                
                
                
                VStack{
                    NavigationLink(
                        destination: AddQuiz(),
                        label: {
                            Button("Create Quiz"){
                                
                            }
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .padding()
                            .background(Color("AccentColor"))
                            .cornerRadius(10)
                        }
                    )
                                
                
//                    Button("Create Quiz"){
//
//                    }
//                    .foregroundColor(.white)
//                    .frame(width: 150)
//                    .padding()
//                    .background(Color("AccentColor"))
//                    .cornerRadius(10)
//                    //.bold()
                    
                    Spacer().frame(height:20)
                    
                    NavigationLink(
                        destination: JoinQuiz(),
                        label: {
                            Button("Join Quiz"){
                                
                            }
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .padding()
                            .background(Color("AccentColor"))
                            .cornerRadius(10)
                        }
                    )
                    
//                    Button("Join Quiz"){
//
//                    }
//                    .foregroundColor(.white)
//                    .frame(width: 150)
//                    .padding()
//                    .background(Color("AccentColor"))
//                    .cornerRadius(10)
                    //.bold()
                    Spacer().frame(height:20)
                    
                    NavigationLink {
                        TriviaView()
                            .environmentObject(triviaManager)
                    } label: {
                        Button("Trivia"){
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 150)
                        .padding()
                        .background(Color("AccentColor"))
                        .cornerRadius(10)
                        
                    }
                    
                    //.bold()
                    
                    
                }
                .padding(50)
                Spacer()
                VStack{
                if !score.isEmpty{
                    
                        HStack{
                            Spacer()
                            Text("Last Participation Score")
                                .font(.title2)
                                .bold()
                                .padding()
                                .foregroundColor(Color("AccentColor"))
                            Spacer()
                        }
                        HStack{
                            
                            Text(score["quizid"]!)
                                .font(.title3)
                                .bold()
                                .padding()
                                .foregroundColor(Color("AccentColor"))
                            Spacer()
                            Text("\(score["score"]!) / \(score["length"]!)")
                                .font(.title2)
                                .bold()
                                .padding()
                                .foregroundColor(Color("AccentColor"))
                            
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .stroke(Color("AccentColor"))
                        )
                        .padding([.horizontal],32)
                        .padding(.bottom,50)
                    }
                }
                
            }
            //.frame(maxWidth: .infinity,maxHeight: .infinity)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color("Background"))
            .onAppear{
                
                if let user = Auth.auth().currentUser{
                    let uid = user.uid
                    let databaseRef = Database.database().reference().child("userinfo").child(uid).child("participated")
                    
                    databaseRef.observeSingleEvent(of: .value) { (snapshot) in
                            
                            if let entryData = snapshot.value as? [String:String] {
                                
                                score = entryData
                                print(entryData)
                            }
                       
                    }
                }
            }
        }
        
        
    }
    
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
