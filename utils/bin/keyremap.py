#!/usr/bin/env python
# -*- coding: utf-8 -*-
import shlex
import sys
import os
import subprocess as sp

xcap_setting = {
    "Control_L" : 'Escape',
    'Shift_L' : 'Control_L|s'
}

xmodmap_setting = 'numpad'

def cmdExist(program):
    import os
    def is_exe(fpath):
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file

    return None

class Xcape(object):
    def __init__(self):
        pass

    def isRunning(self):
        try:
            pid = sp.check_output(shlex.split("pgrep xcape"))
        except sp.CalledProcessError as e:
            return False
        return True

    def remap(self, setting):
        s = []
        for key, val in setting.iteritems():
            s.append('%s=%s' % (key, val))
        if self.isRunning():
            sp.call(shlex.split("pkill xcape"))
        sp.call(['xcape', '-e', ';'.join(s)])


class Xmodmap(object):
    def __init__(self, origin='origin'):
        self.origin = origin + '.xmodmap'
        self.keymapdir = os.path.join(os.getenv('HOME'), '.keyboard')

    def remap(self, setting):
        # revert to original
        #sp.call(['xmodmap', os.path.join(self.keymapdir, self.origin)])
        sp.call(['setxkbmap', '-layout', 'us', '-option', 'ctrl:swapcaps'])
        # apply keymap
        sp.call(['xmodmap', os.path.join(self.keymapdir, setting + '.xmodmap')])

def main():
    for x in ['xmodmap', 'xcape']:
        if not cmdExist(x):
            print('[error] require %s' % x)
            sys.exit(1)

    # xmodmap
    #print('applying xmodmap setting: %s' % xmodmap_setting)
    #xm = Xmodmap()
    #xm.remap(xmodmap_setting)

    # xcap
    print('applying xcap setting')
    xc = Xcape()
    xc.remap(xcap_setting)

if __name__ == '__main__':
    main()
