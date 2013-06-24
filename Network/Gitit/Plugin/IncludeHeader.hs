module Network.Gitit.Plugin.IncludeHeader where

import Network.Gitit.Interface

plugin :: Plugin
plugin = PreParseTransform addHeader

addHeader :: String -> PluginM String
addHeader cnt =
     return ("test\n" ++cnt)


