import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {//وطيفنو حمنتابع نحنا ويت من خلال الدوال
  @override
  void onCreate(BlocBase bloc) {//لما اكريت البلوك بتعطيني بلوط
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');//يعني انتا نوعط اية يعني انا كريتت اوبجيكن من اي بلوك
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);//بيديك البلوك يلي حصل فية الشينج و شو الشينج يلي حصل
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
//بيعطيك البلوط و الايرور و الستاك مريسس اي انت حتمشي الزاي
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
    //لما اقفل الكلاس
  }
}