// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hiveandapi_clean/features/auth/presentation/viewmodel/auth_view_model.dart';
// import 'package:hiveandapi_clean/features/batch/domain/entity/batch_entity.dart';
// import 'package:hiveandapi_clean/features/batch/presentation/viewmodel/batch_view_model.dart';
// import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';
// import 'package:hiveandapi_clean/features/course/presentation/viewmodel/course_viewmodel.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

// class RegisterScreen extends ConsumerStatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _RegisterScreenState();
// }

// class _RegisterScreenState extends ConsumerState<RegisterScreen> {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final phonenoController = TextEditingController();

//   String? batch;
//   String? course;
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final fkey = GlobalKey<FormState>();

//   BatchEntity? _dropDownValue;

//   final List<CourseEntity> _lstCourseSelected = [];


//     // Check camera permission


//   checkCameraPermission() async {
//     if (await Permission.camera.request().isRestricted ||
//         await Permission.camera.request().isDenied) {
//       await Permission.camera.request();
//     }
//   }



//   // Browse image from camera or gallery
//   File? _img;

//   Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           ref.read(authViewModelProvider.notifier).uploadProfilePicture(_img!);
//         });
//       } else {
//         return;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }






//   @override
//   Widget build(BuildContext context) {
//     final batchState = ref.watch(batchViewModelProvider);
//     final courseState = ref.watch(courseViewModelProvider);
//     final authState = ref.watch(authViewModelProvider);

//     const gap = SizedBox(
//       height: 15,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Register Screen"),
//       ),
//       body: Form(
//         key: fkey,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [

//                 InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.grey[300],
//                         context: context,
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(20),
//                           ),
//                         ),
//                         builder: (context) => Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ref, ImageSource.camera);
//                                   Navigator.pop(context);
//                                   // Upload image it is not null
//                                 },
//                                 icon: const Icon(Icons.camera),
//                                 label: const Text('Camera'),
//                               ),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ref, ImageSource.gallery);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.image),
//                                 label: const Text('Gallery'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: SizedBox(
//                       height: 200,
//                       width: 200,
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: _img != null
//                             ? FileImage(_img!)
//                             : const AssetImage('assets/images/profile.png')
//                                 as ImageProvider,
//                       ),
//                     ),
//                   ),



              






//                 gap,
//                 // First Name
//                 TextFormField(
//                   controller: firstNameController,
//                   decoration: const InputDecoration(
//                     labelText: "First Name",
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your first name';
//                     }
//                     return null;
//                   },
//                 ),
//                 gap,
//                 // Last Name
//                 TextFormField(
//                   controller: lastNameController,
//                   decoration: const InputDecoration(
//                     labelText: "Last Name",
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your last name';
//                     }
//                     return null;
//                   },
//                 ),
//                 gap,
//                 // Phone Number
//                 TextFormField(
//                   controller: phonenoController,
//                   decoration: const InputDecoration(
//                     labelText: "Phone Number",
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 gap,

//                 // Batch Selector
//                 if (batchState.isLoading) ...{
//                   const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 } else if (batchState.error != null) ...{
//                   Center(
//                     child: Text(batchState.error!),
//                   )
//                 } else ...{
//                   DropdownButtonFormField(
//                     items: batchState.batches
//                         .map((e) => DropdownMenuItem(
//                               value: e,
//                               child: Text(e.batchName),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       _dropDownValue = value;
//                     },
//                     value: _dropDownValue,
//                     decoration: const InputDecoration(
//                       labelText: 'Select Batch',
//                     ),
//                   )
//                 },
//                 gap,

//                 // Courses Selector using multiselect dialog
//                 if (courseState.isLoading) ...{
//                   const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 } else if (courseState.error != null) ...{
//                   Center(
//                     child: Text(courseState.error!),
//                   )
//                 } else ...{
//                   MultiSelectDialogField(
//                     title: const Text('Select course'),
//                     items: courseState.courses
//                         .map((course) => MultiSelectItem(
//                               course,
//                               course.courseName,
//                             ))
//                         .toList(),
//                     listType: MultiSelectListType.CHIP,
//                     buttonText: const Text('Select course'),
//                     buttonIcon: const Icon(Icons.search),
//                     onConfirm: (values) {
//                       _lstCourseSelected.clear();
//                       _lstCourseSelected.addAll(values);
//                     },
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                       ),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select courses';
//                       }
//                       return null;
//                     }),
//                   ),
//                 },

