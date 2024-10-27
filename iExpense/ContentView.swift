//
//  ContentView.swift
//  iExpense
//
//  Created by Syrene Haber Bartolome on 2024/10/14.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: item.currency))
                            .amountStyle(for: item.amount, currency: item.currency)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

extension View {
    func amountStyle(for amount: Double, currency: String) -> some View {
        let isGreen: Bool
                if currency == "USD" {
                    isGreen = amount < 10
                } else if currency == "EUR" {
                    isGreen = amount < 10
                } else if currency == "GBP" {
                    isGreen = amount < 10
                } else if currency == "JPY" {
                    isGreen = amount < 1000
                }else {
                    isGreen = false
                }
        
        let isBlue: Bool
                if currency == "USD" {
                    isBlue = amount < 100
                } else if currency == "EUR" {
                    isBlue = amount < 100
                } else if currency == "GBP" {
                    isBlue = amount < 100
                } else if currency == "JPY" {
                    isBlue = amount < 10000
                } else {
                    isBlue = false
                }

                return self
                    .foregroundColor(isGreen ? .green : isBlue ? .blue : .red)
                    .bold()
    }
}

#Preview {
    ContentView()
}
