tell application "System Events"
    set foreground_app to first application process whose frontmost is true
end tell

tell foreground_app
    if count of windows > 0 then
       set foreground_app_name to name of foreground_app
       set title_bar_contents to name of front window

       copy (foreground_app_name & "##" & title_bar_contents) to stdout
    end if
end tell
