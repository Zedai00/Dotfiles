import XMonad
import Data.Functor
import XMonad.Actions.Volume

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab
import XMonad.Util.ClickableWorkspaces
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.SpawnOnce
import qualified XMonad.Util.Brightness as Brightness

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.IfMax


main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (clickablePP myXmobarPP )) defToggleStrutsKey
     $ myConfig

--myXmobarSP :: PP
--myXmobarSP = dynamicLogString def
--    { ppOrder = \[_,l,_] -> [l]; ppOutput = \s -> spawn $ "fish -c 'set -U layout'" ++ s 
--    }

--   , logHook = dynamicLogWithPP def {ppLayout = show, ppOrder = \(_:l:_) -> [l], ppOutput = \s -> spawn $ "fish -c 'echo " ++ s ++ " > ~/.config/xmobar/layout ; ~/.config/xmobar/winCount.sh &> /dev/null & '"}}
  

myConfig = def
    { modMask    = mod4Mask      -- Rebind Mod to the Super key
    , layoutHook = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True
    $ myLayout      -- Use custom layouts
    , manageHook = myManageHook  -- Match on certain windows
    , handleEventHook = myEventHook-- Event Hooks
    , terminal = "konsole"
    , startupHook = myStartupHook
 `additionalKeysP`
    [ ("M-S-z"     , spawn "xscreensaver-command -lock")
    , ("M-C-s"     , unGrab *> spawn "scrot -s"        )
    , ("M-f"       , spawn "firefox"                   )
    , ("M-c"       , spawn "chrome"                    )
    , ("M1-<Space>", spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ("M-n"       , spawn "yakuake"                   )
    , ("<XF86AudioRaiseVolume>" , spawn "~/.config/xmobar/sound.sh up")
    , ("<XF86AudioLowerVolume>" , spawn "~/.config/xmobar/sound.sh down")
    , ("<XF86AudioMute>"        , spawn "~/.config/xmobar/sound.sh mute")
    , ("<XF86MonBrightnessUp>"  , spawn "~/.config/xmobar/brightness.sh up"  )
    , ("<XF86MonBrightnessDown>", spawn "~/.config/xmobar/brightness.sh down"  )
    ]


myManageHook = do 
    composeAll
        [ className =? "Gimp" --> doFloat
        , isDialog            --> doFloat
        ]


myEventHook = do 
    Hacks.windowedFullscreenFixEventHook
    Hacks.trayerAboveXmobarEventHook


myStartupHook = do
    spawn "yakuake"
    spawn "~/.config/xmobar/trayer.sh"


myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = renamed [Replace "ThreeCol"] $ magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _] -> [ws]
    --, ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    --formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    --formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    -- ppWindow :: String -> String
    -- ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

