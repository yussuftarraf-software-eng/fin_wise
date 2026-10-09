import 'dart:io';

import 'package:fin_wise/presentation/custom_widgets/custom_main_app_container.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_notification_button.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// TODO: adjust this import to wherever shared_prefs_service.dart lives in your project

import '../../constants/my_colors.dart';
import '../../core/shared_prefs_service.dart';

class CustomProfileScaffold extends StatefulWidget {
  const CustomProfileScaffold({
    super.key,
    required this.title,
    required this.name,
    required this.id,
    required this.body,
    this.imageProvider,
    this.bodyTopOffset = 174,
    this.bodyLeftPadding = 38,
    this.isImagePickerShow = true,
  });

  final String title;
  final String name;
  final String id;

  /// The part that changes per screen (e.g. the list of CustomProfileRowElement)
  final Widget body;

  /// Pass NetworkImage / AssetImage. Falls back to the placeholder asset.
  final ImageProvider? imageProvider;

  final double bodyTopOffset;
  final double bodyLeftPadding;
  final bool isImagePickerShow;

  @override
  State<CustomProfileScaffold> createState() => _CustomProfileScaffoldState();
}

class _CustomProfileScaffoldState extends State<CustomProfileScaffold> {
  static const String _imageKey = 'profile_image_path';

  final ImagePicker picker = ImagePicker();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  /// Reads the saved path from CacheHelper (null if nothing saved yet).
  void _loadSavedImage() {
    final String? path = CacheHelper.get(key: _imageKey) as String?;
    if (path == null) return;

    final file = File(path);
    if (file.existsSync()) {
      _pickedImage = file;
    } else {
      // file was deleted -> clean the stale key so we fall back to default
      CacheHelper.removeData(key: _imageKey);
    }
  }

  /// Copies the image to permanent storage and saves its path.
  Future<void> _saveImage(XFile image) async {
    final dir = await getApplicationDocumentsDirectory();
    final String newPath = p.join(
      dir.path,
      'profile_${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}',
    );
    final File saved = await File(image.path).copy(newPath);

    // delete the previously saved image to avoid piling up files
    final String? oldPath = CacheHelper.get(key: _imageKey) as String?;
    if (oldPath != null && oldPath != newPath) {
      final oldFile = File(oldPath);
      if (await oldFile.exists()) await oldFile.delete();
    }

    await CacheHelper.set(key: _imageKey, value: saved.path);
    if (!mounted) return;
    setState(() => _pickedImage = saved);
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) return; // user cancelled
      await _saveImage(image);
    } catch (e) {
      debugPrint('Image picker error: $e');
    }
  }

  /// Saved image -> widget.imageProvider -> null (default asset is used in _ProfileImage)
  ImageProvider? get _currentImageProvider =>
      _pickedImage != null ? FileImage(_pickedImage!) : widget.imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.mainGreen,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: myColors.mainGreen,
        title: CustomTextPoppins(
          text: widget.title,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: myColors.lettersAndIcons,
        ),
        centerTitle: true,
        actions: const [CustomNotificationButton(), Gap(36)],
      ),
      body: Column(
        children: [
          const Gap(90),
          CustomMainAppContainer(
            EdgeRaduis: 100,
            backgroundColor: myColors.backgroundGreenWhite,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Name and ID
                Padding(
                  padding: const EdgeInsets.only(top: 76),
                  child: Align(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextPoppins(
                          text: widget.name,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: myColors.darkModeGreenBar,
                        ),
                        CustomTextPoppins(
                          text: "ID: ${widget.id}",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: myColors.lettersAndIcons,
                        ),
                      ],
                    ),
                  ),
                ),
                // Custom body (the only part that varies)
                Positioned(
                  top: widget.bodyTopOffset,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: widget.bodyLeftPadding),
                    child: widget.body,
                  ),
                ),
                // Profile picture
                Positioned(
                  top: -45,
                  left: 0,
                  right: 0,
                  child: Center(child: _ProfileImage(_currentImageProvider)),
                ),
                // image picker button
                if (widget.isImagePickerShow)
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(
                          30,
                          0,
                        ), // move right/left from the center
                        child: GestureDetector(
                          onTap: () {
                            debugPrint('camera icon tapped');
                            _pickImage();
                          },
                          child: SvgPicture.asset(
                            "assets/svgs/edit_profile/Icon-Cam.svg",
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage(this.imageProvider);

  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 117,
      height: 117,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image(
          image:
              imageProvider ??
              const AssetImage('assets/images/profile image placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
