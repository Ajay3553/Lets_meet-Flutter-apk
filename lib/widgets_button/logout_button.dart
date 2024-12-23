import 'package:flutter/material.dart';
import 'package:lets_meet/resources/auth_methods.dart';

class LogoutButton extends StatefulWidget {
  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool _isLoading = false;
  String _name = '';
  String _email = '';
  String _profilePicUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var userInfo = await AuthMethods().user;

      if (userInfo != null) {
        setState(() {
          _name = userInfo.displayName ?? 'No Name';
          _email = userInfo.email ?? 'No Email';
          _profilePicUrl = userInfo.photoURL ?? '';
        });
      } else {
        setState(() {
          _name = 'Error';
          _email = 'Error';
          _profilePicUrl = '';
        });
      }
    } catch (e) {
      // Handle error
      print("Error fetching user info: $e");
      setState(() {
        _name = 'Error';
        _email = 'Error';
        _profilePicUrl = '';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleLogout() async {
    setState(() {
      _isLoading = true;
    });

    await AuthMethods().SignedOut();

    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profilePicUrl.isNotEmpty
                        ? NetworkImage(_profilePicUrl)
                        : null,
                    backgroundColor: Colors.grey[300],
                    child: _profilePicUrl.isEmpty
                        ? const Icon(Icons.person,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _email,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Background color
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Log Out',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
