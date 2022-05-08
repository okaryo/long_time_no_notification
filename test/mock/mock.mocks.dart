// Mocks generated by Mockito 5.1.0 from annotations
// in long_time_no_notification/test/mock/mock.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:long_time_no_notification/src/closed_notification.dart' as _i6;
import 'package:long_time_no_notification/src/closed_notifications.dart' as _i2;
import 'package:long_time_no_notification/src/notification_repository.dart'
    as _i5;
import 'package:long_time_no_notification/src/notification_shared_preferences.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeClosedNotifications_0 extends _i1.Fake
    implements _i2.ClosedNotifications {}

/// A class which mocks [NotificationSharedPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationSharedPreferences extends _i1.Mock
    implements _i3.NotificationSharedPreferences {
  MockNotificationSharedPreferences() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<String>?> get() => (super.noSuchMethod(
      Invocation.method(#get, []),
      returnValue: Future<List<String>?>.value()) as _i4.Future<List<String>?>);
  @override
  _i4.Future<bool> set(List<String>? value) =>
      (super.noSuchMethod(Invocation.method(#set, [value]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<bool> delete() =>
      (super.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}

/// A class which mocks [NotificationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationRepository extends _i1.Mock
    implements _i5.NotificationRepository {
  MockNotificationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ClosedNotifications> getNotifications() =>
      (super.noSuchMethod(Invocation.method(#getNotifications, []),
              returnValue: Future<_i2.ClosedNotifications>.value(
                  _FakeClosedNotifications_0()))
          as _i4.Future<_i2.ClosedNotifications>);
  @override
  _i4.Future<bool> setNotification(_i6.ClosedNotification? notification) =>
      (super.noSuchMethod(Invocation.method(#setNotification, [notification]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<bool> clear(List<String>? ids) =>
      (super.noSuchMethod(Invocation.method(#clear, [ids]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<bool> clearAll() =>
      (super.noSuchMethod(Invocation.method(#clearAll, []),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}
