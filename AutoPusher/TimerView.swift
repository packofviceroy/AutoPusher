//
//  ContentView.swift
//  AutoPusher
//
//  Created by dumbo on 6/13/24.
//


import SwiftUI

struct TimerView: View {
    @State private var _startRec = false
    @State private var _buttonText = "START"
    @State private var _startTime = Date.now
    @State private var _timeText = "00:00:00.000"
    
    let _timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack {
            Button(self._buttonText, action:changeButtonState)
                .buttonStyle(MyButtonStyle(labelWidth: 400, labelHeight: 300, scaleFactor: 1))
            
            Text("\(_timeText)")
                .onReceive(_timer) { input in
                    if _startRec{
                        updateTimer()
                    }
                }
                .font(Font.system(size: 60))

        }
    }
    
    func updateTimer() {
            let _timeInterval =  Date().timeIntervalSince(_startTime)
            _timeText = _timeInterval.stringFromTimeInterval()
        }
    
    func changeButtonState() -> Void{
        _startRec.toggle()
        if _startRec{
            _buttonText="STOP"
            _startTime = Date.now
        }else{
            _buttonText="START"
            _startTime = Date.now
        }
    }
}

extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
}


#Preview {
    TimerView()
}
