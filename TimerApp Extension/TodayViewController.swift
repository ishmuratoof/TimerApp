//
//  TodayViewController.swift
//  TimerApp Extension
//
//  Created by Камиль on 23.02.2020.
//  Copyright © 2020 Kamil. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Defining parameters
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let date = Date()
        let weekdayNumber = calendar.component(.weekday, from: date)
        dateFormatter.dateFormat = "HHmmss"
        
        let firstStart = "080000"
        let sixthEnd = "193000"

        let lessons = [
            calendar.date(bySettingHour: 09, minute: 35, second: 00, of: date),
            calendar.date(bySettingHour: 11, minute: 20, second: 00, of: date),
            calendar.date(bySettingHour: 13, minute: 45, second: 00, of: date),
            calendar.date(bySettingHour: 15, minute: 30, second: 00, of: date),
            calendar.date(bySettingHour: 17, minute: 45, second: 00, of: date),
            calendar.date(bySettingHour: 19, minute: 30, second: 00, of: date)
        ]
        
        let breakStart = ["093500",
                       "112000",
                       "134500",
                       "153000",
                       "174500",
                       "193000"]
        
        let breakEnd = ["094500",
                        "121000",
                        "135500",
                        "161000",
                        "175500",
                        "194000"]
        
        //Check whether there are no lessons
        guard (weekdayNumber != 1) else {
            timerLabel.text = "Выходной 🥳"
            return
        }

        if (dateFormatter.string(from: date) < firstStart) || (dateFormatter.string(from: date) > sixthEnd) {
            timerLabel.text = "Сейчас пар нет"
            return
        }
        
        //MARK: Setting up the timer
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let date = Date()
    
            var timer: DateInterval
            var hour: Int
            var minute: Int
            var second: Int
            
            for index in 0...5 {
                    if (dateFormatter.string(from: date) > breakStart[index]) && (dateFormatter.string(from: date) < breakEnd[index]) {
                        self.timerLabel.text = "Перерыв"
                        return
                    }
            }
            
            for lesson in lessons {
                if (dateFormatter.string(from: date) < dateFormatter.string(from: lesson!)) {
                    timer = DateInterval(start: date, end: lesson!)
                    hour = Int(timer.duration / 3600)
                    minute = Int(timer.duration) % 3600 / 60
                    second = Int(timer.duration) % 3600 % 60
                    self.timerLabel.text = "0\(hour):\(minute):\(second)"
                    if Int(second / 10) == 0 {
                        self.timerLabel.text = "0\(hour):\(minute):0\(second)"
                    }
                    if Int(minute / 10) == 0 {
                        self.timerLabel.text = "0\(hour):0\(minute):\(second)"
                    }
                    if (Int(second / 10) == 0) && (Int(minute / 10) == 0) {
                        self.timerLabel.text = "0\(hour):0\(minute):0\(second)"
                    }
                    break
                }
            }
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
