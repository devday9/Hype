//
//  SignUPViewController.swift
//  ClassHypeGL
//
//  Created by Deven Day on 10/7/20.
//

import UIKit

class SignUPViewController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var faqButton: UIButton!
    @IBOutlet weak var createUserButton: UIButton!
    
    //MARK: - Properties
    var image: UIImage?
    var viewsLaidOut = false
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if viewsLaidOut == false {
            setupViews()
            viewsLaidOut = true
        }
    }
    
    //MARK: - Actions
    @IBAction func createUserButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let bio = bioTextField.text else {return}
        
        UserController.shared.createUser(username: username, bio: bio, profilePhoto: image) { (result) in
            switch result {
            case .success(_):
                self.presentHypeListVC()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    @IBAction func logInButtonTapped(_ sender: Any) {
        toggleToLogIn()
        
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        toggleToSignUp()
    }
    
    //MARK: - Helper Functions
    func fetchUser() {
        UserController.shared.fetchUser { (result) in
            switch result {
            case .success(_):
                self.presentHypeListVC()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func setupViews() {
        containerView.clipsToBounds = true
        containerView.addCornerRadius(radius: containerView.frame.height / 2)
        self.view.backgroundColor = .spaceGray
        loginButton.rotate()
        signUpButton.rotate()
        signUpButton.tintColor = .mainText
        loginButton.tintColor = .subtleText
        helpButton.setTitleColor(.mainText, for: .normal)
        faqButton.setTitleColor(.greenAccent, for: .normal)
    }
    
    func toggleToLogIn() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.confirmPasswordTextField.isHidden = true
                self.containerView.isHidden = true
                self.bioTextField.isHidden = true
                self.loginButton.tintColor = .mainText
                self.signUpButton.tintColor = .subtleText
                self.faqButton.setTitle("Hint", for: .normal)
                self.helpButton.setTitle("Forgot?", for: .normal)
                self.createUserButton.setTitle("Log Me In!", for: .normal)
                self.usernameTextField.text = UserController.shared.currentUser?.username
            }
        }
    }
    
    func toggleToSignUp() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.confirmPasswordTextField.isHidden = false
                self.containerView.isHidden = false
                self.bioTextField.isHidden = false
                self.loginButton.tintColor = .subtleText
                self.signUpButton.tintColor = .mainText
                self.createUserButton.setTitle("Sign Me Up!", for: .normal)
                self.helpButton.setTitle("Help?", for: .normal)
                self.faqButton.setTitle("FAQ", for: .normal)
                self.usernameTextField.text = ""
            }
        }
    }
    
    func presentHypeListVC() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "HypeList", bundle: nil)
            guard let viewController = storyboard.instantiateInitialViewController() else {return}
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoPickerVC" {
            let destinationVC = segue.destination as? PhotoPickerViewController
            destinationVC?.delegate = self
        }
    }
}//END OF CLASS

//MARK: - Extensions
extension SignUPViewController: PhotoSelectorDelegate {
    func photoPickerSelected(image: UIImage) {
        self.image = image
    }
}//END OF EXTENSION
