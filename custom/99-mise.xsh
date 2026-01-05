# Mise runtime manager for Xonsh
from os import environ
import subprocess
from xonsh.built_ins import XSH

def listen_prompt(): # Hook Events
  execx($(@(environ['HOME'])/.local/bin/mise hook-env -s xonsh))

envx = XSH.env
envx['MISE_SHELL'] = 'xonsh'
environ['MISE_SHELL'] = envx.get_detyped('MISE_SHELL')
XSH.builtins.events.on_pre_prompt(listen_prompt) # Activate hook: before showing the prompt

def _mise(args):
  if args and args[0] in ('deactivate', 'shell', 'sh'):
    execx(subprocess.run(['command', 'mise', *args], stdout=subprocess.PIPE).stdout.decode())
  else:
    subprocess.run(['/home/mcrowe/.local/bin/mise', *args])

XSH.aliases['mise'] = _mise