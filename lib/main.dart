// lib/main.dart
// FB-Style Social App UI (branding netral) — single-file, no external packages
// Works on Flutter 3.x (Material 3). Designed for Web/Desktop but responsive on mobile.

import 'package:flutter/material.dart';



void main() {
  runApp(const SocialApp());
}

class SocialApp extends StatefulWidget {
  const SocialApp({Key? key}) : super(key: key);

  @override
  State<SocialApp> createState() => _SocialAppState();
}

class _SocialAppState extends State<SocialApp> {
  final AppState appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final schemeSeed = const Color(0xFF1877F2); // classic blue vibe
        final light = ThemeData(
          useMaterial3: true,
          colorSchemeSeed: schemeSeed,
          brightness: Brightness.light,
          visualDensity: VisualDensity.standard,
          snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
        );
        final dark = ThemeData(
          useMaterial3: true,
          colorSchemeSeed: schemeSeed,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.standard,
          snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
        );
        return MaterialApp(
          title: 'FB‑Style Social App',
          debugShowCheckedModeBanner: false,
          themeMode: appState.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: light,
          darkTheme: dark,
          home: InheritedAppState(
            appState: appState,
            child: const HomePage(),
          ),
        );
      },
    );
  }
}

class InheritedAppState extends InheritedWidget {
  final AppState appState;
  const InheritedAppState({super.key, required this.appState, required super.child});
  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedAppState>()!.appState;
  @override
  bool updateShouldNotify(covariant InheritedAppState oldWidget) => oldWidget.appState != appState;
}

class AppState extends ChangeNotifier {
  bool darkMode = false;
  int selectedTopNav = 0; // 0 home, 1 video, 2 marketplace, 3 groups, 4 gaming
  final List<Post> posts = DemoData.initialPosts();
  final List<Story> stories = DemoData.initialStories();
  final User me = DemoData.me;
  final List<User> contacts = DemoData.contacts;
  final List<Birthday> birthdays = DemoData.birthdays;

  void toggleTheme() {
    darkMode = !darkMode;
    notifyListeners();
  }

  void selectTopNav(int i) {
    selectedTopNav = i;
    notifyListeners();
  }

  void addPost(Post p) {
    posts.insert(0, p);
    notifyListeners();
  }

  void toggleLike(Post p) {
    p.likedByMe = !p.likedByMe;
    p.likeCount += p.likedByMe ? 1 : -1;
    notifyListeners();
  }

  void addComment(Post p, String text) {
    p.commentCount += 1;
    notifyListeners();
  }
}

// ===== Models =====
class User {
  final String id;
  final String name;
  final String avatarUrl;
  final bool online;
  const User({required this.id, required this.name, required this.avatarUrl, this.online = false});
}

class Story {
  final User user;
  final String imageUrl;
  final bool mine;
  const Story({required this.user, required this.imageUrl, this.mine = false});
}

class LinkPreview {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  const LinkPreview({required this.title, required this.description, required this.url, required this.imageUrl});
}

class Post {
  final User author;
  final String text;
  final String? imageUrl;
  final DateTime time;
  final LinkPreview? link;
  int likeCount;
  int commentCount;
  int shareCount;
  bool likedByMe;
  Post({
    required this.author,
    required this.text,
    this.imageUrl,
    this.link,
    required this.time,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.likedByMe = false,
  });
}

class Message {
  final User sender;
  final String text;
  final DateTime time;
  const Message({required this.sender, required this.text, required this.time});
}


class Birthday {
  final User user;
  const Birthday(this.user);
}

// ===== Demo Data =====
class DemoData {
  static final User me = User(
    id: 'u_me',
    name: 'Rijal GTG (genteng)',
    avatarUrl:
        'https://uploads.dailydot.com/2025/02/jarvis_memes_usable.jpg?auto=compress&fm=pjpg',
    online: true,
  );

