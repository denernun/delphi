The following instructions have been tested under IIS 7.5

Application Pool
Create an Application Pool. Give the pool a name and select No Managed Code from the .net Framework combo. Set managed pipeline mode to Classic. Click OK to save. When running on a 64 bit OS and if the ISAPI dll has been compiled with a 32 bit compiler, then open the advanced settings for the newly created Application Pool and ensure Enable 32-bit applications is set to TRUE, otherwise skip this step.

The application will run under the default identity. If it requires access to specific resources and a domain account has been created, then enter the Identity and password under the Process Model section.

All other settings can be left at their default values.

Web Site
Create a new Application under the Web site that will be hosting the ISAPI dll. Enter an Alias, select the application pool created in step 1, and navigate to the dll to set the Physical Path. Click OK to continue.

Handler Mappings
The ISAPI dll needs to be mapped to the site so IIS can load it for relevant requests. Select the Site/Application Node in the IIS Manager. Open the Handler Mappings configuration page and add an entry for the ISAPI dll: click the action Add Script Map, enter * for the Request Path, enter the path to the dll for the Executable, and optionally give the mapping a Name. Click OK to continue. You will also be prompted to add an exemption to the global ISAPI/CGI Restrictions list. Click "Yes" to continue, then select the main Server node, open the "ISAPI and CGI Restrictions" item and update the name of the item that has just been added.

Physical Path Credentials
optional
If the site is running under a specific domain account, then the user credentials need to be granted to the physical path where the application is located. Select the Site/Application Node in the IIS Manager. Select Advanced Settings and enter the username and password in the Physical Path Credentials. Click OK to continue.

Other Permissions
The main thread of the ISAPI application runs under the context of the user as described in the section above. If your ISAPI application contains manually created threads, then those threads will run under the context of the application pool identity, typically the default which is ApplicationPoolIdentity. At run time this is impersonated by a temporary user named "machine\apppoolname" so it will look something like "MyMachine\MyApp" for an application pool named MyApp running on machine MyMachine. However as this is a temporary user that only exists when IIS is running you cannot assign security rights to it directly. The solution is to assign the necessary rights to the "machine\IIS_IUSRS" group - as above.

IIS Error Handling
By default IIS will automatically cloak any error status codes that your application generates. E.g. if your DMVC application requires that users authenticate, and returns a 401 status along with an html page directing users to the login page, IIS will unhelpfully insert its own 401 Authentication Required page and suppress the page your application is trying to render.
To change this behaviour you need to enable PassThrough error handling. Add the following to your web.config file

<system.webServer>
  <httpErrors existingResponse="PassThrough" />
</system.webServer>
ISAPI Loader
optional but recommended
To enable easy updating of ISAPI DLLs (normally the IIS service needs to be restarted to update them), run your ISAPI DLL under the ISAPI Loader. This is a loader DLL that replaces your DLL and will handle the unloading, updating and reloading when a new ISAPI DLL needs to be deployed. The ISAPI Loader is available from EggCentric http://www.eggcentric.com/ISAPILoader.htm.
To install it follow these instructions:

Rename your dll to *.run e.g. test.dll => test.run
Copy the isapiloader.dll to your isapai executable directory and rename it as *.dll e.g. isapiloader.dll => test.dll
When you need to update your dll, compile the replacement dll with an extension of ".update" and place it in your isapi directory. Within 10 seconds the old *.run dll will be unloaded and renamed to *.backup, and the new *.update file will be renamed to *.run and loaded. e.g. test.run will change to test.backup and test.update will change to test.run
You MUST set the correct directory permissions to allow the renaming and file logging to take place. Using the Windows explorer, open the isapi directory and open the security settings dialog. If the application is running under an IIS Application Pool, add the user IUSR to the list of security groups/names for the directory and grant it modify rights. Click the Advanced button, select the IUSR user and click Change Permissions. Select the Replace all child object ... this object checkbox and click OK.
Repeat the same task for the IIS_IUSRS group. FYI this is a local (not domain) group.
If the application is running as a named user (e.g. if it has limited access to specified resources) then grant access to that user following instructions in the step above.
