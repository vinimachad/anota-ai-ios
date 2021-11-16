fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios build_appstore_ipa
```
fastlane ios build_appstore_ipa
```

### ios fetch_certificates
```
fastlane ios fetch_certificates
```
Fetch the Development, AdHoc and Distribution Certificates
### ios create_profiles
```
fastlane ios create_profiles
```
Register devices, create certificates and provisioning profiles
### ios update_profiles
```
fastlane ios update_profiles
```
Update profiles for newly added devices
### ios generate_icon
```
fastlane ios generate_icon
```
Generate all necessary icons and put on assets
### ios create_itunes_app
```
fastlane ios create_itunes_app
```
Create app in iTunes Connect and developer portal
### ios deploy_testflight
```
fastlane ios deploy_testflight
```
Deploy a version on TestFlight
### ios upload_symbols
```
fastlane ios upload_symbols
```

### ios install
```
fastlane ios install
```
Install all project dependencies (cocoapods)
### ios test
```
fastlane ios test
```
Run all unit Tests, check coverage threshold and generates a html convarege report

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
