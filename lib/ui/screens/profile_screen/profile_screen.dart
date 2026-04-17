import 'package:bike_rental/data/repositories/user/user_repository.dart';
import 'package:bike_rental/ui/screens/profile_screen/view_model/profile_vm.dart';
import 'package:bike_rental/ui/utils/async_value.dart';
import 'package:bike_rental/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => UserViewModel(userRepository: userRepo),
      child: Consumer<UserViewModel>(
        builder: (context, vm, _) {
          final asyncValue = vm.userValue;

          Widget content;
          switch (asyncValue.state) {
            case AsyncValueState.loading:
              content = const Center(child: CircularProgressIndicator());
              break;
            case AsyncValueState.error:
              content = Center(
                child: Text(
                  'Error: ${asyncValue.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
              break;
            case AsyncValueState.success:
              final user = asyncValue.data!;
              content = ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 50,
                    child: const Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 12),

                  // Name + Email
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),

                  PrimaryButton(
                    label: "Edit Profile",
                    onPressed: () {
                      // TODO: navigate to edit profile screen
                    },
                  ),
                  const SizedBox(height: 30),

                  // Your Plan
                  ListTile(
                    leading: const Icon(Icons.card_membership),
                    title: const Text("Your Plan"),
                    subtitle: Text(
                      user.activePass?.typeName ?? "No active pass",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),

                  // History
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text("History"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),

                  // Dark Mode Toggle
                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode),
                    title: const Text("Dark mode"),
                    value: false, // TODO: bind to theme state
                    onChanged: (val) {
                      // TODO: toggle theme
                    },
                  ),

                  // Logout
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                    ),
                    onTap: () {
                      // TODO: implement logout
                    },
                  ),
                ],
              );
          }

          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  "Profile",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            body: content,
          );
        },
      ),
    );
  }
}
