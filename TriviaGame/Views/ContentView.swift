//
//  ContentView.swift
//  TriviaGame
//
//  Created by kuet on 8/11/23.
//

import SwiftUI
import Firebase

@MainActor
struct ContentView: View {
    @State var email:String=""
    @State var password:String=""
    @State var userName:String=""
    @State var userExist=0
    @State var invalidPass=0
    
    @State private var isActive:Bool = false;
    @State private var goTosSignUp:Bool = false;
    
    
    var body: some View {
        
        ZStack{
            VStack{
                VStack{
                    
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(Color("AccentColor"))
                    
                    
                    TextField("Email",text: $email)
                        .padding()
                        .frame(width: 350,height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(userExist))
                    
                    
                    
                    SecureField("Password",text: $password)
                        .padding()
                        .frame(width: 350,height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(invalidPass))
                    
                    
                    Button{
                        signIn()
                    }label: {
                        Text("Sign in")
                            .frame(width: 350,height: 50)
                    }
                    
                    .foregroundColor(.white)
                    .frame(width: 350,height: 50)
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    .padding()
                    //.bold()
                    
                    Text("Don't have account?")
                        .font(.title3)
                        .bold()
                        .padding()
                        .foregroundColor(Color("AccentColor"))
                    
                    Button{
                        goTosSignUp=true;
                    }label: {
                        Text("Sign Up")
                            .frame(width: 150,height: 50)
                    }
                    
                    .foregroundColor(.white)
                    .frame(width: 150,height: 50)
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    
                }
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("Background"))
            
            
            if isActive{
                Home()
            }
            
            if goTosSignUp{
                SignUp()
            }
            
//            NavigationLink(
//                                destination: SecondView(),
//                                isActive: $isLinkActive,
//                                label: {
//                                    Text("Go to Second View")
//                                }
//                            )
            
        }
        
    }
    
    func signIn(){
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
                    if let error = error {
                        print("Error signing in: \(error.localizedDescription)")
                    }
                    else {
                        print("Successfully signed in")
                        isActive = true
                        // Handle successful sign-in
                    }
                }
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
