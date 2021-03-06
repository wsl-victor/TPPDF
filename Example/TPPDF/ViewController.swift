//
//  ViewController.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 11/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

import UIKit
import TPPDF

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generatePDF()
    }
    
    func generatePDF() {
        let pdf = PDFGenerator(format: .A4)
        
        pdf.addText(.FooterCenter, text: "Created using TPPDF for iOS.")
        pdf.addText(.HeaderLeft, text: "Recipe: Pasta with tomato sauce")
        
        let title = NSMutableAttributedString(string: "Pasta with tomato sauce", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(28.0),
            NSForegroundColorAttributeName : UIColor(red: 219.0 / 255.0, green: 100.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
            ])
        pdf.addAttributedText(text: title)
        
        let category =  NSAttributedString(string: "Category: Meal", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(16.0),
            NSForegroundColorAttributeName : UIColor.darkGrayColor()
            ])
        pdf.addAttributedText(text: category)
        
        pdf.addSpace(space: 12.0)
        
        pdf.addLineSeparator(thickness: 0.1, color: UIColor.lightGrayColor())
        pdf.addSpace(space: 12.0)
        
        pdf.addImage(image: UIImage(named: "Image.jpg")!)
        
        pdf.addSpace(space: 12.0)
        pdf.addLineSeparator(thickness: 0.1, color: UIColor.lightGrayColor())
        
        pdf.addSpace(space: 12.0)
        
        let tableData: [[String]] = [
            ["Rating",     "4.5 / 5",  "Prep\nTime:",   "14 Hours"      ],
            ["Portions:",   "14",       "Cook\nTime:",   "16 Minutes",   ]
        ]
        let tableAlignment: [[TableCellAlignment]] = [
            [.Left, .Center, .Left, .Center],
            [.Left, .Center, .Left, .Center]
        ]
        let tableWidth: [CGFloat] = [
            0.3, 0.2, 0.3, 0.2
        ]
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 5, margin: 5, lineWidth: 0)
        
        pdf.addSpace(space: 12.0)
        
        let ingridients = NSMutableAttributedString(string: "Ingridients")
        ingridients.addAttributes([
            NSFontAttributeName : UIFont.systemFontOfSize(20.0),
            NSForegroundColorAttributeName : UIColor(red: 219.0 / 255.0, green: 100.0 / 255.0, blue: 58.0 / 255.0,
                alpha: 1.0)
            ], range: NSMakeRange(0, ingridients.length))
        pdf.addAttributedText(text: ingridients)
        
        pdf.addSpace(space: 6.0)
        
        let ingridientsString: String = {
            var result = ""
            for i in 1...10 {
                result = result + "Ingridient \(i)\n"
            }
            return result
        }()
        pdf.addText(text: ingridientsString, lineSpacing: 4.0)
        
        pdf.addSpace(space: 12.0)
        
        let descriptionHeader = NSMutableAttributedString(string: "Description")
        descriptionHeader.addAttributes([
            NSFontAttributeName : UIFont.systemFontOfSize(20.0),
            NSForegroundColorAttributeName : UIColor(red: 219.0 / 255.0, green: 100.0 / 255.0, blue: 58.0 / 255.0,
                
                alpha: 1.0)
            ], range: NSMakeRange(0, descriptionHeader.length))
        pdf.addAttributedText(text: descriptionHeader)
        
        pdf.addSpace(space: 6.0)
        
        pdf.addText(text: "Explain how to prep and cook this recipe here.\n\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et ")
        pdf.setIndentation(indent: 50)
        pdf.addText(text: "dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet,")
        
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let url = NSURL(fileURLWithPath: path).URLByAppendingPathComponent("temp.pdf")
        let data = pdf.generatePDFdata()
        do {
            try data.writeToURL(url, options: .AtomicWrite)
        } catch {
            print(error)
        }
        
        (self.view as? UIWebView)?.loadData(data, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: NSURL())
        
    }
}