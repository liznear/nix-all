{ config, pkgs, lib, ... }:

{
  home.file.".config/aerospace/aerospace.toml".text = ''
# Reference: https://github.com/i3/i3/blob/next/etc/config

# i3 doesn't have "normalizations" feature that why we disable them here.
# But the feature is very helpful.
# Normalizations eliminate all sorts of weird tree configurations that don't make sense.
# Give normalizations a chance and enable them back.
enable-normalization-flatten-containers = false
enable-normalization-opposite-orientation-for-nested-containers = false

# Mouse follows focus when focused monitor changes
on-focused-monitor-changed = ['move-mouse monitor-lazy-center']

[mode.main.binding]

# i3 wraps focus by default
alt-h =         'focus --boundaries-action wrap-around-the-workspace left'
alt-j =         'focus --boundaries-action wrap-around-the-workspace down'
alt-k =         'focus --boundaries-action wrap-around-the-workspace up'
alt-l = 'focus --boundaries-action wrap-around-the-workspace right'

alt-shift-h = 'move left'
alt-shift-j = 'move down'
alt-shift-k = 'move up'
alt-shift-l = 'move right'

# Consider using 'join-with' command as a 'split' replacement if you want to enable normalizations
# alt-h = 'split horizontal'
# alt-v = 'split vertical'

alt-f = 'fullscreen'

alt-s = 'layout v_accordion' # 'layout stacking' in i3
alt-w = 'layout h_accordion' # 'layout tabbed' in i3
alt-e = 'layout tiles horizontal vertical' # 'layout toggle split' in i3

# alt-shift-space = 'layout floating tiling' # 'floating toggle' in i3

# Not supported, because this command is redundant in AeroSpace mental model.
# See: https://nikitabobko.github.io/AeroSpace/guide#floating-windows
#alt-space = 'focus toggle_tiling_floating'

# `focus parent`/`focus child` are not yet supported, and it's not clear whether they
# should be supported at all https://github.com/nikitabobko/AeroSpace/issues/5
# alt-a = 'focus parent'

alt-1 = 'workspace 1'
alt-2 = 'workspace 2'
alt-3 = 'workspace 3'
alt-4 = 'workspace 4'
alt-5 = 'workspace 5'
alt-6 = 'workspace 6'
alt-7 = 'workspace 7'
alt-8 = 'workspace 8'
alt-9 = 'workspace 9'
alt-0 = 'workspace 10'

alt-shift-1 = 'move-node-to-workspace 1'
alt-shift-2 = 'move-node-to-workspace 2'
alt-shift-3 = 'move-node-to-workspace 3'
alt-shift-4 = 'move-node-to-workspace 4'
alt-shift-5 = 'move-node-to-workspace 5'
alt-shift-6 = 'move-node-to-workspace 6'
alt-shift-7 = 'move-node-to-workspace 7'
alt-shift-8 = 'move-node-to-workspace 8'
alt-shift-9 = 'move-node-to-workspace 9'
alt-shift-0 = 'move-node-to-workspace 10'

alt-shift-c = 'reload-config'

alt-r = 'mode resize'

[gaps]
inner.horizontal = 10
inner.vertical =   10
outer.left =       10
outer.bottom =     10
outer.top =        10
outer.right =      10

[mode.resize.binding]
h = 'resize width -50'
j = 'resize height +50'
k = 'resize height -50'
l = 'resize width +50'
enter = 'mode main'
esc = 'mode main'

[[on-window-detected]]
if.app-id="com.mitchellh.ghostty"
run= [
  "layout tiling",
]

[[on-window-detected]]
if.app-id = "com.apple.dt.Xcode"
run = [
  "layout tiling"
]
'';
}
