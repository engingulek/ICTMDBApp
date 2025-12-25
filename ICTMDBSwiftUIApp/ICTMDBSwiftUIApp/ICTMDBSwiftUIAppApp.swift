//
//  ICTMDBSwiftUIAppApp.swift
//  ICTMDBSwiftUIApp
//
//  Created by Engin Gülek on 25.12.2025.
//

import SwiftUI
import ICTMDBNavigationManagerSwiftUI
import ICTMDBModularProtocols
import DependencyKit
import ICTMDBHomeModule
import ICTMDBAllListModule
import ICTMDBDetailModule
internal import Swinject
@main
struct ICTMDBSwiftUIAppApp: App {
    @StateObject private var navigation = Navigation()
    init() {
        let container = DependencyRegister.shared.container
        container.register(HomeModuleProtocol.self) { resolver in
            ICTMDBHomeModule()
        }.inObjectScope(.container)
        
        container.register(AllListModuleProtocol.self) { resolver in
            ICTMDBAllListModule()
        }.inObjectScope(.graph)
        
        container.register(TvShowDetailProtocol.self) { resolver in
            ICTMDBDetailModule()
        }.inObjectScope(.graph)
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.path) {
                navigation.build(page: .home)
                    .navigationDestination(for: Page.self) { page in
                        navigation.build(page: page)
                    }
            }.environmentObject(navigation)
        }
    }
}




