        let viewModel = Drawing.AddSquareEvent.ViewModel(rect: response.rect, color: response.color)
        viewController?.disPlayNewSquareView(viewModel: viewModel)
        let viewModel = Drawing.DrawEvent.ViewModel(rect: response.rect, color: response.color)
        viewController?.disPlayNewDrawView(viewModel: viewModel)
