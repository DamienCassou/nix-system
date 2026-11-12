{ lib, ... }:
let
  # List of applications not having Emacs bindings (defined as
  # everything except applications which have):
  non_emacs_bindings_condition = {
    "bundle_identifiers" = [
      "^org\\.gnu\\.Emacs$"
      "^com\\.jetbrains\\."
    ];
    "type" = "frontmost_application_unless";
  };
  next_word = {
    conditions = [ non_emacs_bindings_condition ];
    "from" = {
      "key_code" = "e"; # this is "f" in Colemak
      "modifiers" = {
        "mandatory" = [ "option" ];
        "optional" = [ "shift" ];
      };
    };
    "to" = [
      {
        "key_code" = "right_arrow";
        "modifiers" = [ "option" ];
      }
    ];
    "type" = "basic";
  };
  previous_word = {
    conditions = [ non_emacs_bindings_condition ];
    "from" = {
      "key_code" = "b"; # this is "b" in Colemak
      "modifiers" = {
        "mandatory" = [ "option" ];
        "optional" = [ "shift" ];
      };
    };
    "to" = [
      {
        "key_code" = "left_arrow";
        "modifiers" = [ "option" ];
      }
    ];
    "type" = "basic";
  };
  delete_next_word = {
    conditions = [ non_emacs_bindings_condition ];
    "from" = {
      "key_code" = "g"; # this is "d" in Colemak
      "modifiers" = {
        "mandatory" = [ "option" ];
        "optional" = [ "shift" ];
      };
    };
    "to" = [
      {
        "key_code" = "delete_or_backspace";
        "modifiers" = [
          "fn"
          "option"
        ];
      }
    ];
    "type" = "basic";
  };
  emacs_keys_rule = {
    description = "Simulate Emacs keybindings in other apps";
    manipulators = [
      next_word
      previous_word
      delete_next_word
    ];
  };
  complex_modifications = {
    rules = [ emacs_keys_rule ];
  };

  # Make function keys (e.g., "f1") trigger the original behavior
  # (e.g., "display help") instead of the media behavior (e.g. "reduce
  # brightness"):
  function_key_mappings =
    lib.map
      (key: {
        "from" = {
          "key_code" = key;
        };
        "to" = [ { "key_code" = key; } ];
      })
      [
        "f1"
        "f2"
        "f3"
        "f4"
        "f5"
        "f6"
        "f7"
        "f8"
      ];

  keyboard_advantage2 = {
    fn_function_keys = function_key_mappings;
    identifiers = {
      "is_keyboard" = true;
      "product_id" = 258;
      "vendor_id" = 10730;
    };
  };
  devices = [ keyboard_advantage2 ];
  profile = {
    inherit complex_modifications devices;
    name = "Default profile";
    selected = true;
    virtual_hid_keyboard = {
      keyboard_type_v2 = "ansi";
    };
  };
in
{
  programs.karabiner-elements = {
    enable = true;
    settings = {
      profiles = [ profile ];
    };
  };
}
