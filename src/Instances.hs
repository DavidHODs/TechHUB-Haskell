module Instances () where

import Data.Default
import Data.Time (ZonedTime, zonedTimeToUTC)
import qualified Relude.Unsafe as Unsafe
import Data.Ord

instance Default ZonedTime where
  def = Unsafe.read "2019-08-31 05:14:37.537084021 UTC"

instance Eq ZonedTime where
  t1 == t2 = case comparing zonedTimeToUTC t1 t2 of
    EQ -> True
    _ -> False
