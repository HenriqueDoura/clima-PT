//
//  ViewController.swift
//  Qual o clima?
//
//  Created by Henrique Dev on 06/01/16.
//  Copyright © 2016 Henrique Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeatherButton(sender: AnyObject) {
    
        let requestedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        
        
        if let url = requestedUrl {
            
            
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                
                let httpResponse = response as! NSHTTPURLResponse
                
                
                if httpResponse.statusCode == 200 {
                    
                    if let urlContent = data {
                        
                        
                        
                        let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                        
                        
                        
                        let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                        
                        
                        
                        if websiteArray.count > 1 {
                            
                            
                            
                            let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                            
                            
                            
                            if weatherArray.count > 1 {
                                
                                
                                
                                let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg", withString: "º")
                                
                                
                                
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    
                                    self.resultLabel.text = weatherSummary
                                    
                                })
                                
                                
                                
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            
            
            task.resume()
            
            
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.resultLabel.text = "Cidade não encontrada, tente novamente."

                
            })

                    
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    
    
}


