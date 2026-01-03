import js from "@eslint/js"
import vue from "eslint-plugin-vue"

export default [
  {
    files: ["**/*.{js,mjs,cjs,vue}"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        console: "readonly",
        process: "readonly",
      },
    },
    rules: {
      "vue/multi-word-component-names": "off",
    },
  },
  js.configs.recommended,
  ...vue.configs["flat/recommended"],
  {
    files: ["**/*.vue"],
    languageOptions: {
      parserOptions: {
        parser: "@babel/parser",
        requireConfigFile: false,
      },
    },
    rules: {
      useHookAtTopLevel: "off",
    },
  },
]
