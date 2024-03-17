using System;
using System.Threading.Tasks;
using ArchiSteamFarm.Core;
using ArchiSteamFarm.Plugins.Interfaces;
using JetBrains.Annotations;

namespace MyAwesomePlugin;

#pragma warning disable CA1812 // ASF uses this class during runtime
[UsedImplicitly]
internal sealed class MyAwesomePlugin : IGitHubPluginUpdates {
	public string Name => nameof(MyAwesomePlugin);
	public string RepositoryName => "JustArchiNET/ASF-PluginTemplate";
	public Version Version => typeof(MyAwesomePlugin).Assembly.GetName().Version ?? throw new InvalidOperationException(nameof(Version));

	public Task OnLoaded() {
		ASF.ArchiLogger.LogGenericInfo($"Hello {Name}!");

		return Task.CompletedTask;
	}
}
#pragma warning restore CA1812 // ASF uses this class during runtime
