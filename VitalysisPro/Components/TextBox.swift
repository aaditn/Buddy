import SwiftUI

struct TextBox: View {
    @Binding var text: String
    var placeholder: String
    @Binding var activeIndex: Int
    var currentIndex: Int
    var fieldType: FieldType
    
    enum FieldType {
        case normal
        case email
        case password
    }
    
    // Validation state
    @State private var isValid: Bool = false
    
    // Colors defined directly in the struct
    private let activeColor = Color("boxBefore")
    private let inactiveColor = Color("boxAfter")
    private let validColor = Color("primary").opacity(0.5)
    private let invalidColor = Color.gray.opacity(0.3)
    
    var body: some View {
        Group {
            
            if fieldType == .password {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color("white")))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundStyle(Color("white"))
                    .padding(.horizontal, 21)
                    .frame(width: 320, height: 59)
                    .multilineTextAlignment(.leading) // Align text to the left
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isValid ? validColor : invalidColor, lineWidth: 4)
                    )
                    .onChange(of: text) { newValue in
                        validateInput(newValue)
                    }
                
            } else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color("white")))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundStyle(Color("white"))
                    .foregroundStyle(Color("white"))
                    .padding(.horizontal, 21)
                    .frame(width: 320, height: 59)
                    .keyboardType(fieldType == .email ? .emailAddress : .default)
                    .multilineTextAlignment(.leading) // Align text to the left
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isValid ? validColor : invalidColor, lineWidth: 4)
                    )
                    .onChange(of: text) { newValue in
                        validateInput(newValue)
                    }
            }
            
        }
        
        .onTapGesture {
            activeIndex = currentIndex
        }
        .background(activeIndex == currentIndex ? activeColor : inactiveColor)
        .padding(30)
    }
    
    private func validateInput(_ value: String) {
        switch fieldType {
        case .normal: 
           // break
            // Example validation for a normal field (e.g., name)
            isValid = value.count > 0
        case .email:
            // Example validation for email
            isValid = isValidEmail(value)
        case .password:
            // Example validation for password (e.g., length check)
            isValid = value.count > 5
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct TextBox_Previews: PreviewProvider {
    static var previews: some View {
        TextBox(text: .constant(""), placeholder: "Placeholder", activeIndex: .constant(-1), currentIndex: 0, fieldType: .normal)
    }
}
