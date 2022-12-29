import Ambassador
import Foundation

final class MockNetworkRoutes {

  // MARK: - Properties

  private static let getHelloWorldPath = "/hello_world.json"
  private static let getApiAuthPath = "/as/authorization.oauth2"
  private static let getVehiclesPath = "/core/api/v3/ie/en_IE/vehicles"
  private static let getSummaryPath = "/service-vehicle/vehicle-summary/A1234"
  private static let getPositionPath = "/service-vehicle/car-finder/A1234/position"
  private static let getCapabilitiesPath = "/service-vehicle/vcs/capabilities/A1234"
  private static let getEmobilityPath = "/e-mobility/ie/en_IE/J1/A1234"
  private static let getHonkAndFlashRemoteCommandStatusPath =
    "/service-vehicle/honk-and-flash/A1234/999/status"

  private static let postLoginAuthPath = "/auth/api/v1/ie/en_IE/public/login"
  private static let postApiTokenPath = "/as/token.oauth2"
  private static let postFlashPath = "/service-vehicle/honk-and-flash/A1234/flash"
  private static let postHonkAndFlashPath = "/service-vehicle/honk-and-flash/A1234/honk-and-flash"
  private static let postToggleDirectChargingOnPath = "/e-mobility/ie/en_IE/J1/A1234/toggle-direct-charging/true"
  private static let postToggleDirectChargingOffPath = "/e-mobility/ie/en_IE/J1/A1234/toggle-direct-charging/false"

  // MARK: - Hello World

  func mockGetHelloWorldSuccessful(router: Router) {
    router[MockNetworkRoutes.getHelloWorldPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockHelloWorldResponse()
    }
  }

  func mockGetHelloWorldFailure(router: Router) {
    router[MockNetworkRoutes.getHelloWorldPath] = JSONResponse(
      statusCode: 401, statusMessage: "unauthorized")
  }

  // MARK: - Post Login Auth

  func mockPostLoginAuthSuccessful(router: Router) {
    router[MockNetworkRoutes.postLoginAuthPath] = DataResponse(
      statusCode: 200, statusMessage: "ok", headers: [("Set-Cookie", "CIAM.status=mockValue")])
  }

