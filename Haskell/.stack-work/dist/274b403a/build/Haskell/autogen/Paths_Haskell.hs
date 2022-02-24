{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Haskell (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\fsgui\\Desktop\\Programacao\\Paradigmas de Linguagens de Programacao\\bubble-shooter\\Haskell\\.stack-work\\install\\0308410b\\bin"
libdir     = "C:\\Users\\fsgui\\Desktop\\Programacao\\Paradigmas de Linguagens de Programacao\\bubble-shooter\\Haskell\\.stack-work\\install\\0308410b\\lib\\x86_64-windows-ghc-8.10.7\\Haskell-0.1.0.0-HEHXejNNBAiLMQzKXELm4X-Haskell"
dynlibdir  = "C:\\Users\\fsgui\\Desktop\\Programacao\\Paradigmas de Linguagens de Programacao\\bubble-shooter\\Haskell\\.stack-work\\install\\0308410b\\lib\\x86_64-windows-ghc-8.10.7"
datadir    = "C:\\Users\\fsgui\\Desktop\\Programacao\\Paradigmas de Linguagens de Programacao\\bubble-shooter\\Haskell\\.stack-work\\install\\0308410b\\share\\x86_64-windows-ghc-8.10.7\\Haskell-0.1.0.0"
libexecdir = "C:\\Users\\fsgui\\Desktop\\Programacao\\Paradigmas de Linguagens de Programacao\\bubble-shooter\\Haskell\\.stack-work\\install\\0308410b\\libexec\\x86_64-windows-ghc-8.10.7\\Haskell-0.1.0.0"
sysconfdir = "C:\\Users\\fsgui\\Desktop\\Programacao\\Paradigmas de Linguagens de Programacao\\bubble-shooter\\Haskell\\.stack-work\\install\\0308410b\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Haskell_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Haskell_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Haskell_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Haskell_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Haskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Haskell_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