  static final users = <User>[
    User(
      id: 'u1',
      name: 'Joko Lombodobodo',
      avatarUrl:
          'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=256&auto=format&fit=crop&q=60',
      online: true,
    ),
    User(
      id: 'u2',
      name: 'Eric De`ridho',
      avatarUrl:
          'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?w=256&auto=format&fit=crop&q=60',
      online: true,
    ),
    User(
      id: 'u3',
      name: 'Cristiano Siu',
      avatarUrl:
          'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=256&auto=format&fit=crop&q=60',
      online: true,
    ),
    User(
      id: 'u4',
      name: 'Khresna Sinathrya Ramadhan',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=256&auto=format&fit=crop&q=60',
      online: false,
    ),
    User(
      id: 'u5',
      name: 'Yang Baca Dicium Sony',
      avatarUrl:
          'https://images.unsplash.com/photo-1544005314-9e0a16bb7366?w=256&auto=format&fit=crop&q=60',
      online: true,
    ),
    User(
      id: 'u6',
      name: 'Sony',
      avatarUrl:
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=256&auto=format&fit=crop&q=60',
      online: true,
    ),
    User(
      id: 'u7',
      name: 'Buna Teddy',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=256&auto=format&fit=crop&q=60',
      online: false,
    ),
  ];

  static List<User> get contacts => users;

  static List<Birthday> get birthdays => [
        Birthday(users[2]),
        Birthday(users[3]),
      ];

  static List<Story> initialStories() => [
        Story(
          user: me,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9cRTsoi6WXLpZi3ohIdYiKdqMaaz4tE-71Q&s',
          mine: true,
        ),
        Story(
          user: users[6],
          imageUrl:
              'https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=800&auto=format&fit=crop&q=60',
        ),
        Story(
          user: users[3],
          imageUrl:
              'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=800&auto=format&fit=crop&q=60',
        ),
        Story(
          user: users[0],
          imageUrl:
              'https://images.unsplash.com/photo-1616401784845-180882ba9ba6?w=800&auto=format&fit=crop&q=60',
        ),
        Story(
          user: users[1],
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWXzbMwN-69Euo5Vrg-D4EK6T4K75Mxoq9Pg&s',
        ),
        Story(
          user: users[2],
          imageUrl:
              'https://images.unsplash.com/photo-1519682337058-a94d519337bc?w=800&auto=format&fit=crop&q=60',
        ),
      ];

  static List<Post> initialPosts() => [
        Post(
          author: users[0],
          text: 'This has some great healthy recipes',
          imageUrl:
              'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?w=1200&auto=format&fit=crop&q=60',
          time: DateTime.now().subtract(const Duration(hours: 5)),
          likeCount: 123,
          commentCount: 24,
          shareCount: 5,
        ),
        Post(
          author: users[2],
          text:
              'New cafe opened in town! The avocado toast was amazing. Anyone wants to go this weekend? ☕️🥑',
          link: const LinkPreview(
            title: 'Local Coffee Roasters',
            description: 'Small batch beans and cozy atmosphere near the park.',
            url: 'https://example.com/coffee',
            imageUrl:
                'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?w=1200&auto=format&fit=crop&q=60',
          ),
          time: DateTime.now().subtract(const Duration(hours: 8)),
          likeCount: 88,
          commentCount: 12,
          shareCount: 2,
        ),
        Post(
          author: users[1],
          text: 'Hiking trip memories from last fall 🍂',
          imageUrl:
              'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200&auto=format&fit=crop&q=60',
          time: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
          likeCount: 201,
          commentCount: 37,
          shareCount: 19,
        ),
      ];
}

// ===== UI =====
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = InheritedAppState.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: _TopBar(app: app),
      ),
      body: const _ResponsiveBody(),
    );
  }
}

