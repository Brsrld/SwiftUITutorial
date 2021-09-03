//
//  ContentView.swift
//  Tutorials
//
//  Created by Baris Saraldi on 3.09.2021.
//

import SwiftUI

struct ContentView: View {
    // MARK: -  Preview
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()
    @State private var shouldSendNewsLetter = false
    @State private var numberofLikes = 1
    @State var progressAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $firstName)
                    DatePicker("Birthdate", selection: $birthDate, displayedComponents: .date)
                }
                Section(header: Text("Actions"))  {
                    Toggle("Send Newsletter", isOn: $shouldSendNewsLetter)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                    
                    Stepper("Number of Likes", value: $numberofLikes, in: 1...100)
                    Text("This video has \(numberofLikes) likes")
                    Link("Terms of Service", destination:URL(string: "https://gameforge.com/en-GB/play/metin2")!)
                    
                    ProgressView("Progress...", value: progressAmount, total: 100)
                        .padding()
                        .accentColor(.green)
                        .onReceive(timer, perform: { _ in
                            if progressAmount < 100 {
                                progressAmount += 2
                            }
                        })//; Progress
                }
            }//; Form
            .navigationTitle("Account")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    Button("Save", action: saveUSer)
                }
            }
            
        }//; Navigation
        .accentColor(.red)
    }
    func saveUSer() {
        print("Save user")
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
        )
    }
}
#endif
