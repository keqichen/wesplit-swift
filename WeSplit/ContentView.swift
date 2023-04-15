//
//  ContentView.swift
//  WeSplit
//
//  Created by chenkeqi on 26.03.23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount=0.0
    @State private var numberOfPeople = 2
    @State var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = (0..<100)
    
    var totalAmount: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let totalAmount = checkAmount + tipValue
        return totalAmount
    }
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let totalPerPerson = (checkAmount + tipValue)/peopleCount
        return totalPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                           Text("\($0) people")
                        }
                    }
                }
                
                    Section{
                    Text("How much tip do you want to leave?")
                        NavigationLink(destination: TipView()){
                            Text("Choose your tips")
                        }
                    }
                    
//                    header: {
//                        Text("How much tip do you want to leave?")
//                    }
//                    .pickerStyle(.segmented)
//                }
           
                
                Section{
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total amount")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement:.keyboard){
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
    
struct TipView : View {
    @Binding var tipPercentage:Int
    let tipPercentages = (0..<100)
        var body: some View {
            NavigationView {
                Picker("Tip percentage",
                       selection: $tipPercentage){
                    ForEach(tipPercentages, id: \.self){
                        Text($0, format: .percent)
                    }
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
