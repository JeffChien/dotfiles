import {
  duoLayer,
  ifDevice,
  ifVar,
  map,
  mapSimultaneous,
  rule,
  toKey,
  toSetVar,
  toStickyModifier,
  writeToProfile,
} from 'karabiner.ts'

const ifErgoDoxEz = ifDevice({ vendor_id: 12951, product_id: 18804 });
const condSkipKeyboards = [
  ifErgoDoxEz.unless()
];

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
writeToProfile('ts', [
  // It is not required, but recommended to put symbol alias to layers,
  // (If you type fast, use simlayer instead, see https://evan-liu.github.io/karabiner.ts/rules/simlayer)
  // to make it easier to write '←' instead of 'left_arrow'.
  // Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

  rule('Key mapping').condition(...condSkipKeyboards).manipulators([
    // config key mappings
    map('caps_lock', '??').toIfHeldDown('left_control').toIfAlone('escape'),
    map('return_or_enter', '??').toIfHeldDown('right_control').toIfAlone('return_or_enter'),
    map('backslash', '??').toIfHeldDown('left_option').toIfAlone('backslash'),
    map('tab', '??').toIfHeldDown('left_option').toIfAlone('tab'),
    map('delete_or_backspace', '??').toIfHeldDown('delete_or_backspace', 'left_option').toIfAlone('delete_or_backspace'),
    map('right_option', '??').to('left_option', ['left_command']),
    map('left_option', '??').to('left_option', ['left_command']),
    map('left_control', '??').to('left_control', ['left_command', 'left_option']),
    map('right_control', '??').to('right_control', ['left_command', 'left_option']),
  ]),
  rule('combo').condition(...condSkipKeyboards).manipulators([
    mapSimultaneous(['e', 's']).modifiers(undefined, 'shift').toIfAlone('9').toIfHeldDown('9', 'shift'),
    mapSimultaneous(['i', 'l']).modifiers(undefined, 'shift').toIfAlone('0').toIfHeldDown('0', 'shift'),
    mapSimultaneous(['e', 'f']).modifiers(undefined, 'shift').toIfAlone('[').toIfHeldDown('[', 'shift'),
    mapSimultaneous(['i', 'j']).modifiers(undefined, 'shift').toIfAlone(']').toIfHeldDown(']', 'shift'),
    mapSimultaneous(['x', 'c']).modifiers(undefined, 'shift').toIfAlone('-').toIfHeldDown('-', 'shift'),
    mapSimultaneous([',', '.']).modifiers(undefined, 'shift').toIfAlone('=').toIfHeldDown('=', 'shift'),
    mapSimultaneous(['j', ';']).modifiers(undefined, 'any').toStickyModifier('right_shift').to('right_shift'),
    mapSimultaneous(['a', 'f']).modifiers(undefined, 'any').toStickyModifier('left_shift').to('left_shift'),
    mapSimultaneous(['t', 'y']).modifiers(undefined, 'any').toIfAlone('delete_forward').toIfHeldDown('delete_forward', 'left_option'),
    mapSimultaneous(['g', 'h']).modifiers(undefined, 'any').toIfAlone('delete_or_backspace').toIfHeldDown('delete_or_backspace', 'left_option'),
  ]),
  duoLayer('s', 'd', 'movement').condition(...condSkipKeyboards).manipulators([
    map('h', '??').to('left_arrow'),
    map('j', '??').to('down_arrow'),
    map('k', '??').to('up_arrow'),
    map('l', '??').to('right_arrow'),
    map('y', '??').to('home'),
    map('u', '??').to('page_down'),
    map('i', '??').to('page_up'),
    map('o', '??').to('end'),
    map('n', '??').to('left_arrow', 'left_option'),
    map('.', '??').to('right_arrow', 'left_option'),
  ]),
  rule('sticky shift').condition(...condSkipKeyboards).manipulators([
    map('left_shift').toIfAlone(toStickyModifier('left_shift')).to('left_shift'),
    map('right_shift').toIfAlone(toStickyModifier('right_shift')).to('right_shift')
  ]),
  duoLayer('l', 'k').condition(...condSkipKeyboards).manipulators([

    map('`', ['command', 'left_option']).to$('~/bin/sendkeys.js "\\`\\`\\`"'),
    map('1', ['command', 'left_option']).to$('~/bin/sendkeys.js "!="'),
    map('5', ['command', 'left_option']).to$('~/bin/sendkeys.js "%="'),
    map('`', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "~~~"'),
    map('1', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "!!"'),
    map('5', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "%%"'),

    map('q', { optional: 'shift' }).to('quote'),
    map('w', { optional: 'shift' }).to(','),
    map('e', { optional: 'shift' }).to('.'),
    map('r', { optional: 'shift' }).to('7'),
    map('t', { optional: 'shift' }).to('backslash'),
    map('q', ['command', 'left_option']).to$('~/bin/sendkeys.js "\'\'\'"'),
    map('w', ['command', 'left_option']).to$('~/bin/sendkeys.js "<="'),
    map('e', ['command', 'left_option']).to$('~/bin/sendkeys.js ">="'),
    map('r', ['command', 'left_option']).to$('~/bin/sendkeys.js "&="'),
    map('t', ['command', 'left_option']).to$('~/bin/sendkeys.js "|="'),
    map('q', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "\\"\\"\\""'),
    map('w', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "<<"'),
    map('e', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js ">>"'),
    map('r', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "&&"'),
    map('t', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "||"'),

    map('a', { optional: 'shift' }).to('-'),
    map('s', { optional: 'shift' }).to('['),
    map('d', { optional: 'shift' }).to(']'),
    map('f', { optional: 'shift' }).to('='),
    map('g', { optional: 'shift' }).to('/'),
    map('a', ['command', 'left_option']).to$('~/bin/sendkeys.js "-="'),
    map('s', ['command', 'left_option']).to$('~/bin/sendkeys.js "__"'),
    map('d', ['command', 'left_option']).to$('~/bin/sendkeys.js "=="'),
    map('f', ['command', 'left_option']).to$('~/bin/sendkeys.js "+="'),
    map('g', ['command', 'left_option']).to$('~/bin/sendkeys.js "/="'),
    map('a', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "--"'),
    map('d', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "==="'),
    map('f', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "++"'),
    map('g', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "//"'),

    map('z', { optional: 'shift' }).to(';'),
    map('x', { optional: 'shift' }).to('9'),
    map('c', { optional: 'shift' }).to('0'),
    map('v', { optional: 'shift' }).to('8'),
    map('z', ['command', 'left_option']).to$('~/bin/sendkeys.js ";;"'),
    map('x', ['command', 'left_option']).to$('~/bin/sendkeys.js "^="'),
    map('c', ['command', 'left_option']).to$('~/bin/sendkeys.js "->"'),
    map('v', ['command', 'left_option']).to$('~/bin/sendkeys.js "*="'),
    map('z', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "::"'),
    map('c', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "=>"'),
    map('v', ['shift', 'command', 'left_option']).to$('~/bin/sendkeys.js "**"'),

    map('b', '??').to('delete_or_backspace'),
    map('j', '??').to('right_shift'),
    map('m', '??').to('right_command', ['left_option']),
    map(';', '??').to('right_command', ['left_option', 'right_shift']),
  ]),
], {
  'simlayer.threshold_milliseconds': 125,
  'duo_layer.threshold_milliseconds': 125,
  'basic.to_if_alone_timeout_milliseconds': 115,
  'basic.to_if_held_down_threshold_milliseconds': 115,
  'basic.to_delayed_action_delay_milliseconds': 200,
})
