# KMA University Management System [Front End]

## Description
This is a front end part of the KMA University Management System. It is written in ReactJS and uses Redux for state management. It is a single page application that communicates with the back end part of the system via REST API. The application is deployed on Heroku and can be accessed via the following link: https://www.fe-qlsv.web.app/

## Requirements
- Flutter SDK >= 3.0.0 < 4.0.0 with web enabled

## Installation
1. Clone the repository
2. Acivate *melos* by running
```bash
dart pub global activate melos
```
3. Install dependencies by running
```bash
melos bs
```

4. To generate assets for a project, do the following steps
```bash
cd apps/[app_name]
flutter pub run build_runner build --delete-conflicting-outputs
```

4. To run an applicaiton in devlopment mode, run
```bash
melos run [app_name]
```

## Deployment
1. Build the application by running
```bash
melos run build_[app_name]
```
