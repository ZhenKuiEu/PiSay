//
//  PagingMenuControllerOptions.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 6/9/16.
//  Copyright © 2016 kitasuke. All rights reserved.
//

import Foundation
import PagingMenuController

private var pagingControllers: [UIViewController] {
    let activitiesViewController = ActivitiesViewController.instantiateFromStoryboard()
    let collectionsViewController = CollectionsViewController.instantiateFromStoryboard()
    return [activitiesViewController, collectionsViewController]
}

struct MenuItemActivities: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        return .text(title: MenuItemText(text: "My Activity List"))
    }
}

struct MenuItemCollections: MenuItemViewCustomizable {
    var displayMode: MenuItemDisplayMode {
        return .text(title: MenuItemText(text: "My Collection List"))
    }
}

struct PagingMenuOptions1: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .standard(widthMode: .flexible, centerItem: false, scrollingMode: .pagingEnabled)
        }
        var focusMode: MenuFocusMode {
            return .none
        }
        var height: CGFloat {
            return 60
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemActivities(), MenuItemCollections()]
        }
    }
    
}

struct PagingMenuOptions2: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    var menuControllerSet: MenuControllerSet {
        return .single
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemActivities(), MenuItemCollections()]
        }
    }
}

struct PagingMenuOptions3: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    var lazyLoadingPage: LazyLoadingPage {
        return .three
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .fixed(width: 80), scrollingMode: .scrollEnabled)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemActivities(), MenuItemCollections()]
        }
    }
}

struct PagingMenuOptions4: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .menuView(menuOptions: MenuOptions())
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var focusMode: MenuFocusMode {
            return .underline(height: 3, color: UIColor.blue, horizontalPadding: 10, verticalPadding: 0)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemActivities(), MenuItemCollections()]
        }
    }
}

struct PagingMenuOptions5: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .menuView(menuOptions: MenuOptions())
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .flexible, scrollingMode: .pagingEnabled)
        }
        var focusMode: MenuFocusMode {
            return .roundRect(radius: 12, horizontalPadding: 8, verticalPadding: 8, selectedColor: UIColor.lightGray)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemActivities(), MenuItemCollections()]
        }
    }
}

struct PagingMenuOptions6: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .pagingController(pagingControllers: pagingControllers)
    }
    var defaultPage: Int {
        return 1
    }
}

