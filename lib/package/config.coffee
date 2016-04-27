{process: proc, terminal} = require '../connection'

config =
  launchOnStartup:
    type: 'boolean'
    default: proc.isBundled()
    description: 'Launch a Julia client when Atom starts.'
    order: 1
  juliaPath:
    type: 'string'
    default: if proc.isBundled() then '[bundle]' else 'julia'
    description: 'The location of the Julia binary.'
    order: 2
  juliaOptions:
    type: 'object'
    properties:
      precompiled:
        title: 'Precompiled'
        description: 'Use precompiled code from system image if available.'
        type: 'boolean'
        default: process.platform isnt 'win32'
      optimisationLevel:
        title: 'Optimisation Level'
        description: 'Higher levels take longer to compile, but produce faster code.'
        type: 'integer'
        default: 2
        enum: [0, 1, 2, 3]
    order: 3
  notifications:
    type: 'boolean'
    default: true
    description: 'Enable notifications for evaluation.'
    order: 4
  errorsToConsole:
    type: 'boolean'
    default: false
    description: 'When evaluating a script, show errors in the console instead
                  of using a notification.'
    order: 5
  enableMenu:
    type: 'boolean'
    default: proc.isBundled()
    description: 'Show a Julia menu in the menu bar (requires restart).'
    order: 6
  enableToolBar:
    type: 'boolean'
    default: proc.isBundled()
    description: 'Show Julia icons in the tool bar (requires restart).'
    order: 7

if process.platform != 'darwin'
  config.terminal =
    type: 'string'
    default: terminal.defaultTerminal()
    description: 'Command used to open a terminal.'
    order: 8

if process.platform == 'win32'
  config.enablePowershellWrapper =
    type: 'boolean'
    default: true
    description: 'Use a powershell wrapper to spawn Julia.
                  Necessary to enable interrupts.'
    order: 3.5

module.exports = config
