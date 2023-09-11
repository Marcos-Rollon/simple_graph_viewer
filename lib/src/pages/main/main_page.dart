import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:simple_graph_viewer/src/pages/main/main_page_controller.dart';
import 'package:simple_graph_viewer/src/widgets/heading_indicator.dart';

import '../../constants/constants.dart';
import '../../widgets/line_graph.dart';

class MainPage extends StatelessWidget {
  final _controller = MainPageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Flexible(
              flex: 1,
              child: Padding(
                padding: AppSizes.elementPaddingM,
                child: Column(
                  children: [
                    Obx(
                      () => HeadingIndicator(
                        title: "Pplateau",
                        value: _controller.pplateau.value,
                        units: "mbar",
                      ),
                    ),
                    const SizedBox(height: AppSizes.elementSeparationM),
                    Obx(
                      () => HeadingIndicator(
                        title: "PEEP",
                        value: _controller.peep.value,
                        units: "mbar",
                      ),
                    ),
                    // const SizedBox(height: AppSizes.elementSeparationM),
                    // Obx(
                    //   () => HeadingIndicator(
                    //     title: "Vtidal",
                    //     value: _controller.vtidal.value,
                    //     units: "ml/min",
                    //     maxValue: 1800,
                    //     minValue: 400,
                    //   ),
                    // ),
                  ],
                ),
              )),
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LineGraph(
                        controller: _controller.pressureGraphController,
                      ),
                      const SizedBox(height: AppSizes.elementSeparationL),
                      LineGraph(
                        controller: _controller.flowInputController,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: AppSizes.elementMargingM,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: _controller.connectToWebsocketServer,
                        style: AppButtonStyles.elevatedM,
                        child: const Text("Connect"),
                      ),
                      const SizedBox(width: AppSizes.elementSeparationM),
                      TextButton(
                        onPressed: _controller.disconnectWebsocketServer,
                        style: AppButtonStyles.elevatedM,
                        child: const Text("Disconnect"),
                      ),
                    ],
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
