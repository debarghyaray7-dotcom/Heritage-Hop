import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ─── Auth Service ─────────────────────────────────────────────────────────────
class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Current user stream
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current user
  static User? get currentUser => _auth.currentUser;

  // ── Email / Password Sign Up ─────────────────────────────────────────────
  static Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Update display name
      await credential.user?.updateDisplayName(displayName.trim());
      await credential.user?.reload();

      return AuthResult(success: true, user: _auth.currentUser);
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, error: _handleFirebaseError(e));
    } catch (e) {
      return AuthResult(success: false, error: 'An unexpected error occurred.');
    }
  }

  // ── Email / Password Login ───────────────────────────────────────────────
  static Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthResult(success: true, user: _auth.currentUser);
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, error: _handleFirebaseError(e));
    } catch (e) {
      return AuthResult(success: false, error: 'An unexpected error occurred.');
    }
  }

  // ── Google Sign In ───────────────────────────────────────────────────────
  static Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return AuthResult(success: false, error: 'Google sign-in cancelled.');
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return AuthResult(success: true, user: _auth.currentUser);
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, error: _handleFirebaseError(e));
    } catch (e) {
      return AuthResult(success: false, error: 'Google sign-in failed. Try again.');
    }
  }

  // ── Sign Out ─────────────────────────────────────────────────────────────
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // ── Password Reset ───────────────────────────────────────────────────────
  static Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return AuthResult(success: true);
    } on FirebaseAuthException catch (e) {
      return AuthResult(success: false, error: _handleFirebaseError(e));
    }
  }

  // ── Error Handler ────────────────────────────────────────────────────────
  static String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'user-disabled':
        return 'This account has been disabled.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}

// ─── Auth Result Model ────────────────────────────────────────────────────────
class AuthResult {
  final bool success;
  final User? user;
  final String? error;

  const AuthResult({
    required this.success,
    this.user,
    this.error,
  });
}