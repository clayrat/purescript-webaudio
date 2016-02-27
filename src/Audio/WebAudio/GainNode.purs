module Audio.WebAudio.GainNode where

import Control.Monad.Eff (Eff)

import Audio.WebAudio.Types (AudioParam, WebAudio, GainNode)

foreign import gain :: forall eff. GainNode
                    -> (Eff (wau :: WebAudio | eff) AudioParam)
