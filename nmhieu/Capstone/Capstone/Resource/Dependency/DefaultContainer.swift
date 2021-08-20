//
//  DefaultContainer.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 10/08/2021.
//

import Foundation
import Swinject

protocol NameRegisterContainer {
    static var NAME_REGISTER: String { get }
}

extension NameRegisterContainer {
    static var NAME_REGISTER: String { String(describing: self) }
}

struct DefaultContainer {
    let container: Container = .init()
    
    static let shared = DefaultContainer()
    
    func register() {
        self.registerViewModel()
        self.registerRepository()
    }
    
    fileprivate func registerRepository() {
        self.container.register(AuthenticationRepository.self) { _ in DefaultAuthenticationRepository()}
        self.container.register(KnowledgeRepository.self) { _ in DefaultKnowledgeRepository()}
        self.container.register(InterviewRepository.self) { _ in DefaultInterviewRepository()}
    }

    func registerViewModel() {
        self.container.register(AuthenticationViewModel.self) { _ in DefaultAuthenticationViewModel()}
        self.container.register(KnowledgeViewModel.self) { _ in DefaultKnowledgeViewModel()}
        self.container.register(InterviewViewModel.self) { _ in DefaultInterviewViewModel()}
        self.container.register(OnboardingViewModel.self) { _ in DefaultOnboardingViewModel()}
    }
    
}

