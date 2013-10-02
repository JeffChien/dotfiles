awesome.add_signal("exit",
         function(restart)
             if not restart then
                awful.util.spawn_with_shell("~/script/logout/firefox-sync")
             end
         end)
