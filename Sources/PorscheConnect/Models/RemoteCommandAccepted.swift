import Foundation

public struct RemoteCommandAccepted: Codable {

  public enum RemoteCommand: Codable {
    case honkAndFlash, toggleDirectCharge, lock, unlock
  }

  // MARK: Properties

  public var id: String? = nil
  public var requestId: String? = nil
  public var vin: String? = nil
  public var lastUpdated: Date? = nil
  public var remoteCommand: RemoteCommand?

  // MARK: Computed Properties

  // Porsche Connect remote command endpoints can return either an "id" or a "requestId"
  public var identifier: String? {
    return id ?? requestId
  }
}
