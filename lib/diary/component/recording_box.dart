import 'dart:async';

import 'package:dio/dio.dart';
import 'package:emoshare_diary/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordingBox extends StatefulWidget {
  const RecordingBox({super.key});

  @override
  State<RecordingBox> createState() => _RecordingBoxState();
}

class _RecordingBoxState extends State<RecordingBox> {
  AudioRecorder? _audioRecord;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _audioRecord = AudioRecorder();
    _amplitudeSub = _audioRecord!
        .onAmplitudeChanged(const Duration(milliseconds: 100))
        .listen(
          (amp) => setState(() {
            _amplitude = amp;
          }),
        );
    startRecording();
  }

  void startRecording() async {
    if (await _audioRecord!.hasPermission()) {
      await _audioRecord!.start(
        const RecordConfig(),
        path: '${(await getTemporaryDirectory()).path}/tempAudio.m4a',
      );
    } else {
      context.pop();
    }
  }

  @override
  void dispose() async {
    _amplitudeSub?.cancel();
    _audioRecord?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (isLoading) {
          return;
        } else {
          await _audioRecord?.stop();
          context.pop();
        }
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_amplitude != null && !isLoading)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _amplitude!.current < -20
                    ? MediaQuery.of(context).size.height * 0.12
                    : MediaQuery.of(context).size.height * 0.12 +
                        (MediaQuery.of(context).size.height * 0.1) *
                            ((40 + _amplitude!.current) / 40),
                height: _amplitude!.current < -20
                    ? MediaQuery.of(context).size.height * 0.12
                    : MediaQuery.of(context).size.height * 0.12 +
                        (MediaQuery.of(context).size.height * 0.1) *
                            ((40 + _amplitude!.current) / 40),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            GestureDetector(
              onTap: () async {
                if (isLoading) {
                  return;
                } else {
                  setState(() {
                    isLoading = true;
                  });
                }

                final path = await _audioRecord!.stop();

                final formData = FormData.fromMap({
                  'audio': await MultipartFile.fromFile(path!),
                });
                final response = await Dio().post(
                  'http://10.0.2.2:5001/emoshare-diary/asia-northeast3/openaiAPI/stt',
                  data: formData,
                );

                context.pop(response.data['text']);
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      width: MediaQuery.of(context).size.height * 0.1,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: PRIMARY_COLOR,
                      ),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.06,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
