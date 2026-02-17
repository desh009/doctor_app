import 'package:flutter/material.dart';
import 'package:group_app/app/core/theme/app_colors.dart';

class SmoothAnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;

  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted; 
  final TextInputType? keyboardType; // ✅ নতুন লাইন যোগ করুন
  final Widget? suffixIcon; // ✅ নতুন লাইন যোগ করুন
  final Widget? prefixIcon; // ✅ নতুন লাইন যোগ করুন (যদি চান)

  
  
  // next field এ যাওয়ার জন্য এটি যোগ করুন

  const SmoothAnimatedTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.validator,
    required this.textInputAction,
    this.onFieldSubmitted, this.keyboardType, this.suffixIcon, this.prefixIcon,
  });

  @override
  State<SmoothAnimatedTextField> createState() => _SmoothAnimatedTextFieldState();
}

class _SmoothAnimatedTextFieldState extends State<SmoothAnimatedTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // টেক্সট ফিল্ডে এরর আছে কি না তা চেক করার জন্য
    final bool hasError = widget.validator != null && 
                          widget.validator!(widget.controller.text) != null && 
                          widget.controller.text.isNotEmpty;

    bool isFloating = _focusNode.hasFocus || widget.controller.text.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted, // validator না দিয়ে এটি দিন
            controller: widget.controller,
            validator: widget.validator,
            focusNode: _focusNode,
            obscureText: widget.isPassword && _isObscured,
            cursorColor: AppColors.primaryColor,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Rubik',
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              
              // ১. সাধারণ বর্ডার
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.2),
              ),
              
              // ২. ক্লিক করলে বর্ডার
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
              ),

              // ৩. এরর বর্ডার (এটি বর্ডার লাল করবে)
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1.2),
              ),

              // ৪. এরর অবস্থায় ফোকাস করলে বর্ডার
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),

              fillColor: Colors.white,
              filled: true,
              
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.grey_sio,
                        size: 20,
                      ),
                      onPressed: () => setState(() => _isObscured = !_isObscured),
                    )
                  : null,
            ),
          ),

          // এনিমেটেড লেবেল
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: isFloating ? 15 : 20,
            top: isFloating ? -10 : 18,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              style: TextStyle(
                fontSize: isFloating ? 12 : 15,
                fontWeight: isFloating ? FontWeight.w600 : FontWeight.w400,
                // এরর থাকলে লেবেল লাল হবে, ফোকাস থাকলে প্রাইমারি কালার
                color: hasError ? Colors.red : (isFloating ? AppColors.primaryColor : AppColors.grey_sio),
                fontFamily: 'Rubik',
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.white,
                child: Text(widget.label),
              ),
            ),
          ),
        ],
      ),
    );
  }
}