class _TopBar extends StatelessWidget {
  final AppState app;
  const _TopBar({required this.app});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      elevation: 1,
      color: cs.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              // Left: logo + search
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF1877F2),
                    child: const Icon(Icons.thumb_up, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 260,
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search social',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Center: nav icons
              SizedBox(
                width: 480,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TopIcon(
                      selected: app.selectedTopNav == 0,
                      icon: Icons.home_rounded,
                      onTap: () => app.selectTopNav(0),
                      tooltip: 'Home',
                    ),
                    _TopIcon(
                      selected: app.selectedTopNav == 1,
                      icon: Icons.ondemand_video_rounded,
                      onTap: () => app.selectTopNav(1),
                      tooltip: 'Watch',
                    ),
                    _TopIcon(
                      selected: app.selectedTopNav == 2,
                      icon: Icons.storefront_rounded,
                      onTap: () => app.selectTopNav(2),
                      tooltip: 'Marketplace',
                    ),
                    _TopIcon(
                      selected: app.selectedTopNav == 3,
                      icon: Icons.groups_rounded,
                      onTap: () => app.selectTopNav(3),
                      tooltip: 'Groups',
                    ),
                    _TopIcon(
                      selected: app.selectedTopNav == 4,
                      icon: Icons.videogame_asset_rounded,
                      onTap: () => app.selectTopNav(4),
                      tooltip: 'Gaming',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Right: actions
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Create — coming soon'))),
                    icon: const Icon(Icons.add),
                    tooltip: 'Create',
                  ),
                  const SizedBox(width: 6),
                  IconButton.filledTonal(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Messages — coming soon'))),
                    icon: const Icon(Icons.chat_bubble_rounded),
                    tooltip: 'Messages',
                  ),
                  const SizedBox(width: 6),
                  IconButton.filledTonal(
                    onPressed: () => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Notifications — coming soon'))),
                    icon: const Icon(Icons.notifications_rounded),
                    tooltip: 'Notifications',
                  ),
                  const SizedBox(width: 6),
PopupMenuButton<int>(
  tooltip: 'Menu',
  onSelected: (value) {
    switch (value) {
      case 0:
        app.toggleTheme();
        break;
      case 1:
        Navigator.pop(context); // atau aksi logout-mu di sini
        break;
    }
  },
  itemBuilder: (context) => <PopupMenuEntry<int>>[
    PopupMenuItem<int>(
      value: 0,
      child: const ListTile(
        dense: true,
        leading: Icon(Icons.brightness_6_rounded),
        title: Text('Toggle Dark Mode'),
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<int>(
      value: 1,
      child: const ListTile(
        dense: true,
        leading: Icon(Icons.logout_rounded),
        title: Text('Log out'),
      ),
    ),
  ],
  child: CircleAvatar(
    backgroundImage: NetworkImage(DemoData.me.avatarUrl),
  ),
),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TopIcon extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const _TopIcon({required this.selected, required this.icon, required this.onTap, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: selected ? cs.primary.withOpacity(0.12) : Colors.transparent,
          ),
          child: Icon(icon, size: 28, color: selected ? cs.primary : null),
        ),
      ),
    );
  }
}

class _ResponsiveBody extends StatelessWidget {
  const _ResponsiveBody();

  @override
  Widget build(BuildContext context) {
    final app = InheritedAppState.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final showLeft = w >= 980;
        final showRight = w >= 1200;
        final feedMax = showLeft && showRight ? 740.0 : (showLeft || showRight ? 820.0 : w);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showLeft) SizedBox(width: 300, child: _LeftNav(app: app)),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: feedMax),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: _CenterFeed(app: app),
                  ),
                ),
              ),
            ),
            if (showRight) SizedBox(width: 320, child: _RightPanel(app: app)),
          ],
        );
      },
    );
  }
}

class _LeftNav extends StatelessWidget {
  final AppState app;
  const _LeftNav({required this.app});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LeftTile(
            icon: CircleAvatar(backgroundImage: NetworkImage(app.me.avatarUrl)),
            label: app.me.name,
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _LeftTile(icon: const Icon(Icons.ondemand_video), label: 'Watch', onTap: () => app.selectTopNav(1)),
          _LeftTile(icon: const Icon(Icons.event), label: 'Events', onTap: () {}),
          _LeftTile(icon: const Icon(Icons.people), label: 'Friends', onTap: () {}),
          _LeftTile(icon: const Icon(Icons.history), label: 'Memories', onTap: () {}),
          const SizedBox(height: 12),
          Text('Shortcuts', style: textTheme.titleSmall),
          const SizedBox(height: 8),
          _Shortcut(label: 'Undiscovered Eats', icon: Icons.restaurant),
          _Shortcut(label: 'Weekend Trips', icon: Icons.landscape),
          _Shortcut(label: "Jasper's Market", icon: Icons.store),
          _Shortcut(label: 'Red Table Talk Group', icon: Icons.forum),
          _Shortcut(label: 'Best Hidden Hiking Trails', icon: Icons.terrain),
        ],
      ),
    );
  }
}

