local ddu = require("rc.ddu.utils")

ddu.patch_local("file", {
  sources = {
    {
      name = "file_external",
      options = ddu.source_options(),
      params = {
        cmd = vim.split("git ls-files -co --exclude-standard", " "),
      },
    },
  },
})