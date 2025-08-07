# mercLibreProjectMobile

# 📱 Mobile Automation Framework (RSpec + Appium)

This project is a mobile test automation framework built with **Ruby**, **RSpec**, and **Appium**, with support for reporting using **Allure**.

---

## ✅ Prerequisites

Before running the project, ensure you have the following installed:

- [Ruby](https://www.ruby-lang.org/en/) (3.0 or higher)
- [Bundler](https://bundler.io/)
- [Appium Server](https://appium.io/) (CLI or Desktop)
- [Android SDK](https://developer.android.com/studio)
- A physical or virtual Android device/emulator
- Have the Mercadolibre app installed on the device or have the apk

If you want to check the prerequisites you can use the following command:

```bash
ruby -v
bundler -v
appium -v
sdkmanager --list
adb devices
```

### 🚀 How to Run Tests

First of all you need to clone the repository

```bash
git clone https://github.com/Felipe-SG14/mercLibreProjectMobile.git
```

Once cloned, you move to the main folder with this command.

```bash
cd mercLibreProjectMobile
```

Install dependencies using:
```bash
bundle install
```

## ⚙️ Desired Capabilities – `settings.yml`
By default, the framework takes the following parameters
```yaml
udid: "AndroidDevice"                                                  # Device/emulator udid
appPackage: com.mercadolibre                                           # App package to test
appActivity: com.mercadolibre.navigation.activities.BottomBarActivity  # Launch activity
noReset: true                                                          # Keep app state (don't reset data)
server_url: "http://localhost:4723"                                    # Appium server address
```
You can go and edit the file that is located at the root of the project with the values you want.

The Framework can read the following environment variables:
- SERVER_URL
- UDID
- APP
- APP_PACKAGE
- APP_ACTIVITY

The mandatory variables are:
- SERVER_URL
- UDID
- APP_PACKAGE

# In case you want to run an already installed application

**Ensure your Appium server is running and your device is connected via ADB.**

The mandatory variables are:
- SERVER_URL
- UDID
- APP_PACKAGE
- APP_ACTIVITY

You need to provide both the **appPackage** and the **appActivity** in order to open and close the application.

The command to run the application would look as follows:

Linux
```bash
SERVER_URL=http://localhost:4723 UDID=emulator-5554 APP_PACKAGE=com.mercadolibre APP_ACTIVITY=com.mercadolibre.navigation.activities.BottomBarActivity rspec ./spec/tests/mercado_libre_tests.rb
```

# In case you want to run an application with the apk

**Ensure your Appium server is running and your device is connected via ADB.**

The mandatory variables are:
- SERVER_URL
- UDID
- APP_PACKAGE
- APP

You need to provide  **app** that contains the apk path and **appPackage**

The command to run the application would look as follows:

Linux
```bash
SERVER_URL=http://localhost:4723 UDID=emulator-5554 APP_PACKAGE=io.appium.android.apis APP=resources/app/ApiDemos-debug.apk rspec ./spec/tests/mercado_libre_tests.rb
```

# If you want to run the automation with the default values defined in the settings.yml file
Run a test with default configuration

Windows (PS)
```bash
rspec .\spec\tests\mercado_libre_tests.rb
```

Linux
```bash
rspec spec/tests/mercado_libre_tests.rb 
```

### 📊 Report 

By default, a report is generated at the following address: **.\logs\test_report.html**

To view the report in your default browser simply run the following command:

```bash
start logs/test_report.html
```