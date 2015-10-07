module Test01 where
-- Oscillator nodes and gain nodes.

import Prelude ( Unit()
               , (==), (+), ($)
               , bind, return, unit)

import Control.Bind
import Control.Monad.Eff
import Control.Monad.Eff.Console (CONSOLE(), log)
import Control.Monad.Eff.Console.Unsafe (logAny)
import DOM.Timer ( Timer()
                 , timeout)

import Audio.WebAudio.Types ( AudioContext()
                            , GainNode()
                            , OscillatorNode()
                            , WebAudio())
import Audio.WebAudio.AudioContext ( connect
                                   , createGain
                                   , createOscillator
                                   , currentTime
                                   , destination
                                   , makeAudioContext)
import Audio.WebAudio.AudioParam ( getValue
                                 , setValue
                                 , setValueAtTime)
import Audio.WebAudio.OscillatorNode ( OscillatorType(..)
                                     , frequency
                                     , setOscillatorType
                                     , startOscillator)
import Audio.WebAudio.GainNode (gain)

main :: forall wau dom eff. (Eff (wau :: WebAudio,
                                  console :: CONSOLE,
                                  timer :: Timer | eff) Unit)
main = do
  ctx <- makeAudioContext

  osc <- createOscillator ctx
  setOscillatorType Square osc
  startOscillator 0.0 osc

  g <- createGain ctx
  setValue 0.0 =<< gain g

  connect osc g
  connect g =<< destination ctx

  timeout 3000 $ beep ctx osc g
  return unit

beep :: forall wau eff. AudioContext
     -> OscillatorNode
     -> GainNode
     -> (Eff (wau :: WebAudio,
              timer :: Timer | eff) Unit)
beep ctx osc g = do
  freqParam <- frequency osc
  f <- getValue freqParam
  setValue (if f == 55.0 then 53.0 else 55.0) freqParam

  t <- currentTime ctx
  gainParam <- gain g
  setValueAtTime 1.000 t gainParam
  setValueAtTime 0.001 (t + 0.2) gainParam

  timeout 1000 $ beep ctx osc g
  return unit
