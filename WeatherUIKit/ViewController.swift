//
//  ViewController.swift
//  WeatherUIKit
//
//  Created by Ivan Alejandro Hernandez Sanchez on 19/05/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToSwiftUIAction(_ sender: UIButton) {
        let swiftUIView = SwiftUIView()
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        present(hostingController, animated: true, completion: nil)
    }
    
}

