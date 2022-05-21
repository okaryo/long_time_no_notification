# long_time_no_notification

A package for easy management of showing and hiding notifications once closed!

## Motivation
We wanted to be able to easily manage showing and hiding notifications on the client side only.

For example, suppose the following notification is displayed in the application.

<img src="https://user-images.githubusercontent.com/44517313/169628846-d30f0b45-a1d9-4e62-861a-44ec0fcdd4b2.png" width="240px" />

As a functional requirement, the notification should not be displayed once the user closes it, either forever or for 7 days.

Also, the WebAPI does not return whether the notification should be shown or not.

In such a case, `long_time_no_notification` is useful.

## Usage
```dart
// not Display forever once closed
LongTimeNoNotification.setForever(id: 'id_1');

// not show up until 7 days have passed
LongTimeNoNotification.setDuration(id: 'id_2', duration: const Duration(days: 7);

// not show up until May 30, 2022
LongTimeNoNotification.setNext(id: 'id_2', nextDisplayAt: DateTime(2022, 5, 30);

// find data by id
final notification = await LongTimeNoNotification.findBy('id_3');

// should it be displayed or not
notification.shouldNotify();

// datetime to be displayed next
notification.nextDisplayAt;

// datetime last displayed
notification.lastDisplayAt;
```

## Notes
- Do not duplicate IDs.
- IDs for notifications are stored in SharedPreferences, so please do not pass secure strings as IDs.