class _LeftTile extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  const _LeftTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: icon,
      title: Text(label, overflow: TextOverflow.ellipsis),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
    );
  }
}

class _Shortcut extends StatelessWidget {
  final String label; final IconData icon;
  const _Shortcut({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(icon),
      title: Text(label, overflow: TextOverflow.ellipsis),
      onTap: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
    );
  }
}

class _CenterFeed extends StatelessWidget {
  final AppState app;
  const _CenterFeed({required this.app});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _StoriesBar(stories: app.stories),
        const SizedBox(height: 12),
        _ComposerCard(app: app),
        const SizedBox(height: 12),
        for (final p in app.posts) _PostCard(post: p, app: app),
      ],
    );
  }
}

class _StoriesBar extends StatelessWidget {
  final List<Story> stories;
  const _StoriesBar({required this.stories});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 200,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final s = stories[i];
              return InkWell(
                onTap: () => _openStory(context, s),
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Image.network(s.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(radius: 14, backgroundImage: NetworkImage(s.user.avatarUrl)),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      right: 8,
                      child: Text(
                        s.mine ? 'Add to story' : s.user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          shadows: [Shadow(color: Colors.black.withOpacity(0.6), blurRadius: 8)],
                        ),
                      ),
                    ),
                    if (s.mine)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(Icons.add, size: 18, color: Colors.white),
                        ),
                      )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _openStory(BuildContext context, Story s) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(child: Image.network(s.imageUrl, fit: BoxFit.contain)),
            Positioned(
              left: 12,
              top: 12,
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(s.user.avatarUrl)),
                  const SizedBox(width: 8),
                  Text(s.user.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComposerCard extends StatelessWidget {
  final AppState app;
  const _ComposerCard({required this.app});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(app.me.avatarUrl)),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () => _openComposer(context, app),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text("What's on your mind, ${app.me.name}?", style: t.bodyMedium),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _ComposerButton(icon: Icons.emoji_emotions, label: 'Feeling/Activity', onTap: () {}),
                _ComposerButton(icon: Icons.person_add_alt, label: 'Tag Friends', onTap: () {}),
                _ComposerButton(icon: Icons.photo_camera, label: 'Photo/Video', onTap: ()   => _openComposer(context, app)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _openComposer(BuildContext context, AppState app) {
    final controller = TextEditingController();
    final imageCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.create),
                    const SizedBox(width: 8),
                    Text('Create Post', style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                  ],
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(backgroundImage: NetworkImage(app.me.avatarUrl)),
                  title: Text(app.me.name),
                  subtitle: const Text('Friends'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  maxLines: 5,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: imageCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Optional image URL (Unsplash, etc.)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Spacer(),
                    FilledButton(
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isEmpty) return;
                        final p = Post(
                          author: app.me,
                          text: text,
                          imageUrl: imageCtrl.text.trim().isEmpty ? null : imageCtrl.text.trim(),
                          time: DateTime.now(),
                          likeCount: 0,
                          commentCount: 0,
                          shareCount: 0,
                        );
                        app.addPost(p);
                        Navigator.pop(context);
                      },
                      child: const Text('Post'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ComposerButton extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap;
  const _ComposerButton({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post; final AppState app;
  const _PostCard({required this.post, required this.app});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(post.author.avatarUrl)),
            title: Row(
              children: [
                Flexible(child: Text(post.author.name, style: t.titleMedium)),
                const SizedBox(width: 6),
                Icon(Icons.public, size: 16, color: t.bodySmall?.color?.withOpacity(0.6)),
              ],
            ),
            subtitle: Text(_formatTimeAgo(post.time)),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text('Save post')),
                const PopupMenuItem(child: Text('Hide post')),
                const PopupMenuItem(child: Text('Report')),
              ],
              icon: const Icon(Icons.more_horiz),
            ),
          ),
          if (post.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(post.text),
            ),
          if (post.imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(post.imageUrl!, fit: BoxFit.cover),
                ),
              ),
            ),
          if (post.link != null) _LinkCard(link: post.link!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.thumb_up, size: 16, color: cs.primary),
                const SizedBox(width: 6),
                Text('${post.likeCount}'),
                const Spacer(),
                Text('${post.commentCount} comments  ·  ${post.shareCount} shares', style: t.bodySmall),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            children: [
              _ActionButton(
                icon: post.likedByMe ? Icons.thumb_up : Icons.thumb_up_outlined,
                label: 'Like',
                selected: post.likedByMe,
                onTap: () => app.toggleLike(post),
              ),
              _ActionButton(
                icon: Icons.mode_comment_outlined,
                label: 'Comment',
                onTap: () => _openComments(context, post, app),
              ),
              _ActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Share — coming soon'))),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime time) {
    final d = DateTime.now().difference(time);
    if (d.inMinutes < 60) return '${d.inMinutes} m';
    if (d.inHours < 24) return '${d.inHours} h';
    return '${d.inDays} d';
  }

  void _openComments(BuildContext context, Post p, AppState app) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 420,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(p.author.avatarUrl)),
                  title: Text('Comments on ${p.author.name}\'s post'),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) => ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(DemoData.contacts[i % DemoData.contacts.length].avatarUrl)),
                      title: Text('Nice! ${['🔥','👏','😍','👍','💯'][i % 5]}'),
                      subtitle: const Text('Just now'),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(app.me.avatarUrl)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Write a comment...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          if (controller.text.trim().isEmpty) return;
                          app.addComment(p, controller.text.trim());
                          controller.clear();
                        },
                        child: const Icon(Icons.send),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap; final bool selected;
  const _ActionButton({required this.icon, required this.label, required this.onTap, this.selected=false});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: selected ? cs.primary : null),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: selected ? cs.primary : null)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkCard extends StatelessWidget {
  final LinkPreview link;
  const _LinkCard({required this.link});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(link.imageUrl, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(link.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text(link.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Text(link.url, style: TextStyle(color: cs.primary)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RightPanel extends StatelessWidget {
  final AppState app;
  const _RightPanel({required this.app});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sponsored', style: t.titleSmall),
          const SizedBox(height: 8),
          _SponsoredCard(
            title: "Khresna's Salon",
            body:
                'Yang ga potong disini besok kodingannya error',
            imageUrl:
                'https://images.unsplash.com/photo-1548365328-9f547fb095f9?w=1200&auto=format&fit=crop&q=60',
          ),
          const SizedBox(height: 16),
          Text('Birthdays', style: t.titleSmall),
          const SizedBox(height: 8),
          ...app.birthdays.map((b) => ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: const Icon(Icons.cake_outlined),
                title: Text('${b.user.name} has a birthday today'),
              )),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Contacts', style: t.titleSmall),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),
          ...app.contacts.map((u) => _ContactTile(user: u)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _SponsoredCard extends StatelessWidget {
  final String title; final String body; final String imageUrl;
  const _SponsoredCard({required this.title, required this.body, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(body),
                  const SizedBox(height: 8),
                  FilledButton.tonal(onPressed: () {}, child: const Text('Learn more')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final User user;
  const _ContactTile({required this.user});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Stack(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
          Positioned(
            right: 0, bottom: 0,
            child: Container(
              width: 12, height: 12,
              decoration: BoxDecoration(
                color: user.online ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
              ),
            ),
          ),
        ],
      ),
      title: Text(user.name, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () {},
      ),
      onTap: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.06),
    );
  }
}
