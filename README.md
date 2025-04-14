# PPB Phonebook - Tugas 2 PPB

A simple CRUD Phonebook app built using Flutter and SQFLite
local database, developed by yours truly:

- **Name:** Keanu Fortuna Taufan
- **NRP:** 5025221043
- **Class:** Mobile Programming B

Some (laggy) preview:

https://github.com/user-attachments/assets/03464886-fd36-4d4d-a3f2-97ab9c66a0cb

## Features

- **List contacts** - List existing contacts, ordered by name alphabetically
- **Create new contact** - Create new contact using name, phone number, and email
- **Edit existing contacts** - Edit info of already existing contacts
- **Delete contact** - Remove contact with swipe gesture
- **Persistence** - Data is persisted across sessions using local SQLite database

## Powered By

- **Flutter** - UI framework used in this project
- **SQFLite** - Flutter plugin for SQLite
- **Flutter Hooks** - Lifecycle manager for objects
- **Form Builder** - For building contact add and edit forms
- **Form Builder Validator** - For validating form submission
- **Project IDX** - Cloud IDE for building Flutter (and more) application

## Installation

### Prerequisites

- Dart and Flutter SDK
- Device emulator or real device in developer mode
- Code editor

### Steps

**1. Clone this repository:**

```bash
git clone https://github.com/keanutaufan/ppb_phonebook.git
cd ppb_phonebook
```

**2. Install dependencies:**

```bash
flutter pub get
```

**3. Run the application:**

```bash
flutter run
```

## How to Use

1. **Opening the application**
   - You will be presented with list of your contacts (ordered by name), or empty contact screen if there's no data
  
2. **Adding new contact**
   - Click the floating action button in the bottom right to add new contact
   - You will be presented with bottom sheet to fill in the new contact detail
   - Once data has been filled in, tap the **Add Contact** button to save the new contact
   - Your now contact should now be added to the main screen
  
3. **Editing existing contact**
   - You can view and edit the detail of existing contact by tapping its tile in the main screen
   - The same bottom sheet will be presented, change the contact detail as needed
   - Tap the **Edit Contact** button to persist your change
   - The new contact detail should be applied on the main screen
  
4. **Deleting contact**
   - Swipe the contact tile that you want to delete

## How I dit it?

- I started by thinking about the very object that I would be making: a contact. What properties should it have? This data definition is then stored in `lib/models`
- Internally, SQFLite stores object as `Map<String, dynamic>`, so I wrote serializer and deserializer for converting between SQFLite data representation and Flutter object (this will become handy later) 
- The project requirement mandates the use of SQFLite, so the next thing is to create logic for initializing and cleaning up database, which you can see in `lib/database`
- Then, I thought of what operations can be done to this object that I'm making (the contact), and it's pretty straightforward: CRUD, so I wrote the repository logic in the same place as other database operations for simplicity (don't actually do this for larger scale application)
- The UI part is mostly straightforward: you'll need a floating action button that triggers the bottom sheet to fill in the detail of contact using `FormBuilder` as helper. Contacts itself are presented as list tile that is wrapped around `Dismissible` widget for swipe-to-delete feature, and tapping it triggers the same bottom sheet but this time it acts as update form.
- When the data is updated, the underlying UI is not updated unless we explicitly tell it to, so I use `flutter_hooks` to get flutter to fetch the new data from SQFLite once actions are performed on contacts (think of it as cache invalidation).
- The rest is mostly UI adjustments, code cleaning, and wrapping my head around dart's async programming.
  
## References

This project is heavily inspired on HeyFlutter's SQFLite Todo App Tutorial on [YouTube](https://www.youtube.com/watch?v=bihC6ou8FqQ).
