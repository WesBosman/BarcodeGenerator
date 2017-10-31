//
//  ViewController.swift
//  BarcodeGenerator
//
//  Created by s3m on 10/31/17.
//  Copyright © 2017 Wes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController:
    UIViewController,
    UITextFieldDelegate{
    
    @IBOutlet weak var stringToBarcodeLabel: UILabel!
    @IBOutlet weak var stringToBarcodeTextField: UITextField!
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var generateBarCodeButton: UIButton!
    @IBOutlet weak var barcodeSwitchLabel: UILabel!
    @IBOutlet weak var barcodeSwitch: UISwitch!
    let code128Generator    = "CICode128BarcodeGenerator"
    let codeAztecGenerator  = "CIAztecCodeGenerator"
    let codePdf417Generator = "CIPDF417BarcodeGenerator"
    let codeQRGenerator     = "CIQRCodeGenerator"
    let barcode             = "Barcode"
    let qRCode              = "QR Code"
    var isBarcode           = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view for generating a barcode
        stringToBarcodeTextField.delegate = self
    }
    
    @IBAction func generateBarcodeButtonWasPressed(_ sender: Any) {
        print("Generate Barcode button was pressed")
        
        if let barcodeString = stringToBarcodeTextField.text{
            print("Barcode String \(barcodeString)")
            generateBarcodeFromString(barcodeString: barcodeString)
        }
        else{
            print("Could not get barcode string")
        }
    }
    
    @IBAction func barcodeSwitchChanged(_ sender: Any) {
        // If the barcode switch is on then set the barcode switch text and set isBarcode to true
        if(barcodeSwitch.isOn){
            barcodeSwitchLabel.text = barcode
            isBarcode = true
        }
        else{
            barcodeSwitchLabel.text = qRCode
            isBarcode = false
        }
    }
    
    
    func generateBarcodeFromString(barcodeString: String){
        print("Generate Barcode from String")
        let data = barcodeString.data(using: .ascii, allowLossyConversion: false)
        var filter: CIFilter? = nil
        
        // If the barcode switch is on generate a Barcode otherwise generate QR Code
        if(isBarcode){
            filter = CIFilter(name: code128Generator)
        }
        else{
            filter = CIFilter(name: codeQRGenerator)
        }
        
        
        if let filt = filter{
            print("Using Filter to set data")
            filt.setValue(data, forKey: "inputMessage")
            
            if let image = filt.outputImage,
               let code  = barcodeSwitchLabel.text{
                print("Setting \(code) Image")
                self.barcodeImageView.image = UIImage(ciImage: image)
            }
        }
    }
}

