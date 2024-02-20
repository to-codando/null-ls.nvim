local h = require("null-ls.helpers")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
    name = "biome",
    meta = {
        url = "https://biomejs.dev",
        description = "One toolchain for your web project. Format, lint, and more in a fraction of a second.",
        notes = {
            "Biome is a performant linter for JavaScript, TypeScript, and JSX that features more than 190 rules from ESLint, TypeScript ESLint, and other sources.",
        },
    },
    method = FORMATTING,
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
    generator_opts = {
        command = "biome",
        args = {
            "format",
            "--write",
            "$FILENAME",
        },
        dynamic_command = cmd_resolver.from_node_modules(),
        cwd = h.cache.by_bufnr(function(params)
            return u.root_pattern(
                -- https://biomejs.dev/guides/getting-started/
                "biome.json"
            )(params.bufname)
        end),
        to_stdin = false,
        to_temp_file = true,
    },
    factory = h.formatter_factory,
})
