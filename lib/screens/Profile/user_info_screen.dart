import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../Provider/account_provider.dart';
import 'login_screen.dart'; // Import LoginScreen

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  Map<String, dynamic>? _userInfo;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Gọi _fetchUserInfo nếu accessToken có sẵn khi màn hình khởi tạo
    final accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    if (accountProvider.accessToken != null) {
      _fetchUserInfo(accountProvider.accessToken!);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchUserInfo(String accessToken) async {
    const userInfoUrl = 'https://dummyjson.com/auth/me'; // URL giả định

    try {
      final response = await http.get(
        Uri.parse(userInfoUrl),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _userInfo = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Không thể tải thông tin người dùng: ${response.reasonPhrase}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Đã xảy ra lỗi: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child) {
        // Nếu chưa có accessToken thì yêu cầu đăng nhập
        if (accountProvider.accessToken == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bạn chưa đăng nhập!",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Chuyển đến màn hình đăng nhập
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text("Đăng nhập"),
                ),
              ],
            ),
          );
        }

        // Nếu đã có accessToken, tải thông tin người dùng
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return _userInfo != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 200),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          _userInfo!['image'] ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Tên
                      Text(
                        '${_userInfo!['firstName']} ${_userInfo!['lastName']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Email
                      Text(
                        _userInfo!['email'] ?? 'Email không xác định',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      // Thông tin khác
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Username'),
                          subtitle: Text(_userInfo!['username'] ?? 'N/A'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  _errorMessage.isNotEmpty
                      ? _errorMessage
                      : 'Không có dữ liệu người dùng',
                  style: const TextStyle(color: Colors.red),
                ),
              );
      },
    );
  }
}
