## WoW: Forever + instawow

How addon management is wired up for World of Warcraft: Forever, why `modules/gaming.nix` carries an overlay for it, and what to do when I want to bump it later.

### The setup

- The game runs as a **non-Steam game under Steam's declared Proton-GE** (`programs.steam.extraCompatPackages` in `modules/gaming.nix`), so its files live in a Proton prefix, not a normal install directory.
- Blizzard uses the standard `_forever_` folder, same pattern as `_retail_`/`_classic_`. The real AddOns path is:
  ```
  ~/.local/share/Steam/steamapps/compatdata/2960081357/pfx/drive_c/Program Files (x86)/World of Warcraft/_forever_/Interface/AddOns
  ```
- `hosts/tristan/home.nix` puts a convenience symlink at `~/wow-forever-addons` pointing there, via `config.lib.file.mkOutOfStoreSymlink`. Out-of-store on purpose - addons are mutable game state, so nix points at the folder instead of copying it into the store.
- `instawow` is in `environment.systemPackages` in `modules/gaming.nix`, alongside the other launchers.

### Why there's an overlay

This is the part I'll forget. nixpkgs `nixos-26.05` ships **instawow 7.0.0.post1**, which predates WoW: Forever entirely. Forever support landed upstream in **7.2.0**, so the stock package can't see the game at all. The overlay in `modules/gaming.nix` bumps it to 7.3.0.

Three non-obvious things that overlay has to do, all of which I had to discover the hard way:

1. **The `click` bump is mandatory, not cosmetic.** instawow 7.2.0+ subscripts `click.types.CompositeParamType`, which isn't generic until click 8.4. 26.05 ships 8.3.1. With 8.3.1 the package *builds fine and passes the dependency check*, then dies on every single invocation with `TypeError: type 'CompositeParamType' is not subscriptable`. There's no instawow version that both knows about Forever and works with click 8.3.1 - 7.2.0 has the identical requirement. The click override is scoped to instawow's python only, so nothing else on the system rebuilds.
2. **The source has to be the PyPI sdist, not the git tag.** 7.3.0 switched its build backend from `hatch-vcs` to `versioningit`, which needs either real VCS metadata or the `PKG-INFO` file that only an sdist carries. A `fetchFromGitHub` tarball has neither and fails outright with `NotSdistError`.
3. **`wcwidth` has to be added.** It's a runtime dependency the nixpkgs derivation is missing. (That derivation also carries a stale `iso8601` and `multidict` that upstream no longer uses - harmless, just dead weight in the closure.)

The `pythonRelaxDeps` list (`aiohttp`, `rapidfuzz`, `yarl`) is the safe category - upstream pins those to whatever was newest at release, but the APIs instawow actually touches are long-stable, and 26.05's versions work. **Don't add `click` to that list.** That's the trap: relaxing it produces a package that builds green and is completely broken at runtime.

### Day to day

Directory doesn't matter - run these from anywhere. instawow keeps config in `~/.config/instawow`, state in `~/.local/state/instawow`, cache in `~/.cache/instawow`, and the addon path is stored absolute in its config.

```sh
instawow search masque              # fuzzy search, can install straight from results
instawow install curse:masque       # also takes URLs, or github:sfx-wow/masque
instawow update                     # no args updates everything
instawow list --format detailed
instawow remove masque
instawow reveal masq                # opens the folder, aliases can be shortened
instawow debug                      # dumps config + detected flavour, good first check
```

### Checking the flavour is detected

`instawow debug` should show this under `active_profile_config.product`:

```json
"product": { "code": "wowf", "flavour": "forever_classic", "subfolder": "_forever_" }
```

`flavour_override` stays `null` - detection comes from the `_forever_` folder name, which is what I want. If I ever see `NoFlavourError`, the addon path is wrong or instawow is too old again.

Note that `addon_dir` in the config shows the **long real path, not the symlink**. That's correct and expected: instawow runs the path through `Path().expanduser().resolve()`, which follows the symlink. Handing it `~/wow-forever-addons` works precisely because of that resolve - the raw symlink path on its own wouldn't detect a flavour, since detection reads the last three path components looking for `<subfolder>/Interface/AddOns`.

### Two gotchas

