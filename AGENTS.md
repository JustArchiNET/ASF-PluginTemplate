# AGENTS.md

## Scope

Applies to the repository root and `MyAwesomePlugin/`. `ArchiSteamFarm/` is an independent git submodule: read `ArchiSteamFarm/AGENTS.md` and follow it for submodule work. Do not edit ASF/UI/wiki internals unless explicitly requested.

This file may remain in repositories created from this template. Determine whether the task concerns the template itself or the user's derived plugin: check `git remote -v`, repository identity, `<PluginName>`, and whether names still match `MyAwesomePlugin`/`JustArchiNET/ASF-PluginTemplate`.
- For template work, preserve the template's placeholder names and broadly reusable structure.
- For a derived plugin, treat `MyAwesomePlugin` only as existing project context; edit the plugin according to its renamed identity and do not revert or rename it back to template placeholders.
- In the derived repository, ASF submodule and release automation remain relevant unless the user project has intentionally replaced them.

## Working Method

- Check `git status`, `git submodule status`, and submodule status before editing.
- Preserve unrelated work and existing submodule commits; do not update/reset gitlinks unless explicitly requested.
- Keep changes small and compatible. Ask before plugin API, IPC/JSON, release, signing, or ASF-reference decisions that may break behavior.
- Do not commit, push, reset, clean, or modify changelists unless explicitly requested.
- At the end of every task, review whether this file needs a concise durable update: repository conventions, important decisions, and explicit user constraints. Do not store task status, temporary paths, secrets, credentials, personal data, or speculation.

## Sources of Truth

- Formatting/analyzers: root `.editorconfig`; ASF conventions and build properties: `ArchiSteamFarm/.editorconfig`, `ArchiSteamFarm/Directory.Build.props`, `ArchiSteamFarm/Directory.Packages.props`, and `ArchiSteamFarm/ArchiSteamFarm.slnx.DotSettings`.
- Solution/build: `MyAwesomePlugin.slnx`, root `Directory.Build.props`, and root `Directory.Packages.props`.
- Plugin interfaces and runtime behavior: `ArchiSteamFarm/ArchiSteamFarm/Plugins/Interfaces/`.
- Automation: `.github/workflows/*.yml` and `.github/renovate.json5`.

## Plugin Project

- Use the existing plugin and MEF conventions. Types derived from `IPlugin` are discovered automatically; preserve `IPlugin.Name`, `IPlugin.Version`, and `IPlugin.OnLoaded(...)`.
- Implement the required interfaces only. Keep runtime-created types internal/`UsedImplicitly` unless public API is intentional.
- Preserve public APIs, callback signatures, cancellation, JSON/IPC shapes, commands, and compatibility unless a migration is explicitly requested.
- Use cancellation tokens, `ConfigureAwait(false)`, ASF logging/abstractions, and existing serialization/Steam patterns. Do not block with `.Result` or `.Wait()`.
- Keep `ProjectReference ExcludeAssets="all" Private="false"` for ASF. Keep the post-build plugin copy under `ArchiSteamFarm/ArchiSteamFarm/bin/<Configuration>/<TargetFramework>/plugins/<AssemblyName>/`.
- Keep `IGitHubPluginUpdates.RepositoryName` as `owner/repository`, matching the repository that publishes the expected plugin zip.
- Use file-scoped namespaces and follow `.editorconfig`. Add Apache-style headers only where established.

## Packages and ASF Reference

- Target framework and most package versions come from the ASF submodule. Add template-only package versions to root `Directory.Packages.props`; do not repeat ASF versions or add `<Version>` attributes to `PackageReference`.
- Update `<PluginName>`, version metadata, repository URL, and description consistently in `Directory.Build.props` and plugin code.
- Before changing the submodule commit or `.gitmodules`, verify the plugin with both Debug and Release builds.
- `.github/workflows/bump-asf-reference.yml` changes only the tracked ASF branch in `.gitmodules`; it does not update or test the submodule commit.

## Build and Validation

Use .NET SDK 11.x:

```sh
dotnet build -c DebugFast -p:ContinuousIntegrationBuild=true -p:UseAppHost=false --nologo
dotnet build -c Debug -p:ContinuousIntegrationBuild=true -p:UseAppHost=false --nologo
dotnet build -c Release -p:ContinuousIntegrationBuild=true -p:UseAppHost=false --nologo
dotnet publish MyAwesomePlugin -c Release -o out/plugin/MyAwesomePlugin -p:ContinuousIntegrationBuild=true -p:TargetLatestRuntimePatch=false -p:UseAppHost=false --nologo
```

- Use `DebugFast` for iteration, `Debug` for analyzers, and `Release` for warnings/signing/trimming-sensitive work.
- Release treats warnings as errors; fix rather than broadly suppressing them.
- No dedicated test project exists currently; add and document focused tests when plugin behavior warrants them.
- Run the smallest relevant build/test; use workflow cross-platform matrix coverage for workflow or cross-platform changes.

## Renaming and Publishing

- `tools/rename.sh` is interactive and destructive: run it only intentionally, on a clean worktree, and review all resulting changes.
- Rename consistently: directory, project/assembly name, solution entry, `<PluginName>`, `Name`, `RepositoryName`, dotsettings, and published zip name.
- Review README and human-facing metadata/support/license/funding files after renaming.
- Publishing creates `out/<PluginName>.zip`. Tagged releases require assets matching `IGitHubPluginUpdates`; CI builds Linux/macOS/Windows, while the Ubuntu artifact supplies the tagged GitHub release.
- Never add private `.snk`, credentials, tokens, bot config, or real ASF state to source control.

## CI and Submodule State

- CI: Debug/Release on Linux/macOS/Windows for push, PR, and manual dispatch.
- Publishing: Release archives on all platforms, plus SHA-512 and optional GPG output for tagged refs.
- GitHub Actions are SHA-pinned; preserve pins and review action updates carefully.
- Clone with `git clone --recursive`; do not hand-edit submodule UI/wiki/generated output.
- Do not run live Steam/bot actions or read real local config for ordinary validation.
- Do not hand-edit or commit `bin/`, `obj/`, `out/`, ASF config/logs/www/debug state, or publish artifacts.
- Before completion, inspect parent and submodule status and leave only intended changes.
