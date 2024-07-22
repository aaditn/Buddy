//
//  MigraineTracking.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/18/24.
//

import SwiftUI
import Charts

struct DataView: View {
   
    @State var index: Int = 0
    var body: some View {
        VStack {
            ZStack {
                Image("header")
                    .resizable()
                    .frame(height: 153)
                VStack {
                    HStack {
                        Text("Data")
                            .font(.system(size: 40, weight: .semibold))
                            .padding(.leading, 20)
                        Spacer()
                    }
                    HStack {
                        Text(index == 0 ? "Migraine Tracking" :
                                index == 1 ? "Migraine Info" :
                                index == 2 ? "Education": "")
                        .font(.system(size: 25, weight: .medium))
                        .padding(.leading, 20)
                        Spacer()
                    }
                    
                }
                
                .padding(.top, 40)
            }.foregroundStyle(Color("white"))
            
            migraineRating()
            Spacer()
               
            
            
        } .ignoresSafeArea(edges: .all)
            .background(Color("bg"))
        
    }
}

struct migraineRating: View {
    @EnvironmentObject var user: userStore
    @State var logs: [MigraineLog] = [
        MigraineLog(date: Date.distantPast, severity: 1),
        MigraineLog(date: Date.now, severity: 9),
        MigraineLog(date: Date.distantFuture, severity: 7)
    ]
    var body: some View {
        VStack {
            HStack {
                Image("brain")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40)
                    .padding(.leading, 20)
                Text("Migraine Rating")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color("primary"))
                    .padding(.leading, 10)
                Spacer()
                
            }
            Text("You averaged a 10% decrease in migraine symptoms.")
                .font(.system(size: 21, weight: .medium))
                .foregroundStyle(Color.white)
                .frame(width: 300)
                .multilineTextAlignment(.center)
           
            
            
            
           //ChartView(logs: $logs)
        }
        
    }
}

struct ChartView: View {
    @Binding var logs: [MigraineLog]
    
    var body: some View {
        Text("hello world")
        Chart {
            ForEach(logs, id: \.date) { log in
                LineMark(
                    x: .value("Date", log.date),
                    y: .value("Severity", log.severity)
                )
            }
        }
    }
}

#Preview {
   DataView()
  
        
}
