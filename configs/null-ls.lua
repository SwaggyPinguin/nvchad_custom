local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "js" } }, -- so prettier works only on these filetypes

  -- PHP
  b.formatting.phpcsfixer.with {
    -- command = "vendor/bin/php-cs-fixer",
    command = "/home/ndahms/.config/composer/vendor/friendsofphp/php-cs-fixer/php-cs-fixer",
    condition = function(utils)
      return utils.root_has_file "vendor/bin/php-cs-fixer"
        or utils.root_has_file ".proofit.php-cs.php"
        or utils.root_has_file ".php_cs"
        or utils.root_has_file ".php_cs.dist"
        or utils.root_has_file ".php-cs-fixer.php"
        or utils.root_has_file ".php-cs-fixer.dist.php"
    end,
  },

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
