import 'package:flutter/material.dart';
// import 'package:stepper_widget/widgets/custom_input.dart';

import 'cuba_custom_input.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? _selectedRole;
  String? _selectedFaculty;
  TextEditingController _organizationNameController = TextEditingController();
  TextEditingController _personInChargeController = TextEditingController();

  final List<String> _roles = ['Student', 'Staff'];
  final List<String> _faculties = [
    'Kejuruteraan Awam & Alam Bina(FKAAB)',
    'Kejuruteraan Elektrik & Elektronik(FKEE)',
    'Kejuruteraan Mekanikal & Pembuatan(FKMP)',
    'Pegurusan Teknologi & Perniagaan(FPTP)',
    'Pendidikan Teknik dan Vokasional(FPTV)',
    'Sains Komputer & Teknologi Maklumat(FSKTM)',
    'Sains Gunaan & Teknologi(FAST)',
    'Teknologi Kejuruteraan(FTK)',
    'Pusat Pengajian Diploma(PPD)'
  ];

  @override
  void dispose() {
    _organizationNameController.dispose();
    _personInChargeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedRole = _roles[0]; // Initialize with the first option
    _selectedFaculty = _faculties[0]; // Initialize with the first option
  }

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Start a Campaign',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 25),
                Text(
                  'Complete your personal information to proceed to this fundraising program',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                    child: Stepper(
                  type: StepperType.vertical,
                  currentStep: currentStep,
                  onStepCancel: () => currentStep == 0
                      ? null
                      : setState(() {
                          currentStep -= 1;
                        }),
                  onStepContinue: () {
                    bool isLastStep = (currentStep == getSteps().length - 1);
                    if (isLastStep) {
                      //Do something with this information
                    } else {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  },
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  steps: getSteps(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    var list = <Step>[
      stepOne(),
      stepTwo(),
      stepThree(),
    ];
    return list;
  }

  Step stepOne() {
    return Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text("Account Info"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you a student or staff in UTHM?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            DropdownButton<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
              items: _roles.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 25),
            Text(
              'Name of Organization',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextFormField(
              controller: _organizationNameController,
              decoration: InputDecoration(
                hintText: 'Enter organization name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter organization name';
                } else if (!isAlphabetOnly(value)) {
                  return 'Organization name must contain only alphabets';
                }
                return null;
              },
            ),
            SizedBox(height: 25),
            Text(
              'Faculty',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            DropdownButton<String>(
              value: _selectedFaculty,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFaculty = newValue;
                });
              },
              items: _faculties.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 25),
            Text(
              'Person In Charge Name',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextFormField(
              controller: _personInChargeController,
              decoration: InputDecoration(
                hintText: 'Enter person in charge name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter person in charge name';
                } else if (!isAlphabetOnly(value)) {
                  return 'Person in charge name must contain only alphabets';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  bool isAlphabetOnly(String value) {
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(value);
  }

  Step stepTwo() {
    return Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: const Text("Address"),
      content: Column(
        children: const [
          CustomInput(
            hint: "City and State",
            inputBorder: OutlineInputBorder(),
          ),
          CustomInput(
            hint: "Postal Code",
            inputBorder: OutlineInputBorder(),
          ),
        ],
      ),
    );
  }

  Step stepThree() {
    return Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: const Text("Misc"),
      content: Column(
        children: const [
          CustomInput(
            hint: "Bio",
            inputBorder: OutlineInputBorder(),
          ),
        ],
      ),
    );
  }
}
