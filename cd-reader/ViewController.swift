//
//  ViewController.swift
//  cd-reader
//
//  Created by Arthur Efremenko on 9/22/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func codeValueButtonTapped(_ sender: ObjectInfoButton) {
        let alertController = UIAlertController(title: "Barcode Value", message: "Enter a value for this barcode", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = text
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            let input = alertController.textFields![0].text
            if !(input == nil && input!.isEmpty) {
                code.value = input!
            }
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
