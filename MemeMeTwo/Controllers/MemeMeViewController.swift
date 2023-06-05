/*
 *  MemeMeViewController.swift
 *  MemeMeTwo
 *
 *  Created by Paul Lewallen on 6/4/23.
 *
 */

import UIKit

class MemeMeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var navBar           : UIToolbar!
    @IBOutlet weak var toolBar          : UIToolbar!
    @IBOutlet weak var scrollView       : UIScrollView!
    @IBOutlet weak var shareButton      : UIBarButtonItem!
    @IBOutlet weak var topTextField     : UITextField!
    @IBOutlet weak var imagePickerView  : UIImageView!
    @IBOutlet weak var bottomTextField  : UITextField!
    @IBOutlet weak var cameraButton     : UIBarButtonItem!
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {}
    
    override func viewWillAppear() {}
    
    override func viewWillDisappear() {}
    
    // MARK: UIImagePickerController Functions
    @IBAction func pickImageFromCamera () {}
    
    @IBAction func pickImageFromAlbum () {}
    
    // MARK: UIImagePickerController Delegates
    func imagePickerController () {}
    
    func imagePickerControllerDidCancel () {}
    
    // MARK: Notification Functions
    func subscribeToKeyboardNotifications () {}
    
    func unsubscribeFromKeyboardNotifications () {}
    
    // MARK: Keyboard Methods and Delegates
    @objc func keyboardWillShow () {}
    
    @objc func keyboardWillHide () {}
    
    func getKeyboardHeight () {}
    
    // MARK: Name Object Generation
    func generateMemeImage() -> UIImage {}
    
    func save () {}
    
    // MARK: Top Bar Button
    @IBAction func shareAction () {}
    
    @IBAction func cancelAction () {}
    
    // MARK: Animation
    override func viewWillTransition () {}
    
    @IBAction func setFont () {}
    
    // MARK: Helper Functions
    var statusBarHidden: Bool () {}
    
    override func viewWillLayoutSubviews () {}
    
    func configureBars () {}
    
    func resetTextfieldText () {}
    
    func presentImagePicker () {}
    
}

extension MemeMeViewController {}

extension MemeMeViewController {}