//                 gap,
//                 const Text(
//                   'Selected Courses: ',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 gap,
//                 TextFormField(
//                   controller: usernameController,
//                   decoration: const InputDecoration(
//                     labelText: "Username",
//                   ),
//                 ),
//                 gap,
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: "Password",
//                   ),
//                 ),
//                 gap,
//                 //  auth
//                 if (authState.isLoading) ...{
//                   const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 } else if (authState.error != null) ...{
//                   Center(
//                     child: Text(authState.error!),
//                   )
//                 } else ...{
//                   ElevatedButton(
//                     onPressed: () {
//                       // Perform registration logic here
//                     },
//                     child: const Text('Register'),
//                   ),
//                 },
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiveandapi_clean/core/common/snackbar/my_snackbar.dart';
import 'package:hiveandapi_clean/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:hiveandapi_clean/features/batch/domain/entity/batch_entity.dart';
import 'package:hiveandapi_clean/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:hiveandapi_clean/features/course/domain/entity/course_entity.dart';
import 'package:hiveandapi_clean/features/course/presentation/viewmodel/course_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entity/student_entity.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(authViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  BatchEntity? _dropDownValue;
  final List<CourseEntity> _lstCourseSelected = [];

  final _gap = const SizedBox(height: 8);

  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final batchState = ref.watch(batchViewModelProvider);
    final courseState = ref.watch(courseViewModelProvider);
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  checkCameraPermission();
                                  _browseImage(ref, ImageSource.camera);
                                  Navigator.pop(context);
                                  // Upload image it is not null
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  checkCameraPermission();
                                  _browseImage(ref, ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _fnameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _lnameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone No',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phoneNo';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  if (batchState.isLoading) ...{
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  } else if (batchState.error != null) ...{
                    Center(
                      child: Text(batchState.error!),
                    )
                  } else ...{
                    DropdownButtonFormField(
                      items: batchState.batches
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.batchName),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _dropDownValue = value;
                      },
                      value: _dropDownValue,
                      decoration: const InputDecoration(
                        labelText: 'Select Batch',
                      ),
                      validator: ((value) {
                        if (value == null) {
                          return 'Please select batch';
                        }
                        return null;
                      }),
                    ),
                  },
                  _gap,
                  if (courseState.isLoading) ...{
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  } else if (courseState.error != null) ...{
                    Center(
                      child: Text(courseState.error!),
                    )
                  } else ...{
                    MultiSelectDialogField(
                      title: const Text('Select course'),
                      items: courseState.courses
                          .map((course) => MultiSelectItem(
                                course,
                                course.courseName,
                              ))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      buttonText: const Text('Select course'),
                      buttonIcon: const Icon(Icons.search),
                      onConfirm: (values) {
                        _lstCourseSelected.clear();
                        _lstCourseSelected.addAll(values);
                      },
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select courses';
                        }
                        return null;
                      }),
                    ),
                  },
                  _gap,
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          var student = StudentEntity(
                            fname: _fnameController.text,
                            lname: _lnameController.text,
                            image:
                                ref.read(authViewModelProvider).imageName ?? '',
                            phone: _phoneController.text,
                            username: _usernameController.text,
                            password: _passwordController.text,
                            batch: _dropDownValue,
                            courses: _lstCourseSelected,
                          );
                          ref
                              .read(authViewModelProvider.notifier)
                              .registerStudent(student);

                          if (authState.error != null) {
                            showSnackBar(
                              message: authState.error.toString(),
                              context: context,
                              color: Colors.red,
                            );
                          } else {
                            showSnackBar(
                              message: 'Registered successfully',
                              context: context,
                            );
                          }
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}