part of 'export.dart';

class LoadingInitialize extends StatelessWidget {
  const LoadingInitialize();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            strokeWidth: 10,
            backgroundColor: Colors.white54,
          ),
        ),
      ),
    );
  }
}
