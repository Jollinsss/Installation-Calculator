//
//  ContentView.swift
//  Installation Calculator
//
//  Created by Grad Placement on 21/05/2020.
//  Copyright © 2020 Jaguar Land Rover Limited. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    @State var speed = 5.0
    @State var size = 100.0

    @State private var speedField = ""
    @State private var sizeField = ""
    @State private var timeLabel = "UPDATE ME"
    
    

    let speedExamples = ["kbps", "mbps", "gbps"]

    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .center) {

                    Spacer()

                    //TextField("Test", text: "Test")

                    Text("How long will your download take?")
                         .font(.subheadline)
                    Spacer()

                    Spacer()
                    
                    HStack {
                    TextField("Enter Speed...", text: $speedField)
                        .keyboardType(.numberPad)
                        .onReceive(Just(speedField)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.speedField = filtered
                                }
                        }
                        Text("Mbps")
                    }
                    
                    HStack {
                    TextField("Enter File Size...", text: $sizeField)
                        .keyboardType(.numberPad)
                        .onReceive(Just(sizeField)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.sizeField = filtered
                                }
                        }
                        Text("MB")
                        
                    }

                    Button(action: {
                        self.timeLabel = calculateDownload(speed: self.speedField, size: self.sizeField)}
                    ) {
                        Text("Calculate")
                     }
                     Spacer()
                    
                    Text(timeLabel)
                }
            }.navigationBarTitle("Installation Calculator")
        }
    }
}

func calculateDownload(speed: String, size: String) -> String
{
    let doubleSpeed = Double(speed)
    let doubleSize = Double(size)
    
    let formattedTime: String
    let formattedType: String
    
    let sizeInBits = doubleSize!*8
    let lengthOfTimeInSeconds = sizeInBits/doubleSpeed!
    let lengthOfTimeInMinutes = lengthOfTimeInSeconds/60
    let lengthOfTimeInHours = lengthOfTimeInMinutes/60
    let lengthOfTimeInDays = lengthOfTimeInHours/24
    print("Seconds: \(lengthOfTimeInSeconds)")
    print("Minutes: \(lengthOfTimeInMinutes)")
    print("Hours: \(lengthOfTimeInHours)")
    print("Days: \(lengthOfTimeInDays)")
    
    //days
    if lengthOfTimeInSeconds > 86400
    {
        formattedTime = String(format: "%.1f", lengthOfTimeInDays)
        formattedType = "days"
    }
    //hours
    else if lengthOfTimeInSeconds > 3600
    {
        formattedTime = String(format: "%.1f", lengthOfTimeInHours)
        formattedType = "hours"
    }
    //minutes
    else if lengthOfTimeInSeconds > 60
    {
        formattedTime = String(format: "%.1f", lengthOfTimeInMinutes)
        formattedType = "minutes"
    }
    //seconds
    else
    {
        formattedTime = String(format: "%.1f", lengthOfTimeInSeconds)
        formattedType = "seconds"
    }
    

    
    //timeLabel = "\(String(lengthOfTimeInMinutes)) minutes"
    
    print("The download of \(doubleSize!)MB at \(doubleSpeed!)mpbs will take \(lengthOfTimeInMinutes) minutes.")
    
   
    
    return formattedTime + " " + formattedType
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
