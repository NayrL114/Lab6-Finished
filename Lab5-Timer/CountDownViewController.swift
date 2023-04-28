//
//  CountDownViewController.swift
//  Lab5-Timer
//
//  Created by Pan Li on 28/4/2023.
//

import UIKit

class CountDownViewController: UIViewController {
    
    var timer = Timer()
    var countdown: Int = 3

    @IBOutlet weak var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startCountDown()
        
        // Do any additional setup after loading the view.
    }
    
    // display a new screen for 3 seconds countdown
    func startCountDown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.countdown = self.countdown - 1
            self.countdownLabel.text = String(self.countdown)
            if self.countdown == 0 {
                //self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true)
                timer.invalidate()
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
