import 'dart:async';

import 'package:emoshare_diary/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  @override
  void initState() {
    super.initState();
    _audioRecord = AudioRecorder();
    _amplitudeSub = _audioRecord!
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen(
          (amp) => setState(() {
            _amplitude = amp;
            print(_amplitude!.current);
          }),
        );
    startRecording();
  }

  void startRecording() async {
    if (await _audioRecord!.hasPermission()) {
      final stream = await _audioRecord?.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
        ),
      );
    } else {
      context.pop();
    }
  }

  @override
  void dispose() async {
    _amplitudeSub?.cancel();
    _audioRecord?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        await _audioRecord?.stop();
        context.pop();
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_amplitude != null && _amplitude!.current > -100.0)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: (MediaQuery.of(context).size.height * 0.2) *
                    ((100 + _amplitude!.current) / 100),
                height: (MediaQuery.of(context).size.height * 0.2) *
                    ((100 + _amplitude!.current) / 100),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            GestureDetector(
              onTap: () async {
                await _audioRecord?.stop();
                context.pop();
              },
              child: Container(
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
