class CodeSnippetGenerator {
  String elevatedButton(String label) {
    String buttonCode = '''
ElevatedButton(
  onPressed: () {
    // TODO: Implement button press logic here
  },
  child: Text('$label'),
)
''';

    return buttonCode;
  }

  String outlineButton() {
    String content = '''
class AppBorderButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final double? width;
  final double? height;
  final bool isActive;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? horizontalPadding;
  final double radius;

  const AppBorderButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isActive = true,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.horizontalPadding,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isActive && !isLoading) onTap();
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: borderColor != null ? borderColor! : Colors.blue,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
              ),
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
''';

    return content;
  }

  String loginScreen() {
    String fileContent = '''
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController tecEmail;
  late final TextEditingController tecPassword;
  bool isRemember = false;

  @override
  void initState() {
    tecEmail = TextEditingController();
    tecPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    tecEmail.dispose();
    tecPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appColorF6F7FB),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(StaticConstant.iconBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 64.0,
                  ),
                  SvgPicture.asset(
                    StaticConstant.iconLogoFull,
                    width: 150.0,
                    height: 57.29,
                  ),
                  SizedBox(
                    height: 64.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: HexColor(appColor364153),
                            fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      AppTextField(
                          hintColor: HexColor(appColorA8B0B9),
                          hintText: "Input email here..",
                          textInputType: TextInputType.emailAddress,
                          controller: tecEmail,
                          errorMessage: "invalid email",
                          onChange: (String value) {}),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: HexColor(appColor364153),
                            fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      AppPasswordField(
                          hintText: "Input password here..",
                          controller: tecPassword,
                          errorMessage: "error password",
                          onChange: (String value) {}),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Checkbox(
                                value: isRemember,
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    isRemember = value;
                                    setState(() {});
                                  }
                                }),
                            width: 24.0,
                            height: 24.0,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          GestureDetector(
                            child: Text("Remember me"),
                            onTap: () {
                              isRemember = !isRemember;
                              setState(() {});
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppButtonWidget(
                        text: 'Login',
                        onTap: () {

                        },
                        isLoading: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(),
                  ),
                );
              },
              child: Text(
                'Forgot Password? ',
                style: TextStyle(
                    color: HexColor(appColor049CFB),
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';
    
    return fileContent;
  }

}
