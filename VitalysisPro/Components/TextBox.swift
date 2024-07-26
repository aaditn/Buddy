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
    private let validColor = Color.green.opacity(0.7)
    private let invalidColor = Color.white.opacity(0.7)
    
    var body: some View {
        
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("textBoxFill").opacity(0.7))
                .stroke(isValid ? validColor: invalidColor, lineWidth: 1)
            if fieldType == .password {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color("fg").opacity(0.5)))
                   
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundStyle(Color("fg"))
                    .padding(.horizontal, 21)
                    .frame(width: 320, height: 59)
                    .multilineTextAlignment(.leading) // Align text to the left
                    
                    .onChange(of: text) { newValue in
                        validateInput(newValue)
                    }
                
            } else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color("fg").opacity(0.5)))
                   
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundStyle(Color("fg"))
                    .padding(.horizontal, 21)
                    .frame(width: 320, height: 59)
                    .keyboardType(fieldType == .email ? .emailAddress : .default)
                    .multilineTextAlignment(.leading) // Align text to the left
                
                    .onChange(of: text) { newValue in
                        validateInput(newValue)
                    }
            }
                
        }
        .frame(height: 60)
        
        .onTapGesture {
            activeIndex = currentIndex
        }
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
