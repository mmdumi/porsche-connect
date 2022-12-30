import XCTest

@testable import PorscheConnect

final class PorscheConnectRemoteCommandStatuslTests: BaseMockNetworkTestCase {

  // MARK: - Properties

  var connect: PorscheConnect!
  let mockNetworkRoutes = MockNetworkRoutes()
  let application: OAuthApplication = .carControl
  let vehicle = Vehicle(vin: "A1234")
  let remoteCommand = RemoteCommandAccepted(
    id: "999", lastUpdated: Date(), remoteCommand: .honkAndFlash)

  // MARK: - Lifecycle

  override func setUp() {
    super.setUp()
    connect = PorscheConnect(
      username: "homer.simpson@icloud.example", password: "Duh!", environment: .test)
    connect.auths[application] = OAuthToken(authResponse: kTestPorschePortalAuth)
  }

  // MARK: - Tests

  func testRemoteCommandHonkAndFlashStatusInProgressAuthRequiredSuccessful() async {
    connect.auths[application] = nil
    let expectation = expectation(description: "Network Expectation")

    mockNetworkRoutes.mockPostLoginAuthSuccessful()
    mockNetworkRoutes.mockGetApiAuthSuccessful()
    mockNetworkRoutes.mockPostApiTokenSuccessful()
    mockNetworkRoutes.mockGetHonkAndFlashRemoteCommandStatusInProgress()

    XCTAssertFalse(connect.authorized(application: application))

    let result = try! await connect.checkStatus(vehicle: vehicle, remoteCommand: remoteCommand)

    expectation.fulfill()
    XCTAssertNotNil(result)
    XCTAssertEqual("IN_PROGRESS", result.status!.status)
    XCTAssertEqual(RemoteCommandStatus.RemoteStatus.inProgress, result.status!.remoteStatus)

    await waitForExpectations(timeout: kDefaultTestTimeout, handler: nil)
  }

  func testRemoteCommandHonkAndFlashStatusSuccessAuthRequiredSuccessful() async {
    connect.auths[application] = nil
    let expectation = expectation(description: "Network Expectation")

    mockNetworkRoutes.mockPostLoginAuthSuccessful()
    mockNetworkRoutes.mockGetApiAuthSuccessful()
    mockNetworkRoutes.mockPostApiTokenSuccessful()
    mockNetworkRoutes.mockGetHonkAndFlashRemoteCommandStatusSuccess()

    XCTAssertFalse(connect.authorized(application: application))

    let result = try! await connect.checkStatus(vehicle: vehicle, remoteCommand: remoteCommand)

    expectation.fulfill()
    XCTAssertNotNil(result)
    XCTAssertEqual("SUCCESS", result.status!.status)
    XCTAssertEqual(RemoteCommandStatus.RemoteStatus.success, result.status!.remoteStatus)

    await waitForExpectations(timeout: kDefaultTestTimeout, handler: nil)
  }
}
