import SwiftUI

struct PatternView: View {
    
    var log: Person
    @Binding var cover: Bool
    
    @State private var taps: [TapInfo] = []
    @State private var timestamps: [Double] = []
    @State private var startTime: DispatchTime? = nil
    @State private var timerValue: Double = 0
    @State private var timer: Timer? = nil
    @State private var isPaused: Bool = false
    @State private var pausedTime: Double = 0
    
    @State var cancel: Bool = false

    
    

    var body: some View {
      
        
        VStack {
           
            ZStack {
                VStack {
                    
                    HStack {
                        Button(action:{
                            cover = false
                        }){
                            Text("Cancel")
                                .foregroundStyle(Color.blue)
                                .font(.system(size: 17, weight: .medium))
                        }.padding(.leading, 20)
                        Spacer()
                        Button(action:{
                            print (timestamps)
                            print(getCurrentTime())
                            log.pattern = Pattern(timestamps: timestamps, length: getCurrentTime())
                            cover = false
                        }){
                            Text("Save")
                                .foregroundStyle(Color.blue)
                                .font(.system(size: 17, weight: .bold))
                        }.padding(.trailing, 20)
                    }
                    Text("New Vibration Pattern")
                        .font(.system(size: 30, weight: .semibold))
                        .padding(.top, 15)
                    Divider()
                        .background(Color.black.opacity(0.7))
                    Spacer()
                }
                if (taps.isEmpty) {
                    Text("Tap your fingertips to the screen to create a custom vibration pattern.")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: 300)
                        .foregroundStyle(Color.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                Rectangle()
                    .fill(Color.black.opacity(0.001))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture(coordinateSpace: .global) { location in
                        let newTap = TapInfo(id: UUID(), location: location)
                        taps.append(newTap)
                        startAnimation(for: newTap)
                        registerTap()
                    }.padding(.top, 20)
                    

                ForEach(taps) { tap in
                    animateCircle(tapInfo: Binding(
                        get: { tap },
                        set: { newValue in
                            if let index = taps.firstIndex(where: { $0.id == newValue.id }) {
                                taps[index] = newValue
                            }
                        }
                    ))
                }
            }
            .background(Color("bg"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          
            .padding(.bottom, 10)
           
            
            VStack {
                HStack {
                    TimelineView(timerValue: $timerValue, timestamps: $timestamps)
                    Text(formatSecondsToMinutes(seconds: timerValue))
                        .padding(.trailing, 30)
                }
                HStack {
                    Button(action: {
                        if (isPaused) {
                            resumeTimer()
                        }
                       
                    }) {
                        Text("Play")
                    }
                    Spacer()
                    Button(action: {
                        if (!isPaused) {
                            pauseTimer()
                        }
                    }) {
                        Text("Stop")
                    }
                }
                .padding(.horizontal, 30)
            }
        }
        .onAppear {
            startTimer()
        }
       
        
        
    }
    
    func formatSecondsToMinutes(seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }

    private func registerTap() {
        let currentTime = getCurrentTime()
        timestamps.append(currentTime)
        if startTime == nil {
            startTime = DispatchTime.now()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if !self.isPaused, let startTime = self.startTime {
                self.timerValue = self.getCurrentTime()
            }
        }
    }

    private func pauseTimer() {
        isPaused = true
        pausedTime = getCurrentTime()
        timer?.invalidate()
    }

    private func resumeTimer() {
        isPaused = false
        startTime = DispatchTime.now() - Double(pausedTime)
        startTimer()
    }

    private func getCurrentTime() -> Double {
        guard let startTime = startTime else { return 0 }
        return Double(DispatchTime.now().uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000
    }

    private func startAnimation(for tap: TapInfo) {
        if let index = taps.firstIndex(where: { $0.id == tap.id }) {
            withAnimation(Animation.easeOut(duration: 1).repeatCount(1, autoreverses: false)) {
                taps[index].opacity = 0
                taps[index].brightness = 1
                taps[index].color = Color.blue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                taps.removeAll { $0.id == tap.id }
            }
        }
    }
}

struct TimelineView: View {
    @Binding var timerValue: Double
    @Binding var timestamps: [Double]

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background color before the last dot
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("primary").opacity(0.3))
                    .frame(width: getWidthForPrimaryColor(geometry.size.width), height: 20)
                    .padding(.leading, 20)
                
                // Greyed-out area after the last dot
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: geometry.size.width - getWidthForPrimaryColor(geometry.size.width) - 40, height: 20)
                    .offset(x: getWidthForPrimaryColor(geometry.size.width) + 20)
                
                // Dots
                ZStack(alignment: .leading) {
                    ForEach(timestamps, id: \.self) { timestamp in
                        Circle()
                            .fill(Color("primary"))
                            .frame(width: 25, height: 25)
                            .position(x: min(CGFloat(timestamp / max(timerValue, 1)) * (geometry.size.width - 40) + 20, geometry.size.width - 15), y: 10)
                    }
                }
            }
        }
        .frame(height: 20)
    }

    private func getWidthForPrimaryColor(_ totalWidth: CGFloat) -> CGFloat {
        // Calculate width up to the last timestamp
        guard let lastTimestamp = timestamps.max() else { return 0 }
        let relativeWidth = CGFloat(lastTimestamp / max(timerValue, 1)) * (totalWidth - 40) // Adjust for padding
        return min(relativeWidth, totalWidth - 40)
    }
}



struct animateCircle: View {
    @Binding var tapInfo: TapInfo

    var body: some View {
        ZStack {
            Circle()
                .stroke(tapInfo.color, lineWidth: 5)
                .frame(width: tapInfo.size, height: tapInfo.size)
                .opacity(tapInfo.opacity)
                .position(x: tapInfo.location.x, y: tapInfo.location.y)
            Circle()
                .stroke(tapInfo.color, lineWidth: 5)
                .frame(width: tapInfo.size * 1.3, height: tapInfo.size * 1.3)
                .opacity(tapInfo.opacity)
                .position(x: tapInfo.location.x, y: tapInfo.location.y)
        }
        .clipped() // Ensures that any overflow is clipped
    }
}

struct TapInfo: Identifiable {
    let id: UUID
    let location: CGPoint
    var opacity: Double = 1
    var size: CGFloat = 50
    var brightness: Double = 0
    var color: Color = Color.blue
}

struct PatternView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        @State var arr: Bool = false
        
        PatternView(log: UserStore.example().people.first!, cover: $arr)
    }
}
