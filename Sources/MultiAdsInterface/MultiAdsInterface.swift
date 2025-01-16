

public class MultiAdsInterface {
    
    
    
    
    @MainActor public func registerDevice(rewardType: Int = 1) {
        ApiReposiotry().deviceRegister(rewardType: rewardType)
    }
    
}

