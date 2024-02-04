//
//  SignUp.swift
//  TriviaGame
//
//  Created by kuet on 8/11/23.
//

import SwiftUI
import Firebase

struct SignUp: View {
    @State var email:String=""
    @State var password:String=""
    @State var userName:String=""
    @State var userExist=0
    @State var userNameExist=0
    @State var invalidPass=0
    @State var isActive=false
    @State var goTosSignIn=false
    @State var uid=""
    
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    
                    
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(Color("AccentColor"))
                    
                    TextField("Username",text: $userName)
                        .padding()
                        .frame(width: 350,height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(userNameExist))
                        .disableAutocorrection(true)
                    
                    TextField("Email",text: $email)
                        .padding()
                        .frame(width: 350,height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(userExist))
                        .disableAutocorrection(true)
                    
                    SecureField("Password",text: $password)
                        .padding()
                        .frame(width: 350,height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(invalidPass))
                    
                    Button("Sign Up"){
                        signUpBtn()
                    }
                    .foregroundColor(.white)
                    .frame(width: 350,height: 50)
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    .padding()
                    //.bold()
                    
                    Text("Already have account?")
                        .font(.title3)
                        .bold()
                        .padding()
                        .foregroundColor(Color("AccentColor"))
                    
                    Button{
                        goTosSignIn=true;
                    }label: {
                        Text("Sign In")
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
            
            if(isActive || goTosSignIn){
                ContentView()
            }
            
        }
    }
    
    func signUpBtn() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
            } else {
                
                print("Sign-up successful!")
                sendMessageToFirebase()
                
                
            }
        }
    }
    
    
    func sendMessageToFirebase() {
        let db = Database.database().reference()
        
        
        if let user = Auth.auth().currentUser {
            uid = user.uid
            
            // Update messages in Firebase
            db.child("userinfo").child(uid).child("username").setValue(userName) { error, _ in
                if let error = error {
                    print("Error writing message to Firebase: \(error.localizedDescription)")
                } else {
                    print("Message successfully written to Firebase!")
                    isActive=true
                }
            }
        }
        
    }
}

struct signUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
