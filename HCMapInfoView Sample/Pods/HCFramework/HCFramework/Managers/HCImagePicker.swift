//
//  HCImagePicker.swift
//  iOSTemplate
//
//  Created by Hypercube 2 on 10/3/17.
//  Copyright © 2017 Hypercube. All rights reserved.
//

import UIKit

public typealias CompletionHandler = (_ success:Bool, _ res:AnyObject?) -> Void

// NOTE: Add NSCameraUsageDescription to plist file

open class HCImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    open var imageSelectionInProgress = false
    open var imageSelectCompletitionHandler:CompletionHandler?
    
    open static let sharedManager: HCImagePicker =
        {
            let instance = HCImagePicker()
            return instance
    }()
    
    /// Open UIImagePickerController with Camera like source type with the possibility of setting Completition Handler Function.
    ///
    /// - Parameters:
    ///   - completitionHandler: Completion Handler Function. By default it is not set.
    open func takePictureFromCamera(completitionHandler:CompletionHandler? = nil)
    {
        self.imageSelectCompletitionHandler = completitionHandler
        self.openCamera()
    }
    
    /// Open UIImagePickerController with PhotosAlbum like source type with the possibility of setting Completition Handler Function.
    ///
    /// - Parameters:
    ///   - completitionHandler: Completion Handler Function. By default it is not set.
    open func getPictureFromGallery(completitionHandler:CompletionHandler? = nil)
    {
        self.imageSelectCompletitionHandler = completitionHandler
        self.openGallery()
    }
    
    /// Open dialog to choose the image source from where the image will be obtained.
    ///
    /// - Parameters:
    ///   - title: Dialog title. Default value is "Select picture".
    ///   - fromCameraButtonTitle: From camera button title. Default value is "From Camera".
    ///   - fromGalleryButtonTitle: From gallery button title. Default value is "From Gallery".
    ///   - cancelButtonTitle: Cancel button title. Default value is "Cancel".
    ///   - completitionHandler: Completion Handler Function. By default it is not set.
    open func selectPicture(title:String = "Select picture", fromCameraButtonTitle:String = "From Camera", fromGalleryButtonTitle:String = "From Gallery", cancelButtonTitle:String = "Cancel", completitionHandler:CompletionHandler? = nil)
    {
        self.imageSelectCompletitionHandler = completitionHandler
        HCDialog.showDialogWithMultipleActions(message: "", title: title, alertButtonTitles:
            [
                fromCameraButtonTitle,
                fromGalleryButtonTitle,
                cancelButtonTitle]
            , alertButtonActions:
            [
                { (alert) in
                    self.openCamera()
                },
                { (alert) in
                    self.openGallery()
                },
                nil
            ], alertButtonStyles:
            [
                .default,
                .default,
                .cancel
            ])
    }
    
    /// Open UIImagePickerController with Camera like source type
    private func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            imageSelectionInProgress = true
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /// Open UIImagePickerController with PhotosAlbum like source type
    private func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            imageSelectionInProgress = true
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                if let completiton = self.imageSelectCompletitionHandler
                {
                    completiton(true, image)
                }
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: {
            if let completiton = self.imageSelectCompletitionHandler
            {
                completiton(false, nil)
            }
        })
    }
}
