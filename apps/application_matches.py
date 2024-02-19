from talon import Module

mod = Module()


apps = mod.apps

apps.gdb = """
win.title: /TERM:gdb/
and win.title: /MODE:t/
"""
