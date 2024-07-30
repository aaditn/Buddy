import SwiftUI
import SwiftData
import CoreData

@available(iOS 18.0, *)
struct SignUpView: View {
    
    @EnvironmentObject var user: UserStore
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
    @State private var isPhoneValid: Bool = false
    
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var phoneError: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @State var mode: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("Get Started.")
                            .font(.system(size: 44, weight: .semibold))
                            .padding(.top, 20)
                            .padding(.horizontal, 24)
                           
                        Spacer()
                    }
                    HStack {
                        Text("Sign Up today.")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.horizontal, 28)
                            
                        Spacer()
                    }
                } .foregroundColor(Color("fg"))
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
                    fieldType: .phone
                )
                .onChange(of: phone) { newValue in
                    validatePhone(newValue)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
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
                  // if isNameValid && isEmailValid && isPasswordValid && isPhoneValid {
                        submit = true
                        print("Validation success")
                  // } else {
                        print(isNameValid)
                        print(isEmailValid)
                        print(isPasswordValid)
                        print(isPhoneValid)
                        print("Validation failed")
                     //   alertMessage = "Please fill in all fields correctly."
                   //     showAlert = true
                  // }
                }) {
                    Text("Sign Up")
                        .frame(width: 320, height: 59)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.white)
                        
                }
                .background(Color("primary"))
                .cornerRadius(10)
                .padding(40)
               
            }
            .padding(.top, 20)
            
            
            Spacer()
        }
        .onChange(of: submit) {
            print (submit)
            print("IEUGBAOIQGNFOQUEGBQ")
        }
        .fullScreenCover(isPresented: $submit, content: {
            BluetoothView(isIntro: true, mode: $mode)
        })
        .background(Color("white"))
    }
    
    func validateEmail(_ email: String) {
        isEmailValid = isValidEmail(email)
        emailError = isEmailValid ? "" : "Invalid email format"
    }
    
    func validatePhone(_ phone: String) {
        isPhoneValid = phone.count >= 10
        phoneError = isPhoneValid ? "" : "Phone number must be exactly 10 digits"
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

@available(iOS 18.0, *)
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
