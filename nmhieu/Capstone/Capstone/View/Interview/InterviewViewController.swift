//
//  InterviewViewController.swift
//  Capstone  
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import UIKit
import Photos

enum InterviewSection : Int,Comparable,CaseIterable {
    case candidateInfor = 0
    case questions = 1
    case overview = 2
    
    static func < (lhs: InterviewSection, rhs: InterviewSection) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    var title : String {
        switch self {
        case .candidateInfor:
            return "Candidate Information"
        case .questions :
            return "Questions"
        case .overview :
            return "Overview"
        }
    }
    
    var row : Int {
        switch self {
        case .candidateInfor:
            return 1
        case .questions :
            return 5
        case .overview :
            return 1
        }
    }
}


class InterviewViewController: BaseVC {

    @IBOutlet weak var interViewTableView: UITableView!
    
    var interviewVM = DefaultInterviewViewModel()
    
    var level : LevelInterView?
    
    var questionsFirebase : [QuestionInterviewModel]? {
        didSet {
            self.setUpUI()
        }
    }
    
    var editingOverview : Bool? {
        didSet {
            self.event()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bindingData()
        self.configData()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.interViewTableView.register(UINib(nibName: CandidateInforTableViewCell.name, bundle: nil), forCellReuseIdentifier: CandidateInforTableViewCell.identifier)
        self.interViewTableView.register(UINib(nibName: QuestionTableViewCell.name, bundle: nil), forCellReuseIdentifier: QuestionTableViewCell.identifier)
        self.interViewTableView.register(UINib(nibName: OverviewTableViewCell.name, bundle: nil), forCellReuseIdentifier: OverviewTableViewCell.identifier)
        self.interViewTableView.dataSource = self
        self.interViewTableView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -Event
    private func event() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.eventKeyboardShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.eventKeyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func eventDone() {
        self.interviewVM.saveInterView(tableView: self.interViewTableView) { error in
            print(error)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func eventKeyboardShow(notification : Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.editingOverview ?? false  {
                self.interViewTableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom:  keyboardSize.height, right: 0.0)
                self.interViewTableView.scrollToRow(at: IndexPath(row: 0, section: InterviewSection.overview.rawValue), at: .middle, animated: true)
            }
        }
    }
    
    @objc func eventKeyboardHide(notification : Notification ){
        if self.editingOverview ?? false {
            self.interViewTableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom:  0.0, right: 0.0)
            self.editingOverview = false
        }
    }
    
    fileprivate func eventPresentCamreraPicker(state : Bool) {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK: -BindingData
    fileprivate func bindingData() {
        self.interviewVM.level = self.level ?? .intern
    }
    
    //MARK: -ConfigData
    private func configData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var errorFirebase : Error?
        self.interviewVM.recommentListQuestions { questions, error in
            self.questionsFirebase = questions
            errorFirebase = error
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if errorFirebase == nil {
                self.interviewVM.questions = self.questionsFirebase ?? []
                self.interViewTableView.reloadData()
            }
        }
//        self.interviewVM.questions = self.interviewVM.recommentListQuestions()
    }
}

//MARK: -UITableViewDataSource
extension InterviewViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return InterviewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case InterviewSection.candidateInfor.rawValue:
            return InterviewSection.candidateInfor.row
        case InterviewSection.questions.rawValue:
            return InterviewSection.questions.row
        case InterviewSection.overview.rawValue:
            return InterviewSection.overview.row
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case InterviewSection.candidateInfor.rawValue: 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CandidateInforTableViewCell.identifier) as? CandidateInforTableViewCell else { return UITableViewCell() }
            cell.bindingData(level: self.interviewVM.level, image: self.interviewVM.image ?? UIImage())
            cell.selectCandidateImage = { self.eventPresentCamreraPicker(state:$0) }
            return cell
            
        case InterviewSection.questions.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier) as? QuestionTableViewCell else { return UITableViewCell() }
            cell.bindingData(question: self.interviewVM.questions[indexPath.row].question ?? "")
            return cell
            
        case InterviewSection.overview.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            cell.editingOverviewTextview = {
                self.editingOverview = $0
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case InterviewSection.candidateInfor.rawValue:
            return InterviewSection.candidateInfor.title
        case InterviewSection.questions.rawValue:
            return InterviewSection.questions.title
        case InterviewSection.overview.rawValue:
            return InterviewSection.overview.title
        default:
            return .none
        }
    }
    
}
//MARK: -UITableViewDelegate
extension InterviewViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case InterviewSection.candidateInfor.rawValue:
            return CandidateInforTableViewCell.height
        case InterviewSection.questions.rawValue:
            return QuestionTableViewCell.height
        case InterviewSection.overview.rawValue:
            return OverviewTableViewCell.height
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == InterviewSection.questions.rawValue {
            self.eventAlert(message: self.interviewVM.questions[indexPath.row].answer ?? "")
        }
    }
}

//MARK: -UIImagePickerDelegate
extension InterviewViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        self.interviewVM.image = image
        self.interViewTableView.reloadData()
    }
}
