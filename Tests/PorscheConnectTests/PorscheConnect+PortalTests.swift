import XCTest
@testable import PorscheConnect

final class PorscheConnectPortalTests: BaseMockNetworkTestCase {
  
  // MARK: - Properties
  
  var connect: PorscheConnect!
  let mockNetworkRoutes = MockNetworkRoutes()
  let porscheAuth = PorscheAuth(accessToken: "zVb3smCN32iOslsoXa7XIYPrenGz",
                                idToken: "yJhbGciOiJSUzI1NiIsImtpZCI6IjE1bF9LeldTV08tQ1ZNdXdlTmQyMnMifQ.eyJzdWIiOiI4N3VnOGJobXZydnF5bTFrIiwiYXVkIjoiVFo0VmY1d25LZWlwSnh2YXRKNjBsUEhZRXpxWjRXTnAiLCJqdGkiOiI5NWhPT0ZlSDdzZW9yaVZ2bUNhTWdWIiwiaXNzIjoiaHR0cHM6XC9cL2xvZ2luLnBvcnNjaGUuY29tIiwiaWF0IjoxNjEyNzQwOTE2LCJleHAiOjE2MTI3NDEyMTYsInBpLnNyaSI6IkVYYjZSSlFpRWZLazNRZWk0Y1dyTWlwSmgxSSJ9.bVzapayesKjA85pRwVBZN_TfKzPNFTOb6nszPSWElMU2-MOzmJjy6dWHTjN3jCCx3Ui20XDwHkkDOdIUZqIQq6nve5ihbRlNi1ywrNiKKLOL7nmfzmM7yBPMZfwxtCP_-imypF_n19i1rZDkatIkW0Ejs7lcc0xRD9JewGMhfALqpFuOciIX3SIInHE56WSmTNyEB1LTNNLXiwaBWygPVbYDAYYc4u-w3V_GPZR3kTSTJjwnfXM9Qke6wBcoXDaON4_NfNcTQf0vXYwhC749dJd8Z2eDcRTl-Yl06BTHHTIL-yInfk8yjCO1iaCv01ROjK_nGAyPsOvUKtVgsaXxnw",
                                tokenType: "Bearer",
                                expiresIn: 7199)
  
  // MARK: - Lifecycle
  
  override func setUp() {
    super.setUp()
    self.connect = PorscheConnect(environment: .Test, username: "homer.simpson@icloud.example", password: "Duh!")
    self.connect.auth = porscheAuth
  }
  
  // MARK: - Tests

  func testVehiclesNoAuthRequiredSuccessful() {
    let expectation = self.expectation(description: "Network Expectation")
    mockNetworkRoutes.mockGetVehiclesSuccessful(router: BaseMockNetworkTestCase.router)
        
    XCTAssert(self.connect.authorized)
    
    self.connect.vehicles(success: { (vehicles, response, responseJson) in
      expectation.fulfill()
      
    })
    
    waitForExpectations(timeout: kDefaultTestTimeout, handler: nil)
  }
}
