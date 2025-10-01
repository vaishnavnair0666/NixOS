{...}:
{
	programs.nixvim.plugins = {

		lsp = {
			enable = true;
			servers = {
				nixd = {
					enable = true;
					settings = {
						nixd = {
							formatting = { command = null; };
# optional: tweak to improve symbol readability
							nix = {
								exprSymbols = true; # try to extract more names from let/in
							};
						};
					};
				};             
				ts_ls.enable = true; # for JS/TS (needed for Svelte too)
					svelte.enable = true;
				jsonls.enable = true;
			};
		};
	};

}
