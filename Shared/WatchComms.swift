import WatchConnectivity
import WidgetKit

final class WatchComms: NSObject, ObservableObject {
    var session: WCSession
    var callbacks: [String: () -> [String: Any]] = Dictionary<String, () -> [String: Any]>()

    init(session: WCSession  = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
}

extension WatchComms: WCSessionDelegate {
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session became inactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("Session became active")
    }
    #else
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        DispatchQueue.main.async {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    #endif

    func setMessageHandler(type: String, callback: @escaping () -> [String: Any]) {
        self.callbacks[type] = callback
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Message received (no reply handler): \(message)")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let action = message["action"] as? String
        if action == nil {
            replyHandler(["error": "No action specified"])
        }else{
            print(action!)
            let callback = self.callbacks[action!]
            if callback != nil {
                replyHandler(["result": "success", "data": callback!()])
            }else{
                print("Not found callback")
                print(self.callbacks)
            }
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}

}
