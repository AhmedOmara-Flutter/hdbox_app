import 'package:hdbox_app/core/helpers/app_imports.dart';

// ignore: must_be_immutable
class UpdateProfileScreen extends StatelessWidget {
  final UserModel userModel;

  UpdateProfileScreen({super.key, required this.userModel});

  var emailController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
        // if(state is UpdateProfileSuccessState){
        //   showSnakeBar(
        //     context: context,
        //     label: 'Data updated successfully!',
        //     color: Colors.green,
        //   );
        // }
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        nameController.text = userModel.name!;
        emailController.text = userModel.email!;
        return Scaffold(
          appBar: BuildAppbarScreen(title: 'Edit Profile'),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff131313),
                      backgroundImage: NetworkImage('${userModel.image}'),
                      radius: 55.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          cubit.getProfileImage();
                        },
                        child: CircleAvatar(
                          radius: 13.0,
                          backgroundColor: ColorManager.red,
                          child: Icon(
                            Icons.camera_alt,
                            color: ColorManager.white,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                BuildTextFormField(
                  contentPadding: 20.0,
                  icon: Icons.person,
                  controller: nameController,
                ),
                SizedBox(height: 10.0),
                BuildTextFormField(
                  contentPadding: 20.0,
                  icon: Icons.email,
                  controller: emailController,
                ),
                SizedBox(height: 20.0),
                ConditionalBuilder(
                  condition: state is !UpdateProfileLoadingState,
                  builder: (context) => BuildPlayButton(
                    onPressed: () async {
                      // await cubit
                      //     .updateData(
                      //   name: nameController.text,
                      //   email: emailController.text,
                      // )
                      //     .then((value) {
                      //   Navigator.pop(context);
                      // });
                      await cubit.uploadProfileImage();
                    },
                    label: 'Save Changes',
                  ),
                  fallback:(context) =>  BuildFullBack(),
                ),
              ],
            ),

          ),
        );
      },
    );
  }
}
