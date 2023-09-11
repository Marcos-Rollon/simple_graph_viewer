# simple_graph_viewer

I took the graphs easing form this article, that is very very interesting and good.

https://www.febucci.com/2018/08/easing-functions/

SOCKET IO CONSIDERATIONS


Connect_error on MacOS with SocketException: Connection failed 

Refer to https://github.com/flutter/flutter/issues/47606#issuecomment-568522318 issue.
By adding the following key into the to file *.entitlements under directory macos/Runner/

<key>com.apple.security.network.client</key>
<true/>

Memory leak issues in iOS when closing socket. 
Refer to https://github.com/rikulo/socket.io-client-dart/issues/108 issue. Please use socket.dispose() instead of socket.close() or socket.disconnect() to solve the memory leak issue on iOS.

Cannot connect "https" server or self-signed certificate server 
Refer to https://github.com/dart-lang/sdk/issues/34284 issue. The workround is to use the following code provided by @lehno on #84
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}