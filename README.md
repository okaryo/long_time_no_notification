# long_time_no_notification

A package for easy management of showing and hiding notifications once closed!

## Motivation
We wanted to be able to easily manage showing and hiding notifications on the client side only.

## Usage
```dart
// not Display forever once closed
LongTimeNoNotification.setForever(id: 'id_1');

// not show up until 7 days have passed
LongTimeNoNotification.setDuration(id: 'id_2', duration: const Duration(days: 7);

// find data by id
final notification = await LongTimeNoNotification.findBy('id_3');

// should it be displayed or not
notification.shouldNotify();
```

## Notes
- Do not duplicate IDs.
- IDs for notifications are stored in SharedPreferences, so please do not pass secure strings as IDs.
