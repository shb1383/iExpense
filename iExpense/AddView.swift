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
    @State private var selectedCurrency = "USD"
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    let currencies = ["USD", "EUR", "JPY", "GBP"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { Text($0)
                    }
                }
                
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: selectedCurrency))
                                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: selectedCurrency)
                        expenses.items.append(item)
                        dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
