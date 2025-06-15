import pluginJs from "@eslint/js";
import prettierRecommendedConfig from "eslint-plugin-prettier/recommended";
import pluginPromise from "eslint-plugin-promise";
import globals from "globals";

export default [
  pluginJs.configs.recommended,

  pluginPromise.configs["flat/recommended"],

  // prettier should be last
  prettierRecommendedConfig,

  {
    languageOptions: { globals: { ...globals.node } },
  },
];
