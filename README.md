Creates a changelog
===================

This script generates a changelog by listing all commits between two specified dates.

* Add this to your local manifest:
```
  <?xml version="1.0" encoding="UTF-8"?>
  <manifest>
  <!-- Changelog -->
    <project name="Professor-Berni/android_vendor_google_tools"
    path="vendor/google/tools"
    remote="github"
    revision="master" />
  </manifest>
```      
* This script cannot be run on its own; it must always be called at the end of a build process, for example:

  source build/envsetup.sh && lunch lineage_suzuran-userdebug && ./vendor/google/tools/changelog.sh
