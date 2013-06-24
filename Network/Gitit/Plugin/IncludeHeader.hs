module Network.Gitit.Plugin.IncludeHeader where

import Control.Monad.CatchIO (try)
import Network.Gitit.Interface
import Data.FileStore (FileStoreError, retrieve)
import Network.Gitit.Framework (filestoreFromConfig)

plugin :: Plugin
plugin = PreParseTransform addHeader

addHeader :: String -> PluginM String
addHeader cnt = do
    cfg <- askConfig
    let fs = filestoreFromConfig cfg
    texmacros <- try $ liftIO (retrieve fs ("texmacros.tex") Nothing)
    case texmacros :: Either FileStoreError String of
          Left  _    -> return cnt
          Right a    -> return (filter (/= '\r') a ++ "\n\n" ++ cnt)