- **CurseForge needs my own API key.** Most addons live there, and it's the one source that won't work out of the box - without a key, installs fail with `package source is disabled: access token missing`. GitHub, WoWInterface, Tukui and instawow's own catalogue all work with no key. See the API key section below.
- **No GUI.** The nixpkgs derivation sets `extras = [ ]` because the GUI deps (`toga`) aren't packaged. This is CLI-only, and making the GUI work is a much bigger job than the overlay.

### The CurseForge API key

Get it from the CurseForge for Studios console at <https://console.curseforge.com/>. Worth knowing the keys are issued *conditionally* - if I'm not a game developer I have to apply as a 3rd party modding service, and their docs warn that accounts which register without requesting a key get deleted. This is also why instawow can't ship one: their terms require managers to conceal the key, which upstream says makes the API "unworkable for add-on managers except through a proxy service."

Set it interactively and paste the key at the prompt:

```sh
instawow configure global_config.access_tokens.cfcore
```

That writes to `~/.config/instawow/config.json` - **outside this repo**, which is what I want, since this repo is public on GitHub. Never put the key in a `.nix` file here; it would land in the store world-readable and in git history.

Confirm it took (it masks the value, so `**********` means set, `null` means not):

```sh
instawow debug | jq -r '.active_profile_config.global_config.access_tokens.cfcore'
```

There's also an env var, `INSTAWOW_ACCESS_TOKENS_CFCORE`, which overrides the config file without writing anything - handy for a one-off, or for pulling the key from a password manager in a shell function instead of storing it on disk.

If I never get a key, `INSTAWOW_CF_API_URL` points instawow at an alternative/proxy CurseForge API, and it skips the token requirement entirely when that's set.

### Addons with no Forever build yet

Forever is new, so coverage will be thin for a while - whether an addon works depends on authors shipping `-Camelot`/`-Forever` TOC suffixes and the sources tagging them. The escape hatch is the `any_flavour` strategy, which deprioritises exact game-version matching:

```sh
instawow install curse:masque#any_flavour
```

Strategies go in the URI fragment, comma-separated (`#any_release_type,any_flavour`), and are respected by `install` and `update`. `instawow update curse:masque#=` resets an addon's strategies.

There's also `instawow configure flavour_override`, but I should leave that alone - setting it throws away folder-based detection entirely.

### Bumping instawow later

1. Check what's current:
   ```sh
   curl -s https://pypi.org/pypi/instawow/json | jq -r .info.version
   ```
2. Get the sdist hash for that version (swap in the version number):
   ```sh
   nix store prefetch-file --json "$(curl -s https://pypi.org/pypi/instawow/7.3.0/json \
     | jq -r '.urls[] | select(.packagetype=="sdist") | .url')" | jq -r .hash
   ```
3. Update `version` and `hash` in the `instawow` block in `modules/gaming.nix`.
4. Check whether the new release raised any dependency floors past what nixpkgs has:
   ```sh
   curl -sL https://raw.githubusercontent.com/layday/instawow/v7.3.0/pyproject.toml | sed -n '/^dependencies/,/^]/p'
   nix eval --raw .#nixosConfigurations.tristan.pkgs.python3Packages.click.version
   ```
5. Rebuild, then **actually run the binary** - don't trust a green build:
   ```sh
   nrs
   instawow --version
   instawow debug
   ```
   A successful build proves nothing here, see the click story above. `instawow debug` exercises the CLI, config loading and all the addon source modules, so if that exits 0 the thing genuinely works.

### Deleting the overlay later

Once a nixpkgs bump catches up, this whole thing should go away. Check with:

```sh
nix eval --raw .#nixosConfigurations.tristan.pkgs.instawow.version
```

If that reports 7.2.0 or newer **and** `python3Packages.click` is 8.4.1 or newer, delete the entire `nixpkgs.overlays` block from `modules/gaming.nix` and keep `instawow` in `environment.systemPackages`. Rebuild and re-run `instawow debug` to confirm.

### Heads up

`modules/gaming.nix` is imported by **both** `tristan` and `taryn`, so the overlay and instawow land on both machines. Harmless, but if I ever want this tristan-only it needs to move. The `~/wow-forever-addons` symlink is already tristan-only, since it lives in `hosts/tristan/home.nix`.
