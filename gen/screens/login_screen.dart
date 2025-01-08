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