  func mockPostLoginAuthFailure(router: Router) {
    router[MockNetworkRoutes.postLoginAuthPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: - Get Api Auth

  func mockGetApiAuthSuccessful(router: Router) {
    router[MockNetworkRoutes.getApiAuthPath] = DataResponse(
      statusCode: 200, statusMessage: "ok",
      headers: [
        ("cdn-original-uri", "/static/cms/auth.html?code=fqFQlQSUfNkMGtMLj0zRK0RriKdPySGVMmVXPAAC")
      ])
  }

  func mockGetApiAuthFailure(router: Router) {
    router[MockNetworkRoutes.getApiAuthPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: - Post Api Token

  func mockPostApiTokenSuccessful(router: Router) {
    router[MockNetworkRoutes.postApiTokenPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockApiTokenResponse()
    }
  }

  func mockPostApiTokenFailure(router: Router) {
    router[MockNetworkRoutes.postApiTokenPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: - Get Vehicles

  func mockGetVehiclesSuccessful(router: Router) {
    router[MockNetworkRoutes.getVehiclesPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockVehiclesResponse()
    }
  }

  func mockGetVehiclesFailure(router: Router) {
    router[MockNetworkRoutes.getVehiclesPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: - Get Summary

  func mockGetSummarySuccessful(router: Router) {
    router[MockNetworkRoutes.getSummaryPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockSummaryResponse()
    }
  }

  func mockGetSummaryFailure(router: Router) {
    router[MockNetworkRoutes.getSummaryPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: - Get Position

  func mockGetPositionSuccessful(router: Router) {
    router[MockNetworkRoutes.getPositionPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockPositionResponse()
    }
  }

  func mockGetPositionFailure(router: Router) {
    router[MockNetworkRoutes.getPositionPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: - Get Capabilities

  func mockGetCapabilitiesSuccessful(router: Router) {
    router[MockNetworkRoutes.getCapabilitiesPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockCapabilitiesResponse()
    }
  }

  func mockGetCapabilitiesFailure(router: Router) {
    router[MockNetworkRoutes.getCapabilitiesPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: - Get Emobility

  func mockGetEmobilityNotChargingSuccessful(router: Router) {
    router[MockNetworkRoutes.getEmobilityPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockEmobilityResponse(mockedResponse: kEmobilityNotChargingJson)
    }
  }

  func mockGetEmobilityACTimerChargingSuccessful(router: Router) {
    router[MockNetworkRoutes.getEmobilityPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockEmobilityResponse(mockedResponse: kEmobilityACTimerChargingJson)
    }
  }

  func mockGetEmobilityACDirectChargingSuccessful(router: Router) {
    router[MockNetworkRoutes.getEmobilityPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockEmobilityResponse(mockedResponse: kEmobilityACDirectChargingJson)
    }
  }

  func mockGetEmobilityDCChargingSuccessful(router: Router) {
    router[MockNetworkRoutes.getEmobilityPath] = JSONResponse(statusCode: 200) { (req) -> Any in
      return self.mockEmobilityResponse(mockedResponse: kEmobilityDCChargingJson)
    }
  }

  func mockGetEmobilityFailure(router: Router) {
    router[MockNetworkRoutes.getEmobilityPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: – Get Honk and Flash

  func mockPostFlashSuccessful(router: Router) {
    router[MockNetworkRoutes.postFlashPath] = JSONResponse(
      statusCode: 200,
      handler: { (req) -> Any in
        return self.mockRemoteCommandAcceptedVariantOne()
      })
  }

  func mockPostFlashFailure(router: Router) {
    router[MockNetworkRoutes.postFlashPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  func mockPostHonkAndFlashSuccessful(router: Router) {
    router[MockNetworkRoutes.postHonkAndFlashPath] = JSONResponse(
      statusCode: 200,
      handler: { (req) -> Any in
        return self.mockRemoteCommandAcceptedVariantOne()
      })
  }

  func mockPostHonkAndFlashFailure(router: Router) {
    router[MockNetworkRoutes.postHonkAndFlashPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: – Post Toggle Direct Charging

  func mockPostToggleDirectChargingOnSuccessful(router: Router) {
    router[MockNetworkRoutes.postToggleDirectChargingOnPath] = JSONResponse(
      statusCode: 200,
      handler: { (req) -> Any in
        return self.mockRemoteCommandAcceptedVariantTwo()
      })
  }

  func mockPostToggleDirectChargingOnFailure(router: Router) {
    router[MockNetworkRoutes.postToggleDirectChargingOnPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  func mockPostToggleDirectChargingOffSuccessful(router: Router) {
    router[MockNetworkRoutes.postToggleDirectChargingOffPath] = JSONResponse(
      statusCode: 200,
      handler: { (req) -> Any in
        return self.mockRemoteCommandAcceptedVariantTwo()
      })
  }

  func mockPostToggleDirectChargingOffFailure(router: Router) {
    router[MockNetworkRoutes.postToggleDirectChargingOffPath] = DataResponse(
      statusCode: 400, statusMessage: "bad request")
  }

  // MARK: – Remote Command Status

  func mockGetHonkAndFlashRemoteCommandStatusInProgress(router: Router) {
    router[MockNetworkRoutes.getHonkAndFlashRemoteCommandStatusPath] = JSONResponse(
      statusCode: 200,
      handler: { (req) -> Any in
        return self.mockRemoteCommandStatusInProgress()
      })
  }

  func mockGetHonkAndFlashRemoteCommandStatusSuccess(router: Router) {
    router[MockNetworkRoutes.getHonkAndFlashRemoteCommandStatusPath] = JSONResponse(
      statusCode: 200,
      handler: { (req) -> Any in
        return self.mockRemoteCommandStatusSuccess()
      })
  }

  // MARK: - Mock Responses

  private func mockHelloWorldResponse() -> [String: Any] {
    return ["message": "Hello World!"]
  }

  private func mockApiTokenResponse() -> [String: Any] {
    return [
      "access_token": "Kpjg2m1ZXd8GM0pvNIB3jogWd0o6",
      "id_token":
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IjE1bF9LeldTV08tQ1ZNdXdlTmQyMnMifQ.eyJzdWIiOiI4N3VnOGJobXZydnF5bTFrIiwiYXVkIjoiVFo0VmY1d25LZWlwSnh2YXRKNjBsUEhZRXpxWjRXTnAiLCJqdGkiOiJmTldhWEE4RTBXUzNmVzVZU0VmNFRDIiwiaXNzIjoiaHR0cHM6XC9cL2xvZ2luLnBvcnNjaGUuY29tIiwiaWF0IjoxNjEyNzQxNDA4LCJleHAiOjE2MTI3NDE3MDgsInBpLnNyaSI6InNoeTN3aDN4RFVWSFlwd0pPYmpQdHJ5Y2FpOCJ9.EsgxbnDCdEC0O8b05B_VJoe09etxcQOqhj4bRkR-AOwZrFV0Ba5LGkUFD_8GxksWuCn9W_bG_vHNOxpcum-avI7r2qY3N2iMJHZaOc0Y-NqBPCu5kUN3F5oh8e7aDbBKQI_ZWTxRdMvcTC8zKJRZf0Ud2YFQSk6caGwmqJ5OE_OB38_ovbAiVRgV_beHePWpEkdADKKtlF5bmSViHOoUOs8x6j21mCXDiuMPf62oRxU4yPN-AS4wICtz22dabFgdjIwOAFm651098z2zwEUEAPAGkcRKuvSHlZ8OAvi4IXSFPXBdCfcfXRk5KdCXxP1xaZW0ItbrQZORdI12hVFoUQ",
      "token_type": "Bearer",
      "expires_in": 7199,
    ]
  }

  private func mockVehiclesResponse() -> [[String: Any]] {
    return [
      [
        "vin": "VIN12345",
        "modelDescription": "Porsche Taycan 4S",
        "modelType": "A Test Model Type",
        "modelYear": "2021",
        "exteriorColorHex": "#47402e",
        "attributes": [["name": "licenseplate", "value": "Porsche Taycan"]],
      ]
    ]
  }

  private func mockSummaryResponse() -> [String: Any] {
    return [
      "modelDescription": "Taycan 4S",
      "nickName": "211-D-12345",
    ]
  }

  private func mockPositionResponse() -> [String: Any] {
    return [
      "carCoordinate":
        [
          "geoCoordinateSystem": "WGS84",
          "latitude": 53.395367,
          "longitude": -6.389296,
        ],
      "heading": 68,
    ]
  }

  private func mockCapabilitiesResponse() -> [String: Any] {
    return [
      "displayParkingBrake": true,
      "needsSPIN": true,
      "hasRDK": true,
      "engineType": "BEV",
      "carModel": "J1",
      "onlineRemoteUpdateStatus": [
        "editableByUser": true,
        "active": true,
      ],
      "heatingCapabilities": [
        "frontSeatHeatingAvailable": true,
        "rearSeatHeatingAvailable": false,
      ],
      "steeringWheelPosition": "RIGHT",
      "hasHonkAndFlash": true,
    ]
  }

  private func mockEmobilityResponse(mockedResponse: Data) -> [String: Any] {
    return try! (JSONSerialization.jsonObject(with: mockedResponse, options: []) as! [String: Any])
  }

  private func mockRemoteCommandAcceptedVariantOne() -> [String: Any] {
    return ["id": "123456789", "lastUpdated": "2022-12-27T13:19:23Z"]
  }

  private func mockRemoteCommandAcceptedVariantTwo() -> [String: Any] {
    return ["requestId": "123456789"]
  }

  private func mockRemoteCommandStatusInProgress() -> [String: Any] {
    return ["status": "IN_PROGRESS"]
  }

  private func mockRemoteCommandStatusSuccess() -> [String: Any] {
    return ["status": "SUCCESS"]
  }
}