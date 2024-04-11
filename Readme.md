# Scripts

These are scripts meant to be run in Windows.

**I do not expect these to work generically for anyone else, but they are here if in case they can help you as examples.**

# Powershell Notes

## Script Location

The script location can be found with `$PSScriptRoot`.
i.e.
`Push-Location $PSScriptRoot`

## Modules
Powershell functions can be put into a file with a .psm1 extension and put in a folder where they will "auto-load".
You can also load them by hand from any folder.
https://stackoverflow.com/a/6040725/4982408

Import modules from any folder:
https://stackoverflow.com/a/21139850/4982408
`import-module .\powershell_modules\set-scaling.psm1`

# AutoHotKey Notes

Some of these scripts require AutoHotkey to be in your path.  
I like to build it from source:  
https://github.com/AutoHotkey/AutoHotkey

It is pretty easy to build by opening the project in the free MS Visual Studio Community Edition and finding the right Build entry in the menu.  
You may have to set the dropdowns to "Release" and "x64" before building.  
Then use Build -> Build Solution.

You should find the executable in the `bin` folder when you got it right.
