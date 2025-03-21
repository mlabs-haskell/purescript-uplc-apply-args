{ name = "uplc-apply-args"
, dependencies =
  [ "aff"
  , "bytearrays"
  , "cardano-data-lite"
  , "cardano-types"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "foreign-object"
  , "js-bigints"
  , "lists"
  , "maybe"
  , "mote"
  , "mote-testplan"
  , "partial"
  , "prelude"
  , "profunctor"
  , "spec"
  , "transformers"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
