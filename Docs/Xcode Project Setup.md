First, get the library.

## Get the Library

Clone the JUMP for iOS library from GitHub: `git clone git://github.com/janrain/jump.ios.git`

**Important**: If you are upgrading from an earlier version of the library, see the `Upgrade Guide.md`.

## Add the Library to Your Xcode Project

1. Open your project in Xcode.
2. Make sure that the **Project Navigator** pane is showing. (**View > Navigators > Show Project Navigator**)
3. Open the **Finder** and navigate to the location where you cloned the repository. Drag the **Janrain**
   folder into your Xcode project’s **Project Navigator** pane, and drop it below the root project node.
   **Warning**: Do not drag the `jump.ios` folder into your project, drag the `Janrain` folder in.
4. In the dialog, do not check the **Copy items into destination group’s folder (if needed)** box. Ensure that the
   **Create groups for any added folders** radio button is selected, and that the **Add to targets** check box is
   selected for your application’s targets.
5. **Warning**: If you are doing a social-sign-in-only (i.e. Engage-only) integration, you must now remove the
   JRCapture project group from the Janrain project group.
5. Click **Finish**.
6. You must also add the **Security** framework, **QuartzCore** framework, and the **MessageUI** framework to your 
   project. As the **MessageUI** framework is not available on all iOS devices and versions, you must designate the
   framework as "optional."

### Framworks:

* Security - This framework is used to store session tokens in the devices security framework so that they are stored
  securely.
* QuartCore - This framework is used for animations when running on the iPad.
* MessageUI - This framework is used to integrate with the iOS device's native SMS and email capabilities, to allow
  your end-user's to share your content via email or SMS.

## Working with ARC

The JUMP for iOS library does not, itself, use Automatic Reference Counting
([ARC](http://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226-CH1-SW13)),
but you can easily add the library to a project that does. To do so:

1. Add the Janrain files to your project by following the instructions above
2. Go to your project settings, select your application’s target, and select the **Build Phases** tab.
3. Expand the section named **Compile Sources**.
4. Select all the files from the **Janrain** library, including `SFHFKeychainUtils.m` and `JSONKit.m`.
5. Press **Return** to edit all the files at once, and, in the floating text-box, add the `-fno-objc-arc` compiler
   flag.
6. After adding the compiler flag, either click **Done** in the input bubble, or press Return.

## Generating the Capture User Model

**Warning**: If you are integrating with social-sign-in-only (i.e. Engage-only), or integrating via the Phonegap
plugin, you do not generate the Capture User Model. Instead, proceed to `Engage-Only Integration Guide.md`.

You will need the [JSON-2.53+](http://search.cpan.org/~makamaka/JSON-2.53/lib/JSON.pm "JSON-2.53+") perl module. To
install the perl JSON module:

1. Make sure that perl is installed on your system. Open a command terminal and type `perl -v`. If perl is installed
   it will report the installed version. If it is not installed, consider using [MacPorts](http://www.macports.org) or
   [Homebrew](http://mxcl.github.io/homebrew/) to install it.
2. After you install perl you will need to install cpanminus. Go [here](http://www.cpan.org/modules/INSTALL.html), and
   follow the instructions to install cpanminus (typically `sudo cpan App::cpanminus`).
3. Once cpanminus is installed, use cpanminus to install the JSON module, `sudo cpanm JSON`

Once you have the perl JSON module installed you will run the schema parsing perl script to generate the Capture user
model:

1. Go to the Capture dashboard, and sign-in.
2. Use the **App** drop-down menu to select your Capture app.
3. Select the **Schema** tab.
4. Use the Entity Types drop-down menu to select the correct schema. Wait for the page to reload. (If you are already
   on the correct schema, the page will not reload.)
5. Click **Download schema**.

Once you have downloaded your schema, you will need to run it through the perl script:

1. Open a terminal window.
2. Change into the script directory:  `$ cd jump.ios/Janrain/JRCapture/Script`
3. Run the `CaptureSchemaParser.pl` script, passing in your Capture schema as an argument with the `-f` flag and the
   path to your Xcode project with the -o flag, as shown here:
`$ ./CaptureSchemaParser.pl -f PATH_TO_YOUR_SCHEMA.JSON -o PATH_TO_YOUR_XCODE_PROJECT_DIRECTORY`

The script writes its output to:

`path_to_your_xcode_project_directory/JRCapture/Generated/`

That directory contains the Janrain Capture user record model for your iOS application.

## Adding the Generated Capture User Model

Follow these steps to add the generated Capture User Model to your project.

1. If you have already added the JUMP for iOS library source code to your Xcode project, remove the project group
   which contains the generated user model first (select **Remove References** when prompted, do not move the files to
   the trash).
2. Now, choose **File** > **Add Files to "Your Project Name"...** then select the folder containing the generated user
   model, then ensure that the **Destination** checkbox (**Copy items into Destination group's folder**) is not
   checked.
3. Click **Add**.
4. Follow the instructions for disabling ARC above, for the project group that you just added.
5. Make sure that your project builds.

## Upgrading the Library from a Previous Version

To update the library references in Xcode, remove the JREngage group and re-add it.

1. Open your project in Xcode.
2. In the **Project Navigator** pane locate the **JREngage** folder (group) of your Xcode project.
3. Right-click the **JREngage** project group and click **Delete** from the context menu.
4. Do the same for the **Janrain** project group.
5. In the dialog, make sure you select the **Remove References** button.
6. Re-add the project groups, following the instructions in this guide.

### Next

If you are integrating the JUMP platform (which includes Engage and Capture), see `JUMP Integration Guide.md`.

If you are doing an social-sign-in-only integration (i.e. an Engage-only integration,) see
`Engage-Only Integration Guide.md`.