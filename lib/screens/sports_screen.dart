import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> with SingleTickerProviderStateMixin {
  late Key _key;
  late WebViewController _webViewController;
  bool _isConnected = true;
  bool _isLoading = true;
  bool _isLoadingPage = false;
  static const String baseUrl = 'https://goeasternathletics.com/index.aspx';

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _key = UniqueKey();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
      _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet connection.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    String currentUrl = await _webViewController.currentUrl() ?? '';
    if (await _webViewController.canGoBack() && currentUrl != baseUrl) {
      _webViewController.goBack();
      return Future.value(false);
    } else if (currentUrl == baseUrl) {
      _webViewController.reload();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ENMU Athletics'),
          actions: [
            IconButton(
              icon: _isLoadingPage
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              )
                  : const Icon(Icons.refresh),
              onPressed: _isLoadingPage ? null : () {
                if (_webViewController != null) {
                  _webViewController.reload();
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: _isConnected
              ? Stack(
            children: [
              WebView(
                key: _key,
                initialUrl: baseUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _webViewController = webViewController;
                },
                onPageStarted: (String url) {
                  setState(() {
                    _isLoadingPage = true;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    _isLoadingPage = false;
                  });
                },
                onWebResourceError: (error) {
                  setState(() {
                    _isLoadingPage = false;
                    _isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Failed to load page: ${error.description}')),
                  );
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _isLoadingPage
                    ? FadeTransition(
                  opacity: _animation,
                  child: const LinearProgressIndicator(),
                )
                    : Container(),
              ),
            ],
          )
              : const Center(
            child: Text('No Internet Connection'),
          ),
        ),
      ),
    );
  }
}


