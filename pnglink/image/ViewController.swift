//
//  ViewController.swift
//  image
//
//  Created by LiJunliang on 16/5/12.
//  Copyright © 2016年 LiJunliang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let x = 52874,y=14293,z=18;
        let row = 6,colum = 6
        let start = "\(z)_\(x)_\(y).jpg"
        var arr = [[String]](count: row, repeatedValue: [String](count: colum, repeatedValue: ""))
        for irow in 0..<row {
            for icol in 0..<colum {
                arr[irow][icol] = "\(z)_\(x+icol)_\(y-irow).jpg"
            }
        }
        let size = CGRectMake(0, 0, CGFloat(colum*256), CGFloat(row*256)).size
        UIGraphicsBeginImageContext(size);
        
        for irow in 0..<row {
            for icol in 0..<colum {
                let temp = UIImage(named:"\(arr[irow][icol])")
                temp?.drawInRect(CGRectMake(CGFloat(icol*256), CGFloat(irow*256), 256, 256))
            }
        }
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        var data : NSData = UIImageJPEGRepresentation(image, 1.0)!
        var data1 : NSData = UIImagePNGRepresentation(image)!
        data.writeToFile("/Users/Lee/Desktop" + "/2.jpg", atomically: true)
        data1.writeToFile("/Users/Lee/Desktop" + "/2.png", atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

