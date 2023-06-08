import { rule, map, toKey, withMapper } from "karabiner.ts";

const qwerty = {
  specialOnly: [
    withMapper(['grave_accent_and_tilde', 'comma', 'period', 'slash', 'semicolon', 'backslash', 'quote', 'open_bracket', 'close_bracket', 'hyphen', 'equal_sign'])((k) =>
      map(k).toIfHeldDown(k, 'shift', { repeat: false, halt: true })
        .toIfAlone(k, [], { halt: true })
        .toDelayedAction([], toKey(k))
        .parameters({
          'basic.to_if_alone_timeout_milliseconds': 200,
          'basic.to_if_held_down_threshold_milliseconds': 200,
        })
    ),
  ],
  numericOnly: [
    withMapper([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])((k) =>
      map(k).toIfHeldDown(k, 'shift', { repeat: false, halt: true })
        .toIfAlone(k, [], { halt: true })
        .toDelayedAction([], toKey(k))
        .parameters({
          'basic.to_if_alone_timeout_milliseconds': 200,
          'basic.to_if_held_down_threshold_milliseconds': 200,
        })
    ),
  ],
  alphaOnly: [
    withMapper(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'])((k) =>
      map(k).toIfHeldDown(k, 'shift', { repeat: false, halt: true })
        .toIfAlone(k, [], { halt: true })
        .toDelayedAction([], toKey(k))
        .parameters({
          'basic.to_if_alone_timeout_milliseconds': 200,
          'basic.to_if_held_down_threshold_milliseconds': 200,
        })
    ),
  ],
}

export const qwertyRule = {
  specialOnly: rule('QWERTY auto-shift special only').manipulators(qwerty.specialOnly),
  numericOnly: rule('QWERTY auto-shift numeric only').manipulators(qwerty.numericOnly),
  alphaOnly: rule('QWERTY auto-shift alpha only').manipulators(qwerty.alphaOnly),
}
