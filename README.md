# ASF-PluginTemplate

[![GitHub sponsor](https://img.shields.io/badge/GitHub-sponsor-ea4aaa.svg?logo=github-sponsors)](https://github.com/sponsors/JustArchi)
[![PayPal.me donate](https://img.shields.io/badge/PayPal.me-donate-00457c.svg?logo=paypal)](https://paypal.me/JustArchi)
[![PayPal donate](https://img.shields.io/badge/PayPal-donate-00457c.svg?logo=paypal)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HD2P2P3WGS5Y4)
[![Revolut donate](https://img.shields.io/badge/Revolut-donate-0075eb.svg?logo=revolut)](https://pay.revolut.com/justarchi)
[![Steam donate](https://img.shields.io/badge/Steam-donate-000000.svg?logo=steam)](https://steamcommunity.com/tradeoffer/new/?partner=46697991&token=0ix2Ruv_)

[![BTC donate](https://img.shields.io/badge/BTC-donate-f7931a.svg?logo=bitcoin)](https://www.blockchain.com/explorer/addresses/btc/3HwcgZbtoF5vSxJkNUvThVSJipKi7r5EqU)
[![ETH donate](https://img.shields.io/badge/ETH-donate-3c3c3d.svg?logo=ethereum)](https://www.blockchain.com/explorer/addresses/eth/0xA1F7Ba62C5a3A8b93Fe6656936192432F328a366)
[![LTC donate](https://img.shields.io/badge/LTC-donate-a6a9aa.svg?logo=litecoin)](https://live.blockcypher.com/ltc/address/MJCeBEZUsNgDhRhqbLFfPiDcf7CSrdvmZ3)
[![USDC donate](https://img.shields.io/badge/USDC-donate-2775ca.svg?logo=cashapp)](https://etherscan.io/address/0xCf42D9F53F974CBd7c304eF0243CAe8e029885A8)

---

[![Repobeats analytics image](https://repobeats.axiom.co/api/embed/4aa3ac833c7593826ac47ccfdc49c46ae27abb3d.svg "Repobeats analytics image")](https://github.com/JustArchiNET/ASF-PluginTemplate/pulse)

---

## Description

ASF-PluginTemplate is a template repository that you can use for creating custom **[plugins](https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Plugins)** for **[ArchiSteamFarm](https://github.com/JustArchiNET/ArchiSteamFarm)**. This template has everything needed to kickstart the structure of your custom ASF plugin. Most importantly, from viewpoint of a project not related to ASF whatsoever while making use of its best practices.

---

## How to use this template

Simply click the "Use this template" button in the top-right of the **[main repository page](https://github.com/JustArchiNET/ASF-PluginTemplate)** in order to get started.

For cloning your git repository, use `git clone --recursive` option in order to pull ASF reference along with your plugin, which you'll require during compilation. See **[git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)** for more info.

After using the template and cloning git repo, assuming you have everything required as specified in **[compilation](https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Compilation)** page on our wiki, try to build your project with `dotnet build MyAwesomePlugin`, it should succeed without any issues, which means you're all set.

In theory, you don't need to do anything special further, just edit **[`MyAwesomePlugin/MyAwesomePlugin.cs`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin/MyAwesomePlugin.cs)** file and get going with your plugin logic. However, there are some things we recommend on doing in addition to above steps, and some we highlight as a possibility in case you'd be interested in them. It's now up to you what you want to do next.

---

## What's included

- Sample `MyAwesomePlugin` ASF plugin project with `ArchiSteamFarm` reference in git subtree.
- Project structure supporting `IGitHubPluginUpdates` ASF interface, allowing for convenient plugin updates.
- Seamless hook into the ASF build process, which simplifies the project structure, as you effectively inherit the default settings official ASF projects are built with. Of course, free to override.
- GitHub actions CI script, which verifies whether your project is possible to build. You can easily enhance it with unit tests when/if you'll have any.
- GitHub actions publish script, heavily inspired by ASF build process. Publish script allows you to `git tag` and `git push` selected tag, while CI will build, pack, create release on GitHub and upload the resulting artifacts, automatically.
- GitHub actions ASF reference update script, which by default runs every day and ensures that your git submodule is tracking latest ASF (stable) release. Please note that this is a reference update only, the actual commit your plugin is built against is developer's responsibility not covered by this action, as it requires actual testing and verification. Because of that, commit created through this workflow can't possibly create any kind of build regression, it's a helper for you to more easily track latest ASF stable release.
- Configuration file for **[Renovate](https://github.com/renovatebot/renovate)** bot, which you can optionally decide to use. Using renovate, apart from bumping your library dependencies, can also cover bumping ASF commit that your plugin is built against, which together with above workflow will ensure that you're effectively tracking latest ASF (stable) release.
- Code style that matches the one we use at ASF, feel free to modify it to suit you.
- Other misc files for integration with `git` and GitHub.

---

## Recommended steps

Here we list steps that are **not mandatory**, but worthy to consider after using this repo as a template. While we'd recommend to cover all of those, it's totally alright if you don't. We ordered those according to our recommended priority.

- If you want to use automatic plugin updates, ensure **[`RepositoryName`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin/MyAwesomePlugin.cs#L13)** property matches your target repo, this is covered by default in our **[`rename.sh`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/tools/rename.sh)** script. If you want to opt out of that feature, replace **[`IGitHubPluginUpdates`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin/MyAwesomePlugin.cs#L11)** interface back to its base `IPlugin` one, and remove **[`RepositoryName`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin/MyAwesomePlugin.cs#L13)** property instead.
- Choose license based on which you want to share your work. If you'd like to use the same one we do, so Apache 2.0, then you don't need to do anything as the plugin template comes with it. If you'd like to use different one, remove **[`LICENSE.txt`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/LICENSE.txt)** file and provide your own. If you've decided to use different license, it's probably also a good idea to update `PackageLicenseExpression` in **[`Directory.Build.props`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/Directory.Build.props#L16)**.
- Change this **[`README.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/README.md)** in any way you want to. You can check **[ASF's README](https://github.com/JustArchiNET/ArchiSteamFarm/blob/main/README.md)** for some inspiration. We recommend at least a short description of what your plugin can do. Updating `<Description>` in **[`Directory.Build.props`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/Directory.Build.props#L14)** also sounds like a good idea.
- Fill **[`SUPPORT.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/SUPPORT.md)** file, so your users can learn where they can ask for help in regards to your plugin.
- Fill **[`SECURITY.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/SECURITY.md)** file, so your users can learn where they should report critical security issues in regards to your plugin.
- If you want to use **[Renovate bot](https://github.com/renovatebot/renovate)** like we do, we recommend to modify the `:assignee()` block in our **[`renovate.json5`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/renovate.json5#L5)** config file and putting your own GitHub username there. This will allow Renovate bot to assign failing PR to you so you can take a look at it. Everything else can stay as it is, unless you want to modify it of course.
- Provide your own **[`CODE_OF_CONDUCT.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/CODE_OF_CONDUCT.md#enforcement)** if you'd like to. If you're fine with ours, you can simply replace `TODO@example.com` e-mail with your own.
- Provide your own **[`FUNDING.yml`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/FUNDING.yml)** if you'd like to. By default the template comes with the funding available for the main ASF project, which you're free to keep, remove, or replace with your own.

---

## Worth mentioning

Here we list things that do not require your immediate attention, but we consider worthy to know.

### Compilation

Simply execute `dotnet build MyAwesomePlugin` and find your binaries in `MyAwesomePlugin/bin` folder, which you can drag to ASF's `plugins` folder. Keep in mind however that your plugin build created this way is based on existence of your .NET SDK and might not work on other machines or other SDK versions - for creating actual package with your plugin use `dotnet publish MyAwesomePlugin -c Release -o out` command instead, which will create a more general, packaged version in `out` directory. Likewise, use `-c Debug` if for some reason you'd like more general `Debug` build instead.

### Library references

Our plugin template uses centrally-managed packages. Simply add a `PackageVersion` reference below our `Import` clause in **[`Directory.Packages.props`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/Directory.Packages.props#L2)**. Afterwards add a `PackageReference` to your **[`MyAwesomePlugin.csproj`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin/MyAwesomePlugin.csproj#L6-L10)** as usual, but without specifying a version (which we've just specified in `Directory.Packages.props` instead).

Using centrally-managed NuGet packages is crucial in regards to integration with library versions used in the ASF submodule, especially the `System.Composition.AttributedModel` which your plugin should always have in the ASF matching version. This also means that you don't have to (and actually shouldn't) specify versions for all of the libraries that ASF defines on its own in **[`Directory.Packages.props`](https://github.com/JustArchiNET/ArchiSteamFarm/blob/main/Directory.Packages.props)** (that you conveniently inherit from).

### Renaming `MyAwesomePlugin`

You might be interested in renaming `MyAwesomePlugin` project into the one that suits your plugin. For doing that, we recommend using our intuitive **[`tools/rename.sh`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/tools/rename.sh)** script, which you can call using your favourite POSIX sh compliant shell. It's also compatible with WSL.

If for any reason you'd prefer to rename manually, we've tried to keep the minimum amount of references, and we're listing here all of the places you should keep in mind:
- **[`MyAwesomePlugin.csproj`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin/MyAwesomePlugin.csproj)**, renaming should be enough.
- **[`MyAwesomePlugin.cs`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin/MyAwesomePlugin.cs#L7-L14)**, rename along with `RepositoryName` property, `MyAwesomePlugin` class name and included references to it.
- **[`MyAwesomePlugin`](https://github.com/JustArchiNET/ASF-PluginTemplate/tree/main/MyAwesomePlugin)** directory, which holds above files.
- **[`MyAwesomePlugin.sln`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin.sln#L6)**, along with the update of `MyAwesomePlugin` reference in the `sln` file.
- **[`MyAwesomePlugin.sln.DotSettings`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/MyAwesomePlugin.sln.DotSettings)**, renaming to match the `sln` file above should be enough.
- **[`Directory.Build.props`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/Directory.Build.props#L5)**, in particular `<PluginName>MyAwesomePlugin</PluginName>` line.

Nothing else should be required to the best of our knowledge.

### Need help?

Feel free to ask in one of our **[support channels](https://github.com/JustArchiNET/ArchiSteamFarm/blob/main/.github/SUPPORT.md)**, where we'll be happy to offer you a helpful hand 😎.
