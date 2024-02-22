//
//  ScrollViewController.swift
//  TempSparrow24_02_19
//
//  Created by Egor Ledkov on 19.02.2024.
//

import UIKit

class ScrollViewController: UIViewController, UIGestureRecognizerDelegate {
	
	// MARK: - Constants
	
	private let imageHeight: CGFloat = 270
	private let imageName: String = "rock.jpg"
	
	// MARK: - UI Elements
	
	private lazy var scrollView: UIScrollView = makeScroll()
	private lazy var imageContainerView: UIView = makeContainer()
	private lazy var imageView: UIImageView = makeImage(named: imageName)
	private lazy var contentContainerView: UIView = makeContainer()
	
	// MARK: - Private Properties
	
	private var isHideStatusBar: Bool = false
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		setupLayout()
	}
	
	// MARK: - Private Methods
	
	private func setupUI() {
		view.backgroundColor = .systemBackground
		navigationController?.setNavigationBarHidden(true, animated: true)
		navigationController?.interactivePopGestureRecognizer?.delegate = self
		
		view.addSubview(scrollView)
		
		scrollView.addSubview(imageContainerView)
		scrollView.addSubview(imageView)
		scrollView.addSubview(contentContainerView)
	}
}

//MARK: - Status Bar Appearance

extension ScrollViewController {
	override var preferredStatusBarStyle: UIStatusBarStyle {
		.lightContent
	}
	
	override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
		.slide
	}
	
	override var prefersStatusBarHidden: Bool {
		isHideStatusBar
	}
	
	private func updateStatusBar() {
		let frame = contentContainerView.convert(contentContainerView.bounds, to: nil)
		
		isHideStatusBar = frame.minY < view.safeAreaInsets.top
		setNeedsStatusBarAppearanceUpdate()
	}
}

// MARK: - Constructors

private extension ScrollViewController {
	
	func makeScroll() -> UIScrollView {
		let scroll = UIScrollView()
		
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.scrollIndicatorInsets = UIEdgeInsets(top: imageHeight, left: 0.0, bottom: 8.0, right: 0.0)
		scroll.contentInsetAdjustmentBehavior = .never
		scroll.delegate = self
		
		return scroll
	}
	
	func makeImage(named: String) -> UIImageView {
		let uiImage = UIImage(named: named)
		let image = UIImageView(image: uiImage)
		
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		
		return image
	}
	
	func makeContainer(with backgroundColor: UIColor? = nil) -> UIView {
		let view = UIView()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		if let backgroundColor {
			view.backgroundColor = backgroundColor
		}
		
		return view
	}
}

// MARK: - Layout

private extension ScrollViewController {
	
	private func setupLayout() {
		let topImageAnchor = imageView.topAnchor.constraint(equalTo: view.topAnchor)
		topImageAnchor.priority = .defaultHigh
		
		let heightImageAnchor = imageView.heightAnchor.constraint(
			greaterThanOrEqualTo: imageContainerView.heightAnchor
		)
		heightImageAnchor.priority = .defaultLow
		
		let contentHeight = contentContainerView.heightAnchor.constraint(
			equalTo: scrollView.heightAnchor,
			multiplier: 2
		)
		contentHeight.priority = .defaultHigh
		
		NSLayoutConstraint.activate(
			[
				scrollView.topAnchor.constraint(equalTo: view.topAnchor),
				scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
				
				imageContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
				imageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				imageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				imageContainerView.heightAnchor.constraint(equalToConstant: imageHeight),
				
				topImageAnchor,
				imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				imageView.bottomAnchor.constraint(equalTo: contentContainerView.topAnchor),
				heightImageAnchor,
				
				contentContainerView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
				contentContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
				contentContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
				contentContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
				contentHeight,
				contentContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			]
		)
	}
}

// MARK: - UIScrollViewDelegate

extension ScrollViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let top = imageView.frame.height - view.layoutMargins.top
		scrollView.scrollIndicatorInsets = UIEdgeInsets(top: top, left: 0.0, bottom: 8.0, right: 0.0)
		
		updateStatusBar()
	}
}
