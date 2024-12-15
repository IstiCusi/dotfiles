return {
  "Civitasv/cmake-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake",               -- Standard CMake-Befehl
      cmake_build_dir = "",                  -- Dynamisches Build-Verzeichnis
      cmake_build_type = "",                 -- Dynamischer Build-Typ (Debug, Release)
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- compile_commands.json aktivieren
      cmake_build_options = {},              -- Zusätzliche Build-Optionen (leer)
      cmake_console_size = 10,               -- Höhe der CMake-Konsole
      cmake_show_console = "always",         -- Konsole immer anzeigen
    })
  end,
}
