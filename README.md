# EcoSteps

# - Introduction

언제 어디서나 AITrainer와 함께 올바른 운동을 수행하세요.

 *주요 기능 안내*

- 계단 오르기 데이터를 활용해 소모 칼로리, CO2 배출 감소량을 계산하여 알려줍니다.

- 주간 & 월간 데이터를 쉽게 확인할 수 있습니다.

- CO2 배출 감소를 통해 본인만의 나무를 만들 수 있습니다.

- 목표를 언제든지 변경하여 도전할 수 있습니다.

*필수 권한*

위 앱에서는 건강 앱의 계단 오르기 데이터에 접근하고자 합니다. 앱을 시작하면 계단 오르기 데이터에 대한 접근 권한을 허용해주세요. 이 설정은 언제든지 바꿀 수 있습니다.

# - Video & Images
<img width="990" alt="%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202023-02-28%20%EC%98%A4%ED%9B%84%201 24 51" src="https://user-images.githubusercontent.com/88021794/229042279-52d7e877-8e93-488b-9b4c-e17e1e10d518.png">

# -핵심 코드
    HealthKitManager
    //하루 기준 계단 오르기 수행 횟수 측정
    func readStepCountperform(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
    
    //하루를 나타낼 수 있도록 시간 기준 설정
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date())
        let endDate = Date()
        
    //설정한 시간 기준을 바탕으로 predicate 설정, 이는 아래 query에서 사용
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
       
    //query 정의, 계단 오르기 데이터를 불러오며 위에서 설정한 predicate를 바탕으로 시간 설정
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            guard error == nil, let samples = results as? [HKQuantitySample] else {
                completion(0.0)
                return
            }
    //계단 오르기 수행 횟수 정의       
            var totalFlightsClimbed = 0.0

    //계단 오르기 데이터가 업데이트 될 때마다 count를 늘려줌. 사용자가 만약 apple watch와 iPhone을 동시에 사용 시 중복을 막기위해 watch 데이터는 포함하지 않음.
            for sample in samples {
                if !sample.description.contains("Watch"){
                    totalFlightsClimbed += 1
                }
            }
            completion(totalFlightsClimbed)
        }
        
        healthStore.execute(query)
    }
    
    //월간 계단 오르기 횟수
    //월간 기준 계단 오르기 수행 횟수 측정
    func monthreadStepCountperform(forToday: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
    //한 달의 기간을 나타낼 수 있도록 시간 기준 설정
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: now)))!
        let endDate = Date()
        
    //설정한 시간 기준을 바탕으로 predicate 설정, 이는 아래 query에서 사용
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        
    //query 정의, 계단 오르기 데이터를 불러오며 위에서 설정한 predicate를 바탕으로 시간 설정
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            guard error == nil, let samples = results as? [HKQuantitySample] else {
                completion(0.0)
                return
            }
            
    //월간 계단 오르기 수행 횟수 정의
            var monthtotalFlightsClimbed = 0.0

    //계단 오르기 데이터가 업데이트 될 때마다 count를 늘려줌. 사용자가 만약 apple watch와 iPhone을 동시에 사용 시 중복을 막기위해 watch 데이터는 포함하지 않음.
            for sample in samples {
                if !sample.description.contains("Watch"){
                    monthtotalFlightsClimbed += 1
                }
            }
            completion(monthtotalFlightsClimbed)
        }
        
        healthStore.execute(query)
    }


# - Appstore link

https://apps.apple.com/kr/app/ecosteps/id6445834763

# - Contact 

📧 : abw2619@naver.com
