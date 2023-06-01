//
//  ContentView.swift
//  LOgin
//
//  Created by Apple1 on 31/05/2023.
//

import SwiftUI
class Hapticmanager {
    
    static let instance=Hapticmanager()
    func notification (type:UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    func impact (style:UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
struct ContentView: View {
    @State private var isChecked: Bool = false
    @State var isFace: Bool = false
    @State  var isTouch: Bool = false
    @State var isRemember:Bool=false
    @State var  errorMessage:String=""
    @State var ApiSucces:Bool=false
    @State var isSecureText:Bool=true
    @State private var email = ""
    @State private var password = ""
    private let emailKey = "email"
    private let passwordKey = "password"
    @State private var showErrorDialog = false
    @State private var SuccessDialog = false
    @State private var showerrorResponse=false
    @State private var isEmailValid = false
    var body: some View {
        ZStack{
            Color(hex: "130907")
            VStack(spacing:0){
                VStack{
                    RoundedRectangle(cornerRadius: 0)
                        .fill(.clear)
                        .frame(height: 110)
                        .overlay {
                            VStack{
                                VStack{
                                    HStack{
                                        Button {
                                        } label: {
                                            Image(systemName: "chevron.left")
                                                .resizable()
                                                .frame(width: 10, height: 15) // Adjust the width and height values as needed
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                        Text("Log In")
                                            .foregroundColor(.white)
                                            .bold()
                                        //                                            .font(.custom("Poppins-Regular", size: 20))
                                        Spacer()
                                        Button {
                                            
                                        } label: {
                                            Image(systemName: "ellipsis")
                                                .font(.system(size: 24))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }.padding(.horizontal)
                                VStack{
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.gray.opacity(0.1))
                                }
                            }.padding(.top,30)
                        }
                }
                
                RoundedRectangle(cornerRadius:0)
                    .fill(Color.clear)
                    .overlay {
                        ScrollView {
                            VStack{
                                VStack(alignment:.center,spacing:5){
                                    HStack{
                                        Text("Log in to your PS profile to see more tracking details")
                                            .font(.system(size: 18))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                    }
                                    HStack{
                                        Text("Dont't have a PS profile?")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                        Button {
                                            
                                        } label: {
                                            Text("Sign Up")
                                                .underline()
                                                .foregroundColor(.white)
                                        }
                                        
                                    }
                                }.padding(.horizontal,15)
                                VStack(spacing:25){
                                    VStack(alignment:.leading,spacing:20){
                                        VStack(alignment:.leading,spacing:20){
                                            
                                            VStack{
                                                RoundedRectangle(cornerRadius: 3)
                                                    .stroke(Color(hex: "2c2220"),lineWidth: 1)
                                                    .frame(height: 55)
                                                    .overlay {
                                                        ZStack(alignment: .leading){
                                                            if email.isEmpty {
                                                                Text("Enter email")
                                                                    .foregroundColor(.white)
                                                            }
                                                            TextField("", text: $email)
                                                                .foregroundColor(Color(.white))
                                                        }.padding()
                                                    }
                                                    .keyboardType(.emailAddress)
                                                    .autocapitalization(.none)
                                                    .disableAutocorrection(true)
                                                    .onChange(of: email) { newValue in
                                                        isEmailValid = isValidEmail(newValue)
                                                    }
                                            }
                                            HStack{
                                                RoundedRectangle(cornerRadius: 3)
                                                    .stroke(Color(hex: "2c2220"),lineWidth: 1)
                                                    .frame(height:55)
                                                    .overlay {
                                                        ZStack(alignment: .leading){
                                                            if password.isEmpty {
                                                                Text("Enter Password")
                                                                    .foregroundColor(.white)
                                                            }
                                                            HStack{
                                                                if isSecureText {
                                                                    SecureField("", text: $password)
                                                                        .foregroundColor(.white)
                                                                } else {
                                                                    TextField("", text: $password)
                                                                        .foregroundColor(.white)
                                                                }
                                                                Button(action: {
                                                                    isSecureText.toggle()
                                                                }) {
                                                                    Image(systemName: isSecureText ? "eye.slash" : "eye")
                                                                        .foregroundColor(.white)
                                                                }
                                                            }
                                                        }.padding()
                                                    }
                                            }
                                            HStack{
                                                Text("Forgot Username or Password?")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.white)
                                                    .underline()
                                            }
                                        }
                                        VStack(alignment: .leading,spacing:18){
                                            Toggle(isOn: $isChecked) {
                                                Text("Keep me logged in on this device")
                                                    .foregroundColor(.white)
                                            }
                                            .toggleStyle(CheckboxToggleStyle())
                                            Toggle(isOn: $isFace) {
                                                HStack{
                                                    Image("FaceID_Icon")
                                                    Text("Use Face ID")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .toggleStyle(CheckboxToggleStyle())// Apply custom checkbox style
                                            Toggle(isOn: $isTouch) {
                                                HStack{
                                                    Image("FingerPrint_Icon")
                                                    Text("Use Touch ID")
                                                        .font(.system(size: 18))
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .toggleStyle(CheckboxToggleStyle())
                                        }
                                        
                                    }.padding(.horizontal)
                                    VStack{
                                        VStack{
                                            Text("By logging in, I agree to the")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                            HStack{
                                                Text("Ps Technology Agreement")
                                                    .foregroundColor(Color(hex: "0b518c"))
                                                    .padding(.all,5)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color(hex: "0b518c"), lineWidth: 2)
                                                    )
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                    VStack(spacing:20){
                                        VStack(spacing:20){
                                            VStack(spacing:20){
                                                ZStack{
                                                    HStack{
                                                        RoundedRectangle(cornerRadius: 50)
                                                            .fill(Color(hex: "feb322"))
                                                            .overlay {
                                                                HStack{
                                                                    Text("Log In")
                                                                        .foregroundColor(Color(hex: "130907"))
                                                                        .bold()
                                                                    Image(systemName: "chevron.right")
                                                                        .resizable()
                                                                        .frame(width: 8, height: 12) // Adjust the width and height values as needed
                                                                        .foregroundColor(.black)
                                                                }
                                                            }
                                                    }
                                                }.frame(width: UIScreen.main.bounds.width - 35, height: 50, alignment: .center)
                                                    .onTapGesture {
                                                        if isEmailValid && !password.isEmpty {
                                                            Hapticmanager.instance.notification(type: .success)
                                                            SuccessDialog=true
                                                        } else {
                                                            Hapticmanager.instance.notification(type: .error)
                                                            showErrorDialog = true
                                                            print(isEmailValid)
                                                        }
                                                        
                                                    }
                                                
                                            }.padding(.horizontal)
                                            
                                        } .overlay(
                                            Group {
                                                if showErrorDialog {
                                                    Color.clear.alert(isPresented: $showErrorDialog) {
                                                        Alert(
                                                            title: Text("Error"),
                                                            message: Text("Valid Email and Password is Required"),
                                                            dismissButton: .default(Text("OK"))
                                                        )
                                                    }
                                                } else if SuccessDialog {
                                                    Color.clear.alert(isPresented: $SuccessDialog) {
                                                        Alert(
                                                            title: Text("Success"),
                                                            message: Text("Login Successfully"),
                                                            dismissButton: .default(Text("OK"))
                                                        )
                                                    }
                                                }
                                            }
                                        )
                                        Text("Or")
                                            .foregroundColor(.white)
                                        HStack(spacing:15){
                                            Image("social-logins_Apple")
                                                .resizable()
                                                .frame(width:40,height:40)
                                            Image("social-logins_Google")
                                                .resizable()
                                                .frame(width:40,height:40)
                                            Image("social-logins_Amazon")
                                                .resizable()
                                                .frame(width:40,height:40)
                                            Image("social-logins_FB")
                                                .resizable()
                                                .frame(width:40,height:40)
                                            Image("social-logins_Twitter")
                                                .resizable()
                                                .frame(width:40,height:40)
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var hexValue: UInt64 = 0
        
        scanner.scanHexInt64(&hexValue)
        
        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(configuration.isOn ? Color.white : Color(hex: "2c2220"))
                configuration.label
            }
        }
        .foregroundColor( Color(hex: "2c2220"))
    }
}
