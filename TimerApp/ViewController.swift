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
        // Do any additional setup after loading the view.
        
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
        
        let firstStart = calendar.date(bySettingHour: 08, minute: 00, second: 00, of: date)
        let sixthEnd = calendar.date(bySettingHour: 19, minute: 30, second: 00, of: date)
                                    
        let firstBreakStart = calendar.date(bySettingHour: 09, minute: 35, second: 00, of: date)
        let firstBreakEnd = calendar.date(bySettingHour: 09, minute: 45, second: 00, of: date)
        let secondBreakStart = calendar.date(bySettingHour: 11, minute: 20, second: 00, of: date)
        let secondBreakEnd = calendar.date(bySettingHour: 12, minute: 10, second: 00, of: date)
        let thirdBreakStart = calendar.date(bySettingHour: 13, minute: 45, second: 00, of: date)
        let thirdBreakEnd = calendar.date(bySettingHour: 13, minute: 55, second: 00, of: date)
        let fourthBreakStart = calendar.date(bySettingHour: 15, minute: 30, second: 00, of: date)
        let fourthBreakEnd = calendar.date(bySettingHour: 16, minute: 10, second: 00, of: date)
        let fifthBreakStart = calendar.date(bySettingHour: 17, minute: 45, second: 00, of: date)
        let fifthBreakEnd = calendar.date(bySettingHour: 17, minute: 55, second: 00, of: date)

        let lessons = [
            calendar.date(bySettingHour: 09, minute: 35, second: 00, of: date),
            calendar.date(bySettingHour: 11, minute: 20, second: 00, of: date),
            calendar.date(bySettingHour: 13, minute: 45, second: 00, of: date),
            calendar.date(bySettingHour: 15, minute: 30, second: 00, of: date),
            calendar.date(bySettingHour: 17, minute: 45, second: 00, of: date),
            calendar.date(bySettingHour: 19, minute: 30, second: 00, of: date)
        ]
        
        
        //MARK: Setting up the timer
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let date = Date()
            
            dateFormatter.dateFormat = "HHmmss"
            
            //Check whether there are no lessons
            guard (weekday != "Воскресенье") else {
                self.timerLabel.text = "Выходной 🥳"
                return
            }

            if (dateFormatter.string(from: date) < dateFormatter.string(from: firstStart!)) || (dateFormatter.string(from: date) > dateFormatter.string(from: sixthEnd!)) {
                self.timerLabel.text = "Сейчас пар нет"
            }

            if (dateFormatter.string(from: date) > dateFormatter.string(from: firstBreakStart!)) && (dateFormatter.string(from: date) < dateFormatter.string(from: firstBreakEnd!)) {
                self.timerLabel.text = "Перерыв"
                return
            }

            if (dateFormatter.string(from: date) > dateFormatter.string(from: secondBreakStart!)) && (dateFormatter.string(from: date) < dateFormatter.string(from: secondBreakEnd!)) {
                self.timerLabel.text = "Перерыв"
                return
            }

            if (dateFormatter.string(from: date) > dateFormatter.string(from: thirdBreakStart!)) && (dateFormatter.string(from: date) < dateFormatter.string(from: thirdBreakEnd!)) {
                self.timerLabel.text = "Перерыв"
                return
            }

            if (dateFormatter.string(from: date) > dateFormatter.string(from: fourthBreakStart!)) && (dateFormatter.string(from: date) < dateFormatter.string(from: fourthBreakEnd!)) {
                self.timerLabel.text = "Перерыв"
                return
            }

            if (dateFormatter.string(from: date) > dateFormatter.string(from: fifthBreakStart!)) && (dateFormatter.string(from: date) < dateFormatter.string(from: fifthBreakEnd!)) {
                self.timerLabel.text = "Перерыв"
                return
            }
            
            var timer: DateInterval
            var hour: Int
            var minute: Int
            var second: Int
            
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

