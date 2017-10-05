import Foundation

public final class MarshrouteSetupServiceImpl: MarshrouteSetupService {
    // MARK: - Private properties
    fileprivate let factory: MarshrouteFactory
    private lazy var lazyMarshrouteStack = { self.makeMarshrouteStack() }()
    
    // MARK: - Init
    public init(factory: MarshrouteFactory = MarshrouteFactoryImpl()) {
        self.factory = factory
    }
    
    // MARK: - MarshrouteSetupService
    public func marshrouteStack()
        -> MarshrouteStack
    {
        return lazyMarshrouteStack
    }
    
    // MARK: - Private
    private func makeMarshrouteStack()
        -> MarshrouteStack
    {
        let transitionIdGenerator = factory.transitionIdGenerator()
        
        let routerControllersProvider = factory.routerControllersProvider()
        
        let stackClientProvider = factory.transitionContextsStackClientProvider()
        
        let peekAndPopUtility = PeekAndPopUtilityImpl()
        
        let transitionsCoordinator = TransitionsCoordinatorImpl(
            stackClientProvider: stackClientProvider, 
            peekAndPopTransitionsCoordinator: peekAndPopUtility
        )
        
        return MarshrouteStack(
            transitionIdGenerator: transitionIdGenerator,
            routerControllersProvider: routerControllersProvider,
            transitionsCoordinator: transitionsCoordinator,
            transitionsCoordinatorDelegateHolder: transitionsCoordinator,
            topViewControllerFinder: transitionsCoordinator,
            transitionsMarker: transitionsCoordinator,
            transitionsTracker: transitionsCoordinator,
            transitionsHandlersProvider: transitionsCoordinator,
            peekAndPopUtility: peekAndPopUtility, 
            peekAndPopStateObservable: peekAndPopUtility,
            peekAndPopStateViewControllerObservable: peekAndPopUtility
        )
    }
}
