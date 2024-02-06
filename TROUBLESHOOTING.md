```
2020-06-05 18:23:04 DEBUG Using selector: EpollSelector
2020-06-05 18:23:04 ERROR    22:                                      talon/scripting/talon_script.py:431 |
   21:                                      talon/scripting/talon_script.py:210 |
   20:                                      talon/scripting/talon_script.py:398 |
   19:                                           talon/scripting/actions.py:56  |
   18: -------------------------------------------------------------------------# cron thread
   17:                                             talon/scripting/types.py:249 |
   16:                                              user/fidget/code/vim.py:810 | v = VimMode()
   15: -------------------------------------------------------------------------# 'cron' main:<lambda>()
   14:                                              user/fidget/code/vim.py:1011| self.current_mode = self.get_active_mo..
   13:                                              user/fidget/code/vim.py:1036| nvrpc = NeoVimRPC()
   12:                                              user/fidget/code/vim.py:952 | self.nvim = neovim.attach("socket", pa..
   11:                       lib/python3.7/site-packages/pynvim/__init__.py:122 | return Nvim.from_session(session).with..
   10:                       lib/python3.7/site-packages/pynvim/api/nvim.py:80  | channel_id, metadata = session.request..
    9:            lib/python3.7/site-packages/pynvim/msgpack_rpc/session.py:96  | v = self._blocking_request(method, args)
    8: -------------------------------------------------------------------------# 'phrase' user.w2l:_redispatch()
    7:            lib/python3.7/site-packages/pynvim/msgpack_rpc/session.py:180 | self._enqueue_notification)
    6:      lib/python3.7/site-packages/pynvim/msgpack_rpc/async_session.py:66  | self._msgpack_stream.run(self._on_mess..
    5:     lib/python3.7/site-packages/pynvim/msgpack_rpc/msgpack_stream.py:44  | self.loop.run(self._on_data)
    4:    lib/python3.7/site-packages/pynvim/msgpack_rpc/event_loop/base.py:147 | self._setup_signals([signal.SIGINT, si..
    3: lib/python3.7/site-packages/pynvim/msgpack_rpc/event_loop/asyncio.py:159 | self._loop.add_signal_handler(signum, ..
    2: -------------------------------------------------------------------------# 'phrase' user.w2l:engine_event()
    1:                                 lib/python3.7/asyncio/unix_events.py:94  |
RuntimeError: set_wakeup_fd only works in main thread

    1: lib/python3.7/asyncio/unix_events.py:92|
ValueError: set_wakeup_fd only works in main thread

[The below error was raised while handling the above exception(s)]
```

https://github.com/aio-libs/aiohttp/issues/2265
