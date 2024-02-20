//
//  ViewController.swift
//  TempSparrow24_02_19
//
//  Created by Egor Ledkov on 20.02.2024.
//

import UIKit

final class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		let frame = CGRect(x: view.frame.midX - 50, y: view.frame.midY - 50, width: 100, height: 20)
		let button = UIButton(frame: frame, primaryAction: UIAction(handler: { _ in
			let scrollVC = ScrollViewController()
			
			self.navigationController?.pushViewController(scrollVC, animated: true)
		}))
		button.setTitle("To ScrollVC", for: .normal)
		button.setTitleColor(.tintColor, for: .normal)
		
		view.addSubview(button)
	}
}
