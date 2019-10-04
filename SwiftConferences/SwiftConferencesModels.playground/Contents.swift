import Foundation
import SwiftUI
import Combine


class HomeViewModel: ObservableObject {
    private var mode: HomeViewModel.Mode = .all
    @Published var homeViewModelDTO: HomeViewModelDTO
    
    init() {
        homeViewModelDTO = HomeViewModelDTO(navigationViewModel: NavigationViewModel(mode: mode),
                                            navigationBarViewModel: navigationBarViewModel,
                                            listViewModel: listViewModel)
    }
    
    func getNavigationViewModel() -> NavigationViewModel {
        return NavigationViewModel(mode: mode)
    }
    var navigationBarViewModel = NavigationBarViewModel()
    var listViewModel = ListViewModel()
}

class NavigationViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var mode: HomeViewModel.Mode
    
    init(mode: HomeViewModel.Mode) {
        self.mode = mode
    }
}

class NavigationBarViewModel {
    
}

class ListViewModel {
    
}

extension HomeViewModel {
    class HomeViewModelDTO: ObservableObject {
        @Published var navigationViewModel: NavigationViewModel
        @Published var navigationBarViewModel: NavigationBarViewModel
        @Published var listViewModel: ListViewModel
        
        init(navigationViewModel: NavigationViewModel,
             navigationBarViewModel: NavigationBarViewModel,
             listViewModel: ListViewModel) {
            self.navigationViewModel = navigationViewModel
            self.navigationBarViewModel = navigationBarViewModel
            self.listViewModel = listViewModel
        }
    }
    
    enum Mode {
        case favourite
        case all
    }
}

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel.HomeViewModelDTO

    init(viewModel: HomeViewModel.HomeViewModelDTO) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello world")
            }
            .navigationBarTitle("\(viewModel.navigationViewModel.title)",
            displayMode: .large)
        }
    }
}
