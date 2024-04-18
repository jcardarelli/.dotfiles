# fish-lsp complete --fish > ~/.config/fish/completions/fish-lsp.fish
complete -c fish-lsp -f


complete -c fish-lsp -n "__fish_use_subcommand" -a "
start\t'subcmd to start the lsp using stdin/stdout'
bare\t'run barebones startup config'
info\t'show the build info of fish-lsp'
url\t'show a helpful url related to the fish-lsp'
complete\t'generate completions file for ~/.config/fish/completions'"

set __fish_lsp_subcommands bare min start

complete -c fish-lsp -n '__fish_seen_subcommand_from $__fish_lsp_subcommands' -a "
--dump\t'dump output and stop server'
--enable\t'enable feature'
--disable\t'disable feature'"

complete -c fish-lsp -n "__fish_seen_subcommand_from url" -a "
--repo\t'show git url'
--git\t'show git url'
--npm\t'show npm url'
--homepage\t'show homepage url'
--contributions\t'show git contributions url'
--wiki\t'show git wiki url'
--issues\t'show git issues url'
--report\t'show git issues url'
--discussions\t'show git discussions url'
--clients-repo\t'show git clients-repo url'
--sources\t'show useful list of sources'"

complete -c fish-lsp -n "__fish_seen_subcommand_from complete" -a "
--names\t'show the feature names of the completions'
--toggles\t'show the feature names of the completions'
--fish\t'show fish script'
--features\t'show features'"

set __info_subcommands 'info'
complete -c fish-lsp -n "__fish_seen_subcommand_from $__info_subcommands" -a "
--bin\t'show bin path'
--repo\t'show repo path'
--time\t'show build-time'
--env\t'show the env variables used'
--lsp-version\t'show the lsp version'
--capabilities\t'show the lsp capabilities implemented'
--man-file\t'show man file path'
--logs-file\t'show logs.txt file path'
--more\t'show more info'"

function _fish_lsp_get_features
    printf %b\n asciiArt formatting logging snippets completion hover rename definition references diagnostics signatureHelp codeAction index
end
# COMPLETION: fish-lsp subcmd <option> [VALUE] (`fish-lsp start --enable ...`)
complete -c fish-lsp -n '__fish_seen_subcommand_from $__fish_lsp_subcommands' -l enable -xa '(_fish_lsp_get_features)'
complete -c fish-lsp -n '__fish_seen_subcommand_from $__fish_lsp_subcommands' -l disable -xa '(_fish_lsp_get_features)'

# cp ~/.config/fish/completions/fish-lsp.fish ~/.config/fish/completions/fish-lsp.fish.bak
# fish-lsp complete --fish > ~/.config/fish/completions/fish-lsp.fish
