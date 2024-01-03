# Scripts

These are scripts meant to be run in Windows.

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
`import-module .\powershell_modules\set-resolution.psm1`

