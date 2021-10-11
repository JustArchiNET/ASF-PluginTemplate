using System;
using ArchiSteamFarm.Core;
using ArchiSteamFarm.Plugins.Interfaces;
using JetBrains.Annotations;

namespace MyAwesomePlugin {
#pragma warning disable CA1812 // ASF uses this class during runtime
	[UsedImplicitly]
	internal sealed class MyAwesomePlugin : IPlugin {
		public string Name => nameof(MyAwesomePlugin);
		public Version Version => typeof(MyAwesomePlugin).Assembly.GetName().Version ?? throw new InvalidOperationException(nameof(Version));

		public void OnLoaded() => ASF.ArchiLogger.LogGenericInfo($"Hello ${Name}!");
	}
#pragma warning restore CA1812 // ASF uses this class during runtime
}
