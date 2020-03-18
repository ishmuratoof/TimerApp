//
//  ViewController.swift
//  TimerApp
//
//  Created by Камиль on 21.02.2020.
//  Copyright © 2020 Kamil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Setting up current date
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let date = Date()
        let weekdayNumber = calendar.component(.weekday, from: date)
        var weekday: String
        
        //Defining time format
        dateFormatter.locale = .init(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        switch weekdayNumber {
        case 2:
            weekday = "Понедельник"
        case 3:
            weekday = "Вторник"
        case 4:
            weekday = "Среда"
        case 5:
            weekday = "Четверг"
        case 6:
            weekday = "Пятница"
        case 7:
            weekday = "Суббота"
        case 1:
            weekday = "Воскресенье"
        default:
            fatalError()
        }

        mainLabel.text = "\(weekday), \(dateFormatter.string(from: date))"
        
        timer()
    }
        
        //MARK: Setting up the timer
        
        func timer() {
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
}

