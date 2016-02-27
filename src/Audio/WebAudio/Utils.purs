module Audio.WebAudio.Utils
  ( unsafeSetProp
  , unsafeGetProp
  ) where

import Prelude (Unit)

import Control.Monad.Eff (Eff)
  
foreign import unsafeSetProp :: forall obj val eff. String
                             -> obj
                             -> val
                             -> (Eff eff Unit)

foreign import unsafeGetProp :: forall obj val eff. String
                             -> obj
                             -> (Eff eff val)
