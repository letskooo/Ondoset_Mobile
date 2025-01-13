# Ondoset_iOS
팀 Easy Ondoset 프로젝트 iOS 리포지토리입니다.

가천대학교 2024년도 1학기 종합 프로젝트 수업에 진행한 팀 프로젝트입니다.

## 프로젝트 소개
날씨 정보를 기반으로 AI를 활용한 착장 추천, 코디 기록, 패션 SNS 등의 서비스를 제공하는 앱 프로젝트

## 📆 개발 기간
- 개발 기간(기획 포함): 2024.02 ~ 2024.06

## ⚡ 담당 개발 기능
❗commit에서 'letskooo'와 'KoSungmin'이 본인입니다.
- 프로젝트 초기 셋팅 및 아키텍처 설계
- 사용자 인증 기능 구현
- API 및 DTO와 같은 네트워크 관련 코드 구현
- 모든 도메인의 UseCase, Repository 구현
- 현재 위치 및 지역 위치 정보 검색 기능
- OOTD 화면 및 기능 개발
- 로그인 및 회원가입 화면 및 기능
- 온보딩 화면 및 기능 개발
- 코디 화면 및 기능
- 마이페이지 화면 및 기능
- 재활용을 위한 뷰 컴포넌트 구현

## 📱 주요 개발 화면
![주요 개발 화면](https://github.com/letskooo/Ondoset_Mobile/blob/develop/image%2053.png)


## 📁 디렉토리 구조

```plaintext
Ondoset
├── Info
├── OndosetApp
├── Common
│   ├── Utils
│   └── Extensions
├── Data
│   ├── Local
│   ├── API
│   │   ├── Base
│   │   └── EndPoint
│   ├── Repository
│   └── DTO
├── Domain
│   ├── Model
│   │   ├── Weather
│   │   ├── Clothes
│   │   ├── Coordi
│   │   └── OOTD
│   └── UseCase
├── Presentation
│   ├── Components
│   ├── Initial
│   ├── Onboarding
│   ├── Home
│   ├── Coordi
│   ├── Closet
│   ├── OOTD
│   └── MyPage
└── Assets
