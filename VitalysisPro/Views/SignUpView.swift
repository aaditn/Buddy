import SwiftUI
import SwiftData
import CoreData

struct SignUpView: View {
    
    @EnvironmentObject var user: userStore
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var activeIndex: Int = -1
    @State private var submit: Bool = false

    // Validation state
    @State private var isNameValid: Bool = true
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("Get Started.")
                            .font(.system(size: 44, weight: .semibold))
                            .padding(.top, 20)
                            .padding(.horizontal, 24)
                            .foregroundColor(Color("white")) // Updated to use `foregroundColor`
                        Spacer()
                    }
                    HStack {
                        Text("Sign Up today.")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.horizontal, 28)
                            .foregroundColor(Color("white")) // Updated to use `foregroundColor`
                        Spacer()
                    }
                }
            }
            VStack {
                TextBox(
                    text: $name,
                    placeholder: "Preferred Name",
                    activeIndex: $activeIndex,
                    currentIndex: 0,
                    fieldType: .normal
                )
               
                
                TextBox(
                    text: $phone,
                    placeholder: "Phone",
                    activeIndex: $activeIndex,
                    currentIndex: 1,
                    fieldType: .normal
                )
                
                TextBox(
                    text: $email,
                    placeholder: "Email",
                    activeIndex: $activeIndex,
                    currentIndex: 2,
                    fieldType: .email
                )
                .onChange(of: email) { newValue in
                    validateEmail(newValue)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                TextBox(
                    text: $password,
                    placeholder: "Password",
                    activeIndex: $activeIndex,
                    currentIndex: 3,
                    fieldType: .password
                )
                .onChange(of: password) { newValue in
                    validatePassword(newValue)
                }
                
                Button(action: {
                    if isNameValid && isEmailValid && isPasswordValid && !phone.isEmpty {
                        user.setAll(
                            n: name,
                            s: [Servo(power: 0), Servo(power: 0), Servo(power: 0)],
                            m: [MigraineLog(date: Date.now, severity: 5)])
                        submit = true
                        print ("validation success")
                    } else {
                        print (isNameValid)
                        print (isEmailValid)
                        print (isPasswordValid)
                        print (!phone.isEmpty)
                        print("Validation failed")
                    }
                }) {
                    Text("Sign Up")
                        .frame(width: 320, height: 59)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("white"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .background(Color("primary"))
                .cornerRadius(10)
                .padding(40)
                .fullScreenCover(isPresented: $submit, content: {
                    BluetoothView()
                })
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .background(Color("bg"))
    }
    
    func validateEmail(_ email: String) {
        isEmailValid = isValidEmail(email)
        emailError = isEmailValid ? "" : "Invalid email format"
    }
    
    func validatePassword(_ password: String) {
        isPasswordValid = password.count > 5
        passwordError = isPasswordValid ? "" : "Password must be longer than 5 characters"
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email)
    }

    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
