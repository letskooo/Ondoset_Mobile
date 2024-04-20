//
//  OnboardingViewModel.swift
//  Ondoset
//
//  Created by KoSungmin on 4/7/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    let memberUseCase: MemberUseCase = MemberUseCase.shared
    
    // 온보딩 결과 저장
    func saveOnboarding(age: Int, sex: Int, height: Int, weight: Int, activity: Int, goingOut: Int) async {
        
        _ = await memberUseCase.saveOnboarding(onboardingDTO: OnboardingRequestDTO(answer: [age, sex, height, weight, activity, goingOut]))
    }
}
