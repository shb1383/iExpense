//
//  AddView.swift
//  iExpense
//
//  Created by Syrene Haber Bartolome on 2024/10/17.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var selectedCurrency = "JPY"
    
    var expenses: Expenses
    
    let types = ["Personal", "Business"]
    let currencies = ["JPY", "USD", "EUR", "GBP"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Expense Details")) {
                    TextField("Name", text: $name)
                
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) { type in Text(type)
                        }
                    }
                
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                
                    TextField("Amount", value: $amount, format: .currency(code: selectedCurrency))
                        .keyboardType(.decimalPad)
                }
            }
            .padding(.top, -50)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                            
                ToolbarItem(placement: .principal) {
                    Text("New Expense")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let item = ExpenseItem(name: name, type: type, amount: amount, currency: selectedCurrency)
                        expenses.items.append(item)
                        dismiss()
                    }
                    .disabled(name.isEmpty || amount <= 0)
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
