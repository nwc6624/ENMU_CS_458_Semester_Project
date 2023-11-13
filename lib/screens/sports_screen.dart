import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  _SportsScreenState createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  late Key _key;
  bool _isConnected = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _key = UniqueKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInternetConnectivity();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: const Text('ENMU Athletics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _key = UniqueKey();
                _isLoading = true;
              });
            },
          ),
        ],
      ),
      body: _isConnected
          ? Stack(
        children: [
          WebView(
            key: _key,
            initialUrl: 'https://goeasternathletics.com/index.aspx',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) {
              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to load page: ${error.description}')),
              );
            },
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      )
          : const Center(
        child: Text('No Internet Connection'),
      ),
    );
  }
}
