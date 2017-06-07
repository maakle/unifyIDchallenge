Instructions for installing the App:
  1. Checkout project from this git
  2. Open the file 'unifyIDchallenge.xcodeproj'
  3. Open Terminal
  4. Inside the terminal go to the folder where have downloaded the project to with. e.g. 'cd Developer/unifyIDchallenge'
  5. Type: 'pod install' inside the Terminal and wait till pods have been installed
  6. Close the project file
  7. Open the newly created workspace file: 'unifyIDchallenge.xcworkspace'
  8. Build an run the App on your preferred device

Further Considerations 
I didn't have specific issues, more challenges, due to I haven't worked with Keychain yet. Though googling and reading the documentation helped setting it up with the this library: https://github.com/marketplacer/keychain-swift
For some minor things, I had to google e.g. how to use imagePickerController properly on stackoverflow. But I didn't run into issues here.

Further improvements could be:
  1. Improve the runtime of the saving process. e.g. smaller pictures. So far it is slow and the user has to wait while processing.
  2. Use an own encryption layer before storing the data inside Keychain.
  3. I'm using so far a library for Keychain. With more time I could double check if there is no backdoor to access the data. This could be a security issue, to use a third party library without double checking it.
  4. I'm changing the UI from a background thread so far to dismiss the camera view. This could be optimized because it is not recommended by Apple.

