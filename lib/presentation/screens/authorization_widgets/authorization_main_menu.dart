import 'package:flower_user_ui/presentation/screens/authorization_widgets/background.dart';
import 'package:flower_user_ui/presentation/viewmodels/authorization_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthorizationMainMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthorizationViewModel>.reactive(
      viewModelBuilder: () => AuthorizationViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            const Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SigninText(),
                const LoginTextFormField(),
                const PasswordTextFormField(),
                if (viewModel.isNotValid) const InvalidLoginOrPasswordText(),
                const SigninButton(),
                const SignupButton(),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SigninText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return "Вход".text.textStyle(context.theme.textTheme.headline6!).make();
  }
}

class InvalidLoginOrPasswordText extends StatelessWidget {
  const InvalidLoginOrPasswordText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "Пароль или логин введен неправильно"
        .text
        .bold
        .red800
        .textStyle(context.theme.textTheme.bodyText2!)
        .make()
        .box
        .padding(const EdgeInsets.only(top: 30))
        .make();
  }
}

class SigninButton extends ViewModelWidget<AuthorizationViewModel> {
  const SigninButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, AuthorizationViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.only(top: 80),
      child: TextButton(
        onPressed: viewModel.isValid
            ? () {
                viewModel.signin(context: context);
              }
            : null,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 90),
            decoration: BoxDecoration(
              color: viewModel.isValid ? Colors.white : Colors.grey.shade500,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: "Войти"
                .toUpperCase()
                .text
                .red900
                .textStyle(Theme.of(context).textTheme.bodyText2!)
                .make()),
      ),
    );
  }
}

class SignupButton extends ViewModelWidget<AuthorizationViewModel> {
  const SignupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, AuthorizationViewModel viewModel) {
    return TextButton(
      onPressed: () async {
        viewModel.signup();
      },
      child: "Зарегистрироваться"
          .text
          .textStyle(Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.bold))
          .make(),
    ).box.margin(const EdgeInsets.only(top: 20)).make();
  }
}

class PasswordTextFormField extends ViewModelWidget<AuthorizationViewModel> {
  const PasswordTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, AuthorizationViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 30),
      child: TextFormField(
        obscureText: true,
        onChanged: (newPassword) {
          viewModel.password = newPassword;
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Пароль",
          focusColor: Colors.white,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class LoginTextFormField extends ViewModelWidget<AuthorizationViewModel> {
  const LoginTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, AuthorizationViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 40),
      child: TextFormField(
        onChanged: (newLogin) {
          viewModel.login = newLogin;
        },
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: const InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Логин",
          focusColor: Colors.white,
        ),
      ),
    );
  }
}
