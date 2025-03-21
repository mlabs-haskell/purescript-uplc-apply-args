module Cardano.Plutus.ApplyArgs
  ( applyArgs
  ) where

import Prelude

import Cardano.Data.Lite as CDL
import Cardano.Types (PlutusScript(PlutusScript))
import Cardano.Types.PlutusData (PlutusData(List))
import Cardano.Types.PlutusData as PlutusData
import Cardano.Types.PlutusScript (PlutusScript)
import Cardano.Types.PlutusScript as PlutusScript
import Data.Either (Either(Left, Right))
import Data.Tuple.Nested ((/\))

foreign import apply_params_to_script
  :: (forall a b. a -> Either a b)
  -> (forall a b. b -> Either a b)
  -> CDL.PlutusData
  -> CDL.PlutusScript
  -> Either String CDL.PlutusScript

apply_params_to_script_either
  :: CDL.PlutusData
  -> CDL.PlutusScript
  -> Either String CDL.PlutusScript
apply_params_to_script_either =
  apply_params_to_script Left Right

applyArgs :: PlutusScript -> Array PlutusData -> Either String PlutusScript
applyArgs script@(PlutusScript (_ /\ lang)) paramsList = do
  let params = PlutusData.toCdl (List paramsList)
  appliedScript <- apply_params_to_script_either params $ PlutusScript.toCdl script
  Right $ PlutusScript.fromCdl appliedScript lang
