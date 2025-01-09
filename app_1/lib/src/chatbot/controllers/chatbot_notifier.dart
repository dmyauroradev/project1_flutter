import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/dialogflow/v2.dart';
import 'package:googleapis_auth/auth_io.dart';

class ChatbotNotifier extends ChangeNotifier {
  List<Map<String, String>> messages = [];
  DialogflowApi? _dialogflowApi;
  String? _sessionId;
  String? _projectId;

  ChatbotNotifier() {
    _initializeDialogflow();
  }

  Future<void> _initializeDialogflow() async {
    _sessionId = "session_${DateTime.now().millisecondsSinceEpoch}";
    try {
      final jsonString =
          await rootBundle.loadString('assets/keys/dialogflow_key.json');
      final jsonData = json.decode(jsonString);

      _projectId = jsonData['project_id'];
      final clientEmail = jsonData['client_email'];
      final privateKey = jsonData['private_key'];

      final authClient = await clientViaServiceAccount(
        ServiceAccountCredentials(clientEmail, ClientId(""), privateKey),
        [DialogflowApi.cloudPlatformScope],
      );
      _dialogflowApi = DialogflowApi(authClient);
      debugPrint("Dialogflow initialized successfully.");
    } catch (error) {
      debugPrint("Error initializing Dialogflow: $error");
    }
  }

  Future<void> sendMessage(String message) async {
    if (_dialogflowApi == null) {
      return;
    }

    messages.add({"sender": "user", "message": message});
    notifyListeners();
    final response = await fetchDialogflowResponse(message);

    if (response != null) {
      messages.add({"sender": "bot", "message": response});
      notifyListeners();
    } else {
      messages.add({
        "sender": "bot",
        "message": "I couldn't get a response. Please try again."
      });
      notifyListeners();
    }
  }

  Future<String?> fetchDialogflowResponse(String message) async {
    if (_dialogflowApi == null || _projectId == null || _sessionId == null) {
      return null;
    }

    final sessionName = "projects/$_projectId/agent/sessions/$_sessionId";

    try {
      final request = GoogleCloudDialogflowV2DetectIntentRequest(
        queryInput: GoogleCloudDialogflowV2QueryInput(
          text: GoogleCloudDialogflowV2TextInput(
            text: message,
            languageCode: "vi",
          ),
        ),
      );

      final response = await _dialogflowApi!.projects.agent.sessions
          .detectIntent(request, sessionName);

      return response.queryResult?.fulfillmentText;
    } catch (error) {
      return null;
    }
  }
}
