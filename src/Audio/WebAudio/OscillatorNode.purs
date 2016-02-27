module Audio.WebAudio.OscillatorNode where

import Prelude ( class Show, Unit()
               , ($), (<$>)
               , show)

import Control.Monad.Eff (Eff())

import Audio.WebAudio.Types ( AudioParam, OscillatorNode, WebAudio )
import Audio.WebAudio.Utils ( unsafeGetProp
                            , unsafeSetProp)

data OscillatorType = Sine | Square | Sawtooth | Triangle | Custom

instance oscillatorTypeShow :: Show OscillatorType where
    show Sine     = "sine"
    show Square   = "square"
    show Sawtooth = "sawtooth"
    show Triangle = "triangle"
    show Custom   = "custom"

readOscillatorType :: String -> OscillatorType
readOscillatorType "sine"     = Sine
readOscillatorType "square"   = Square
readOscillatorType "sawtooth" = Sawtooth
readOscillatorType "triangle" = Triangle
readOscillatorType "custom"   = Custom

frequency :: forall eff. OscillatorNode
          -> (Eff (wau :: WebAudio | eff) AudioParam)
frequency = unsafeGetProp "frequency"

oscillatorType :: forall eff. OscillatorNode
               -> (Eff (wau :: WebAudio | eff) OscillatorType)
oscillatorType n = readOscillatorType <$> unsafeGetProp "type" n

setOscillatorType :: forall eff. OscillatorType
                  -> OscillatorNode
                  -> (Eff (wau :: WebAudio | eff) Unit)
setOscillatorType t n = unsafeSetProp "type" n $ show t

foreign import startOscillator :: forall eff. Number
                               -> OscillatorNode
                               -> (Eff (wau :: WebAudio | eff) Unit)

foreign import stopOscillator :: forall eff. Number
                              -> OscillatorNode
                              -> (Eff (wau :: WebAudio | eff) Unit)
