import UIKit



class CameraViewController: UIViewController, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    
    
    var showPopOver = false
    let imagePicker = UIImagePickerController()
    var popover: UIPopoverController!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func sourcePopOver() {
        let alert:UIAlertController = UIAlertController(title: "Choose Source", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.camera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.gallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            presentViewController(alert, animated: true, completion: nil)
        }
        else {
            popover = UIPopoverController(contentViewController: alert)
            popover!.presentPopoverFromRect( CGRectMake(150, 497, 300, 59), inView: view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
        
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.allowsEditing = true
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            imagePicker.videoQuality = UIImagePickerControllerQualityType.TypeHigh
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera)!
            imagePicker.view.frame = cameraView.frame
            cameraView.addSubview(imagePicker.view)
            //presentViewController(imagePicker, animated: true, completion: { () -> Void in
            //    println("finished opening camera")
            // })
        } else {
            gallery()
        }
    }
    
    func gallery() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else {
            popover = UIPopoverController(contentViewController: imagePicker)
            popover.presentPopoverFromRect(CGRectMake(150, 497, 300, 59), inView: view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        println(tabBarController!.selectedIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tabBarController!.selectedIndex != 2 {
            sourcePopOver()
        }
        println(tabBarController!.selectedIndex)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //imageViewer.image = image
        dismissViewControllerAnimated(true, completion: { () -> Void in
            println("finished")
        })
        ////        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        // dismissViewControllerAnimated(true, completion: nil)
        //        println(UIImagePickerControllerOriginalImage)
        println(info[UIImagePickerControllerMediaURL]!.pathExtension)
        println("oioioioi")
        imageViewer.image = info[UIImagePickerControllerMediaURL] as? UIImage
        tabBarController!.selectedIndex = 0
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        println("cancel")
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}