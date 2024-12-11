module Cardano.Plutus.ApplyArgs
  ( applyArgs
  ) where

import Prelude

import Cardano.Data.Lite as CSL
import Cardano.Types (PlutusScript(PlutusScript))
import Cardano.Types.PlutusData (PlutusData(List))
import Cardano.Types.PlutusData as PlutusData
import Cardano.Types.PlutusScript (PlutusScript)
import Cardano.Types.PlutusScript as PlutusScript
import Data.Bifunctor (rmap)
import Data.Either (Either(Left, Right))
import Data.Newtype (unwrap, wrap)
import Data.Tuple.Nested ((/\))

foreign import apply_params_to_script
  :: (forall a b. a -> Either a b)
  -> (forall a b. b -> Either a b)
  -> CSL.PlutusData
  -> CSL.PlutusScript
  -> Either String CSL.PlutusScript

apply_params_to_script_either
  :: CSL.PlutusData -> CSL.PlutusScript -> Either String CSL.PlutusScript
apply_params_to_script_either = apply_params_to_script Left Right

applyArgs
  :: PlutusScript -> Array PlutusData -> Either String PlutusScript
applyArgs script@(PlutusScript (_ /\ langVersion)) paramsList = do
  let params = PlutusData.toCsl (List paramsList)
  appliedScript <- apply_params_to_script_either params
    (PlutusScript.toCsl script)
  -- We manually set PlutusScript.Language again since there's no roundtrip
  -- guarantee for this type.
  Right $ wrap $ rmap (const langVersion) $ unwrap $ PlutusScript.fromCsl appliedScript
