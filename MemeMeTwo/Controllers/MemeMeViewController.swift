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
    override func viewDidLoad () {
        super.viewDidLoad ()
        
        setTextFields (textField : topTextField, string : AppModel.defaultTopTextFieldText)
        setTextFields (textField : bottomTextField, string : AppModel.defaultBottomTextFieldText)
        
        scrollView.delegate = self
        scrollView.backgroundColor  = UIColor.black
    }
    
    override func viewWillAppear () {
        super.viewWillAppear (animated)
        self.navigationController?.isNavigationBarHidden = true
        
        if AppModel.currentFontIndex != -1 {
            topTextField.font       = UIFont (name : AppModel.selectedFont, size : 38)
            bottomTextField.font    = UIFont (name : AppModel.selectedFont, size : 38)
        }
        
        if let _ = imagePickerView.image {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable (UIImagePickerController.SourceType.camera)
        self.subscribeToKeyboardNotifications ()
    }
    
    override func viewWillDisappear (_ animated : Bool) {
        super.viewWillDisappear (animated)
        unsubscribeFromKeyboardNotifications ()
    }
    
    // MARK: UIImagePickerController Functions
    @IBAction func pickImageFromCamera (sender : AnyObject) {
        presentImagePicker (sourceType : UIImagePickerController.SourceType.camera)
    }
    
    @IBAction func pickImageFromAlbum (_ sender : AnyObject) {
        // To pick an image from photo albums
        presentImagePicker (sourceType : UIImagePickerController.SourceType.photoLibrary)
    }
    
    // MARK: UIImagePickerController Delegates
    func imagePickerController (_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]) {
        
        // To select an image and set it to imageView
        if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            self.view.layoutIfNeeded ()
            
            setZoomScaleForImage (scrollViewSize : scrollView.bounds.size)
            scrollView.zoomScale = scrollView.minimumZoomScale
            
            centerImage ()
            self.dismiss (animated : true, completion : nil)
        }
    }
    
    func imagePickerControllerDidCancel (_ picker : UIImagePickerController) {
        dismiss (animated : true, completion: nil)
    }
    
    // MARK: Notification Functions
    func subscribeToKeyboardNotifications () {
        NotificationCenter.default.addObserver (self, selector : #selector (keyboardWillShow), name : UIResponder.keyboardWillShowNotification, object : nil)
        
        NotificationCenter.default.addObserver (self, selector : #selector (keyboardWillHide), name : UIResponder.keyboardWillHideNotification, object : nil)
    }
    
    func unsubscribeFromKeyboardNotifications () {
        NotificationCenter.default.removeObserver (self, name : UIResponder.keyboardWillShowNotification, object : nil)
        NotificationCenter.default.removeObserver (self, name : UIResponder.keyboardWillHideNotification, object : nil)
    }
    
    // MARK: Keyboard Methods and Delegates
    @objc func keyboardWillShow (notification : NSNotification) {
        if bottomTextField.isFirstResponder {
            self.view.frame.origin.y -= getKeyboardHeight (notification : notification)
        }
    }
    
    @objc func keyboardWillHide (notification : NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight (notification : NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Name Object Generation
    func generateMemeImage () -> UIImage {
        configureBars (hidden : true)
        UIGraphicsBeginImageContext (self.view.frame.size)
        
        self.view.drawHierarchy (in : self.view.frame, afterScreenUpdates : true)
        let memeImage : UIImage = UIGraphicsGetImageFromCurrentImageContext ()!
        
        UIGraphicsEndImageContext ()
        configureBars (hidden : false)
        return memeImage
    }
    
    func save (memeImag : UIImage) {
        let meme = Meme (topText : topTextField.text! as NSString?, bottomText: bottomTextField.text! as NSString?, image : imagePickerView.image, memeImage : memeImage) (UIApplication.shared.delegate as! AppDelegate).meme.append(meme)
    }
    
    // MARK: Top Bar Button
    @IBAction func shareAction (_ sender : AnyObject) {
        let memeImage = generateMemeImage ()
        let shareActivityViewController = UIActivityViewController (activityItems : [memeImage], applicationActivities : nil)
        
        shareActivityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.save (memeImage : memeImage)
                self.dismiss (animated : true, completion : nil)
            }
        }
        present (shareActivityViewController, animated : true, completion : nil)
    }
    
    @IBAction func cancelAction (_ sender : AnyObject) {
        if imagePickerView.image != nil {
            let alert   = UIAlertController (title : AppModel.alert.alertTitle, message : AppModel.alert.alertMessage, preferredStyle : .alert)
            let yes     = UIAlertAction (title : "Yes", style : .default) {
                (UIAlertAction) in
                
                self.imagePickerView.image = nil
                self.resetTextfieldText ()
                self.shareButton.isEnabled = false
            }
        }
    }
    
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

extension MemeMeViewController : UITextFieldDelegate {
    
    // MARK: UITextField Extension
    func textField () {}
    
    func setTextFields () {}
    
    func textFieldDidBeginEditing () {}
    
    func textFieldDidEndEnding () {}
    
    func textFieldShouldReturn () {}
}

extension MemeMeViewController : UIScrollViewDelegate {
    
    // MARK: Center Image
    func centerImage () {}
    
    // MARK: Zoom Scale
    func setZoomScaleForImage () {}
    
    // MARK: UIScrollView Extension
    func viewForZooming () {}
    
    func scrollViewDidZoom () {}
}
