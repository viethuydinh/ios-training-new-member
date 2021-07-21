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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.bindingData()
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
    @IBAction func eventDone() {
        self.interviewVM.saveInterView(tableView: self.interViewTableView)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventBack() {
        self.navigationController?.popViewController(animated: true)
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
            cell.bindingData(question: self.interviewVM.recommentListQuestions()[indexPath.row].question ?? "")
            return cell
            
        case InterviewSection.overview.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
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
            return ""
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
