import UIKit

/// Роутер, управляющий двумя экранами (двумя UINavigationController'ами)
/// Работает с двумя обработчиками переходов (master и detail).
/// Например, роутер master-контроллера внутри SplitViewController'а
public class BaseMasterDetailRouter:
    TransitionsCoordinatorHolder,
    TransitionIdGeneratorHolder,
    RouterIdentifiable,
    RouterPresentable,
    RouterTransitionable,
    Router,
    RouterFocusable,
    RouterDismisable,
    MasterRouterTransitionable,
    MasterRouter,
    DetailRouterTransitionable,
    DetailRouter
{
    public let masterTransitionsHandlerBox: RouterTransitionsHandlerBox?
    public let detailTransitionsHandlerBox: RouterTransitionsHandlerBox?
    public let transitionId: TransitionId
    public private (set) weak var presentingTransitionsHandler: TransitionsHandler?
    public let transitionsCoordinator: TransitionsCoordinator
    public let transitionIdGenerator: TransitionIdGenerator
    
    public init(routerSeed seed: BaseMasterDetailRouterSeed)
    {
        self.transitionId = seed.transitionId
        self.masterTransitionsHandlerBox = seed.masterTransitionsHandlerBox
        self.detailTransitionsHandlerBox = seed.detailTransitionsHandlerBox
        self.presentingTransitionsHandler = seed.presentingTransitionsHandler
        self.transitionsCoordinator = seed.transitionsCoordinator
        self.transitionIdGenerator = seed.transitionIdGenerator
    }
    
    // MARK: - RouterTransitionable
    public var transitionsHandlerBox: RouterTransitionsHandlerBox? {
        return masterTransitionsHandlerBox
    }
}