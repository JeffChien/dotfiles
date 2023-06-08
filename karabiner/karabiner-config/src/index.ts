import {
  duoLayer,
  layer,
  map,
  mapDoubleTap,
  mapSimultaneous,
  rule,
  simlayer,
  toStickyModifier,
  writeToProfile,
} from 'karabiner.ts'

import { qwertyRule } from './auto-shift'

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
writeToProfile('ts', [
  // It is not required, but recommended to put symbol alias to layers,
  // (If you type fast, use simlayer instead, see https://evan-liu.github.io/karabiner.ts/rules/simlayer)
  // to make it easier to write '←' instead of 'left_arrow'.
  // Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts
  rule('Key mapping').manipulators([
    // config key mappings
    map('caps_lock').toIfHeldDown('left_control').toIfAlone('escape'),
    map('return_or_enter').toIfHeldDown('right_control').toIfAlone('return_or_enter'),
    map('backslash').toIfHeldDown('left_option').toIfAlone('backslash'),
    map('right_option').to('left_option'),
    map('tab').toIfHeldDown('left_option').toIfAlone('tab')
  ]),
  duoLayer('z', 'x', 'movement').manipulators([
    map('h').to('left_arrow'),
    map('j').to('down_arrow'),
    map('k').to('up_arrow'),
    map('l').to('right_arrow'),
    map('y').to('home'),
    map('u').to('page_down'),
    map('i').to('page_up'),
    map('o').to('end'),
  ]),
  rule('sticky shift').manipulators([
    map('left_shift').toIfAlone(toStickyModifier('left_shift')).to('left_shift'),
    map('right_shift').toIfAlone(toStickyModifier('right_shift')).to('right_shift')
  ]),
  simlayer('slash', 'symbol').manipulators([
    map('x').to('9'),
    map('c').to('0'),
    map('s').to('['),
    map('d').to(']'),
    map('w').to(','),
    map('e').to('.'),
    map('a').to('hyphen'),
    map('f').to('equal_sign'),
    map('z').to('semicolon'),
    map('spacebar').toStickyModifier('left_shift').to('left_shift'),
  ]),
  duoLayer('x', 'c').manipulators([
    map(',').toPaste('<<'),
    map('.').toPaste('>>'),
    map('k').toPaste('<= '),
    map('l').toPaste('>= '),
    map('m').toPaste('->'),
    map('i').toPaste('&& '),
    map('o').toPaste('|| '),
    map('u').toPaste('+= '),
    map('y').toPaste('-= '),
    map('j').toPaste('*= '),
    map('/').toPaste('/= '),
    map(';').toPaste('::'),
  ])
], {
  'simlayer.threshold_milliseconds': 150,
  'duo_layer.threshold_milliseconds': 150,
  'basic.to_if_alone_timeout_milliseconds': 175,
  'basic.to_if_held_down_threshold_milliseconds': 100,
  'basic.to_delayed_action_delay_milliseconds': 175,
})
