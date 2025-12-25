//
//  Navigation+Extension.swift
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

extension Navigation {
    /// Build the appropriate view for a given page.
    @ViewBuilder
    public  func build(page:Page) -> some View {
        switch page {
        case .home:
            /// Dependency resolution and view creation for the home page
            HomeModuleProvider.shared.module.createHomeModule()
        case .allList(let allListType):
            /// Dependency resolution and view creation for the all list page
            let allListModule : AllListModuleProtocol = DependencyRegister.shared.resolve(AllListModuleProtocol.self)
            allListModule.createAllListModule(type: allListType)
        case .detail(let id):
            /// Dependency resolution and view creation for the detail page
            let detailModule : TvShowDetailProtocol = DependencyRegister.shared.resolve(TvShowDetailProtocol.self)
            detailModule.createTvShowDetailModule(id: id)
        }
    }
}
private struct HomeModuleProvider {
    static let shared = HomeModuleProvider()
    let module: HomeModuleProtocol = {
        return DependencyRegister.shared.resolve(HomeModuleProtocol.self)
    }()
}
