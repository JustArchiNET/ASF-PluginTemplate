# ASF-PluginTemplate

[![GitHub sponsor](https://img.shields.io/badge/GitHub-sponsor-ea4aaa.svg?logo=github-sponsors)](https://github.com/sponsors/JustArchi)
[![Patreon support](https://img.shields.io/badge/Patreon-support-f96854.svg?logo=patreon)](https://www.patreon.com/JustArchi)

[![Crypto donate](https://img.shields.io/badge/Crypto-donate-f7931a.svg?logo=bitcoin)](https://commerce.coinbase.com/checkout/0c23b844-c51b-45f4-9135-8db7c6fcf98e)
[![PayPal.me donate](https://img.shields.io/badge/PayPal.me-donate-00457c.svg?logo=paypal)](https://paypal.me/JustArchi)
[![PayPal donate](https://img.shields.io/badge/PayPal-donate-00457c.svg?logo=paypal)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HD2P2P3WGS5Y4)
[![Revolut donate](https://img.shields.io/badge/Revolut-donate-0075eb.svg?logo=revolut)](https://pay.revolut.com/profile/ukaszyxm)
[![Steam donate](https://img.shields.io/badge/Steam-donate-000000.svg?logo=steam)](https://steamcommunity.com/tradeoffer/new/?partner=46697991&token=0ix2Ruv_)

---

## Description

ASF-PluginTemplate is a template repository that you can use for creating custom **[plugins](https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Plugins)** for **[ArchiSteamFarm](https://github.com/JustArchiNET/ArchiSteamFarm)**. Simply click the "Use this template" button in the top-right of the **[main repository page](https://github.com/JustArchiNET/ASF-PluginTemplate)** in order to get started.

---

### Optional steps

Here we list steps that are **not mandatory**, but worthy to consider after using this repo as a template. While we'd recommend to cover all of those, it's totally alright if you don't. We ordered those according to our recommended priority.

- Choose license based on which you want to share your work. If you'd like to use the same one we do, so Apache 2.0, then you don't need to do anything as the plugin template comes with it. If you'd like to use different one, remove **[`LICENSE-2.0.txt`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/LICENSE-2.0.txt)** file and provide your own.
- Change this **[`README.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/README.md)** in any way you want to. You can check **[ASF's README](https://github.com/JustArchiNET/ArchiSteamFarm/blob/main/README.md)** for some inspiration. We recommend at least a short description of what your plugin can do.
- Fill **[`SUPPORT.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/SUPPORT.md)** file, so your users can learn where they can ask for help in regards to your plugin.
- Fill **[`SECURITY.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/SECURITY.md)** file, so your users can learn where they should report critical security issues in regards to your plugin.
- If you want to use **[Renovate bot](https://github.com/renovatebot/renovate)** like we do, we recommend to modify the `:assignee()` block in our **[`renovate.json5`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/renovate.json5)** config file and putting your own GitHub username there. This will allow Renovate bot to assign failing PR to you so you can take a look at it. Everything else can stay as it is, unless you want to modify it of course.
- Provide your own **[`CODE_OF_CONDUCT.md`](https://github.com/JustArchiNET/ASF-PluginTemplate/blob/main/.github/CODE_OF_CONDUCT.md)** if you'd like to. If you're fine with ours, you can simply replace `TODO@example.com` e-mail with your own.
