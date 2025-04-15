[User Tekan Tombol Login]
         ↓
   UI (LoginPage)
         ↓
 context.read<LoginCubit>().login()
         ↓
   LoginCubit
      emit(LoginLoading)
         ↓
   AuthService.login() → call ke backend
         ↓
      (kembali ke cubit)
   - Kalau sukses → emit(LoginSuccess)
   - Kalau gagal  → emit(LoginFailure)
         ↓
   UI menerima state baru via BlocConsumer
         ↓
   Tampilkan:
   - Spinner
   - Pesan error
   - Pindah halaman (goRoute)
