import 'package:flutter/material.dart';
import 'package:hawkar_app/core/theme/app_theme.dart';
import 'package:hawkar_app/features/feed/domain/models/assistance_post.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  AssistanceType _selectedType = AssistanceType.request;
  AssistanceCategory _selectedCategory = AssistanceCategory.medical;
  bool _isFree = true;
  String _selectedCity = "هەولێر";

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final List<String> _cities = [
    "هەولێر",
    "سلێمانی",
    "دهۆک",
    "کەرکووک",
    "هەڵەبجە",
    "گەرمیان",
    "زاخۆ",
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _amountController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_titleController.text.trim().isEmpty || _descController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تکایە ناونیشان و ڕوونکردنەوەی داواکارییەکە بنووسە")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HawkarColors.surfaceElevated,
        behavior: SnackBarBehavior.floating,
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: HawkarColors.primaryEmerald),
            SizedBox(width: 10),
            Text("پۆستەکەت بە سەرکەوتوویی بڵاوکرایەوە!"),
          ],
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HawkarColors.bgDark,
      appBar: AppBar(
        title: const Text("دروستکردنی پۆستی هاوکاری"),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Type Switcher: Request vs Offer
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: HawkarColors.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HawkarColors.surfaceBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTypeSegment(
                      title: "داوای یارمەتی دەکەم",
                      icon: Icons.volunteer_activism_rounded,
                      type: AssistanceType.request,
                    ),
                  ),
                  Expanded(
                    child: _buildTypeSegment(
                      title: "هاوکاری پێشکەش دەکەم",
                      icon: Icons.handshake_rounded,
                      type: AssistanceType.offer,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Media Upload Card
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: HawkarColors.surfaceElevated,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HawkarColors.surfaceBorder, style: BorderStyle.solid),
              ),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("هەڵبژاردنی ڤیدیۆ یان وێنە لە گەلەری")),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.video_camera_back_rounded, size: 44, color: HawkarColors.primaryEmerald),
                    SizedBox(height: 8),
                    Text(
                      "بارکردنی کورتەڤیدیۆ یان وێنە",
                      style: TextStyle(
                        color: HawkarColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "ڤیدیۆکە متمانە و کاریگەری داواکارییەکەت ٥ هێندە زیاد دەکات",
                      style: TextStyle(color: HawkarColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Category Selector
            const Text(
              "بەشی هاوکاری دیاری بکە",
              style: TextStyle(
                color: HawkarColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AssistanceCategory.values.map((cat) {
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? HawkarColors.primaryEmerald : HawkarColors.surfaceDark,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? HawkarColors.primaryEmerald : HawkarColors.surfaceBorder,
                      ),
                    ),
                    child: Text(
                      _getCategoryKurdish(cat),
                      style: TextStyle(
                        color: isSelected ? Colors.black : HawkarColors.textSecondary,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 4. Title Input
            _buildInputField(
              controller: _titleController,
              label: "ناونیشانی کورت و ڕوون",
              hint: "بۆ نموونە: پێویستمان بە دەرزی تایبەتی دڵە",
            ),
            const SizedBox(height: 16),

            // 5. Description Input
            _buildInputField(
              controller: _descController,
              label: "تەواوی وردەکاری و هۆکار",
              hint: "ڕوونی بکەوە چۆن و لە کوێ دەتوانرێت یارمەتییەکە بگەیەنرێت...",
              maxLines: 4,
            ),
            const SizedBox(height: 20),

            // 6. Financial Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "تێچوو / بڕی پارەی پەیوەندیدار",
                  style: TextStyle(
                    color: HawkarColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text("بێبەرامبەر", style: TextStyle(color: HawkarColors.textMuted, fontSize: 13)),
                    Switch(
                      value: _isFree,
                      activeColor: HawkarColors.primaryEmerald,
                      onChanged: (val) => setState(() => _isFree = val),
                    ),
                  ],
                ),
              ],
            ),
            if (!_isFree) ...[
              const SizedBox(height: 8),
              _buildInputField(
                controller: _amountController,
                label: "بڕی پارە بە دینار",
                hint: "بۆ نموونە: ٥٠,٠٠٠",
                keyboardType: TextInputType.number,
              ),
            ],
            const SizedBox(height: 20),

            // 7. Location Selector
            const Text(
              "شوێنی پێویست بۆ هاوکاری",
              style: TextStyle(
                color: HawkarColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: HawkarColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HawkarColors.surfaceBorder),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCity,
                  dropdownColor: HawkarColors.surfaceElevated,
                  icon: const Icon(Icons.arrow_drop_down, color: HawkarColors.primaryEmerald),
                  isExpanded: true,
                  items: _cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city, style: const TextStyle(color: HawkarColors.textPrimary)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCity = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildInputField(
              controller: _addressController,
              label: "گەڕەک یان ناونیشانی نزیک",
              hint: "بۆ نموونە: نزیک مزگەوتی گەورە یان نەخۆشخانەی فێرکاری",
            ),
            const SizedBox(height: 28),

            // Submit Button
            Container(
              decoration: BoxDecoration(
                gradient: HawkarColors.emeraldGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: HawkarColors.primaryEmerald.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _submitPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send_rounded, color: Colors.black, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "بڵاوکردنەوەی پۆست",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSegment({
    required String title,
    required IconData icon,
    required AssistanceType type,
  }) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (type == AssistanceType.request ? HawkarColors.accentAmber : HawkarColors.primaryEmerald)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.black : HawkarColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : HawkarColors.textSecondary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: HawkarColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: HawkarColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: HawkarColors.textMuted, fontSize: 13),
            filled: true,
            fillColor: HawkarColors.surfaceElevated,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HawkarColors.surfaceBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HawkarColors.surfaceBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HawkarColors.primaryEmerald, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  String _getCategoryKurdish(AssistanceCategory cat) {
    switch (cat) {
      case AssistanceCategory.medical:
        return "تەندروستی";
      case AssistanceCategory.financial:
        return "دارایی";
      case AssistanceCategory.skills:
        return "شارەزایی";
      case AssistanceCategory.education:
        return "فێرکاری";
      case AssistanceCategory.dailyHelp:
        return "هاوکاری ڕۆژانە";
      case AssistanceCategory.emergency:
        return "فریاکەوتن";
    }
  }
}
