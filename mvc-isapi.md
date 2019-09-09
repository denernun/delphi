**Application Pool**

```text
create a new application pool
no managed code
set pipeline mode to classic
enable 32-bit applications in advanced settings
```

**Application**

```text
create a new application under the web site
enter an alias
select the application pool created
select the physical path to the dll
```

**ISAPI/CGI Restriction**

```text
select the server node in the iis manager
open the isapi and cgi restrictions page
select edit feature settings
check the allow unspecified cgi modules
check the allow unspecified isapi modules

optional
select add
enter the isapi/cgi path to the dll
enter a description name
check the allow extension path to execute
```

**Handler Mappings**

```text
select the site/application node in the iis manager
open the handler mappings configuration page
select edit features settings
check read/script/execute

optional
select the server node in the iis manager
open the handler mappings configuration page
select edit features settings
check read/script/execute
```

**Physical Path Credentials**

```text
select the site/application node in the iis manager
select advanced settings
select physical path credentials
check the application user pass-through authentication
or enter the username and password
```

**Permissions**

```text
open the physical path of dll location
properties/security/add
add the IUSR and MACHINE/IIS_IUSRS
chech then total access for the folder
```

**IIS Error Handling**

```text
enable passthrough error handling
add the following to your web.config file
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
    <handlers accessPolicy="Read, Execute, Script">
    </handlers>
    <directoryBrowse enabled="false" />
    <httpErrors existingResponse="PassThrough" />
  </system.webServer>
</configuration>
```

***ISAPI Loader***

```text
download http://www.eggcentric.com/isapiloader.htm
rename your isapi.dll to isapi.run
copy the isapiloader.dll to executable directory of isapi.dll
rename isapiloader.dll to isapi.dll
rename isapi.dll to isapi.update when need a update isapi.run
```
