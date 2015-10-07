module Audio.WebAudio.OscillatorNode where

import Prelude ( Show, Unit()
               , ($), (<$>)
               , show)

import Control.Monad.Eff (Eff())

import Audio.WebAudio.Types ( AudioNode
                            , AudioParam()
                            , OscillatorNode()
                            , WebAudio())
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

frequency :: forall wau eff. OscillatorNode
          -> (Eff (wau :: WebAudio | eff) AudioParam)
frequency = unsafeGetProp "frequency"

oscillatorType :: forall wau eff. OscillatorNode
               -> (Eff (wau :: WebAudio | eff) OscillatorType)
oscillatorType n = readOscillatorType <$> unsafeGetProp "type" n

setOscillatorType :: forall wau eff. OscillatorType
                  -> OscillatorNode
                  -> (Eff (wau :: WebAudio | eff) Unit)
setOscillatorType t n = unsafeSetProp "type" n $ show t

foreign import startOscillator :: forall wau eff. Number
                               -> OscillatorNode
                               -> (Eff (wau :: WebAudio | eff) Unit)

foreign import stopOscillator :: forall wau eff. Number
                              -> OscillatorNode
                              -> (Eff (wau :: WebAudio | eff) Unit)
