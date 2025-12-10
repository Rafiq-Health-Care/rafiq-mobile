import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_details_cubit/lab_test_details_cubit.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_form_cubit/lab_test_form_cubit.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_item_data.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_results_model.dart';
import 'package:rafiq/features/lab_test/data/models/test_model.dart';
import 'package:rafiq/features/lab_test/data/models/lab_test_get_all_request.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/bottom_action.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/error_banner.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/info_card.dart';
import 'package:rafiq/features/lab_test/presentation/widgets/lab_tests_form_section.dart';

class LabTestConfirmAndUpdateScreen extends StatefulWidget {
  final LabTestResultsModel resultsModel;
  const LabTestConfirmAndUpdateScreen({super.key, required this.resultsModel});

  @override
  State<LabTestConfirmAndUpdateScreen> createState() =>
      _LabTestConfirmAndUpdateScreenState();
}

class _LabTestConfirmAndUpdateScreenState
    extends State<LabTestConfirmAndUpdateScreen> {
  late final TextEditingController _nameController;
  late final ValueNotifier<DateTime> _dateNotifier;
  late final ValueNotifier<bool> _hasErrorsNotifier;
  late final LabTestFormCubit _testFormCubit;
  late final ScrollController _scrollController;
  late bool _isUpdate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isUpdate = widget.resultsModel.name != null;
    _nameController = TextEditingController(text: widget.resultsModel.name);
    _dateNotifier = ValueNotifier(widget.resultsModel.date ?? DateTime.now());
    _hasErrorsNotifier = ValueNotifier(false);
    _scrollController = ScrollController();

    _testFormCubit = LabTestFormCubit(
      widget.resultsModel.tests.map((test) {
        return LabTestItemData(
          nameController: TextEditingController(text: test.testName),
          valueController: TextEditingController(text: test.result.toString()),
          unitController: TextEditingController(text: test.unit),
          statusController: TextEditingController(text: test.status),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateNotifier.dispose();
    _hasErrorsNotifier.dispose();
    _testFormCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      final tests = _testFormCubit.state.map((item) {
        return TestModel(
          testName: item.nameController.text.trim(),
          result: double.parse(item.valueController.text.trim()),
          unit: item.unitController.text.trim(),
          status: item.statusController.text.trim(),
        );
      }).toList();

      final results = LabTestResultsModel(
        name: _nameController.text,
        date: _dateNotifier.value,
        tests: tests,
        testId: widget.resultsModel.testId,
      );

      _isUpdate
          ? LabTestDetailsCubit.get(context).updateLabTestResults(results)
          : LabTestCubit.get(context).saveLabTestResults(results);

      _hasErrorsNotifier.value = false;
    } else {
      _hasErrorsNotifier.value = true;
      snackBarMessage(context, 'Please fix the errors in the form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A3B5D),
        title: const Text(
          'Review Patient Data',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LabTestCubit, LabTestState>(
            listener: (context, state) {
              if (state is LabTestSuccess && !_isUpdate) {
                LabTestCubit.get(
                  context,
                ).getAllLabTests(const LabTestGetAllRequest());
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(RouterStrings.allLabTests),
                );
              } else if (state is LabTestError) {
                snackBarMessage(context, 'Error: ${state.message}');
              }
            },
          ),
          BlocListener<LabTestDetailsCubit, LabTestDetailsState>(
            listener: (context, state) {
              if (state is LabTestDetailsUpdated) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouterStrings.labTestDetails,
                  ModalRoute.withName(RouterStrings.allLabTests),
                  arguments: widget.resultsModel.testId,
                );

                LabTestCubit.get(
                  context,
                ).getAllLabTests(const LabTestGetAllRequest());
              } else if (state is LabTestDetailsError) {
                snackBarMessage(context, 'Error: ${state.message}');
              }
            },
          ),
        ],
        child: BlocProvider.value(
          value: _testFormCubit,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoCard(
                          nameController: _nameController,
                          dateNotifier: _dateNotifier,
                        ),
                        const SizedBox(height: 24),
                        LabTestsFormSection(
                          scrollController: _scrollController,
                        ),
                        const SizedBox(height: 16),
                        ErrorBanner(hasErrorsNotifier: _hasErrorsNotifier),
                      ],
                    ),
                  ),
                ),
                BottomActions(onSave: _saveAndContinue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
