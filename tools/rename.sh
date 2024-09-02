#!/usr/bin/env sh
set -eu

# Default settings
export PRINT_BANNER=1
export VERBOSITY=3

GET_DATE() {
	case "$(uname -s)" in
		"Darwin") date -u ;;
		*) date -u --rfc-3339=seconds ;;
	esac
}

DEBUG() {
	if [ "$VERBOSITY" -gt 3 ]; then
		COLOR_DARK_GRAY "$(GET_DATE) [$(basename "$0")] DEBUG: $*"
	fi
}

INFO() {
	if [ "$VERBOSITY" -gt 2 ]; then
		COLOR_WHITE "$(GET_DATE) [$(basename "$0")] INFO: $*"
	fi
}

SUCCESS() {
	if [ "$VERBOSITY" -gt 2 ]; then
		COLOR_GREEN "$(GET_DATE) [$(basename "$0")] SUCCESS: $*"
	fi
}

WARN() {
	if [ "$VERBOSITY" -gt 1 ]; then
		COLOR_YELLOW "$(GET_DATE) [$(basename "$0")] WARN: $*"
	fi
}

ERROR() {
	if [ "$VERBOSITY" -gt 0 ]; then
		COLOR_RED "$(GET_DATE) [$(basename "$0")] ERROR: $*"
	fi
}

COLOR_DARK_GRAY() {
	printf "\033[1;30m%s\033[0m\n" "$*"
}

COLOR_RED() {
	printf "\033[1;31m%s\033[0m\n" "$*"
}

COLOR_GREEN() {
	printf "\033[1;32m%s\033[0m\n" "$*"
}

COLOR_YELLOW() {
	printf "\033[1;33m%s\033[0m\n" "$*"
}

COLOR_WHITE() {
	printf "\033[1;37m%s\033[0m\n" "$*"
}

GET_INPUT_BOOL() {
	if [ "$#" -ne 2 ]; then
		ERROR "Wrong GET_INPUT_BOOL() args!"
		return 1
	fi

	case "$2" in
		"y"|"Y") helper_text="Y/n" ;;
		"n"|"N") helper_text="y/N" ;;
		*) ERROR "Wrong default for GET_INPUT_BOOL()!"; return 1
	esac

	while :; do
		printf "%s " "${1} [${helper_text}]:" 1>&2
		read -r user_input

		if [ -z "$user_input" ]; then
			user_input="$2"
		fi

		case "$user_input" in
			"y"|"Y") return 0 ;;
			"n"|"N") return 1 ;;
			*) continue
		esac
	done
}

GET_INPUT_STRING() {
	if [ "$#" -ne 2 ]; then
		ERROR "Wrong GET_INPUT_STRING() args!"
		return 1
	fi

	printf "%s " "${1} [${2}]:" 1>&2
	read -r user_input

	if [ -z "$user_input" ]; then
		echo "$2"
		return
	fi

	echo "$user_input"
}

PRINT_HEADER() {
	if [ "$PRINT_BANNER" -eq 0 ]; then
		return
	fi

	INFO "     _     ____   _____"
	INFO "    / \   / ___| |  ___|"
	INFO "   / _ \  \___ \ | |_"
	INFO "  / ___ \  ___) ||  _|"
	INFO " /_/   \_\|____/ |_|"
	INFO "------------------------"
}

SED_REPLACE_FILE() {
	if [ "$#" -ne 3 ]; then
		ERROR "Wrong SED_REPLACE_FILE() args!"
		return 1
	fi

	sed "s:${1}:${2}:g" "$3" > "${3}.new"
	mv "${3}.new" "$3"
}

# Main logic
OS_TYPE="$(uname -s)"

case "$OS_TYPE" in
	"Darwin") SCRIPT_PATH="$(readlink "$0")" ;;
	*) SCRIPT_PATH="$(readlink -f "$0")" ;;
esac

SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# Main script
cd "$SCRIPT_DIR"

trap "trap - TERM && kill -- -$$" INT TERM

PRINT_HEADER

if [ ! -f "../Directory.Build.props" ]; then
	ERROR "Couldn't find Directory.Build.props, have you changed core project structure?"

	if ! GET_INPUT_BOOL "This script will probably not work due to above, are you sure you want to continue?" "N"; then
		INFO "OK, as you wish!"
		exit 0
	fi
fi

default_plugin_name="MyAwesomePlugin"
default_github_repo="JustArchiNET/ASF-PluginTemplate"
default_github_username="JustArchi"

if command -v git >/dev/null; then
	git_potential_repo="$(git config --get remote.origin.url | sed 's/https:\/\/github\.com\///g' | sed 's/\.git//g')"

	if [ -n "$git_potential_repo" ]; then
		default_github_repo="$git_potential_repo"
	fi

	git_potential_username="$(echo "$git_potential_repo" | cut -d '/' -f 1)"

	if [ -n "$git_potential_username" ]; then
		default_github_username="$git_potential_username"
	fi

	git_potential_plugin_name="$(echo "$git_potential_repo" | cut -d '/' -f 2)"

	if [ -n "$git_potential_plugin_name" ]; then
		default_plugin_name="$git_potential_plugin_name"
	fi
fi

from_plugin_name="$(grep -F "<PluginName>" "../Directory.Build.props" | cut -d '>' -f 2 | cut -d '<' -f 1)"

if [ -n "$from_plugin_name" ]; then
	INFO "Detected current plugin name: ${from_plugin_name}"
else
	WARN "Could not detect plugin name from Directory.Build.props, have you changed core project properties?"

	if ! GET_INPUT_BOOL "This script will probably not work due to above, are you sure you want to continue?" "N"; then
		INFO "OK, as you wish!"
		exit 0
	fi

	from_plugin_name="$(GET_INPUT_STRING "OK, from what plugin name you want to rename?" "$default_plugin_name")"
fi

from_github_repo=""

if [ -f "../${from_plugin_name}/${from_plugin_name}.cs" ]; then
	from_github_repo="$(grep -F "public string RepositoryName => " "../${from_plugin_name}/${from_plugin_name}.cs" | cut -d '"' -f 2)"

	if [ -n "$from_github_repo" ]; then
		INFO "Detected current GitHub repo: ${from_github_repo}"
	else
		WARN "Could not detect GitHub repo from ${from_plugin_name}/${from_plugin_name}.cs, have you removed RepositoryName property?"
	fi
else
	WARN "Couldn't find ${from_plugin_name}/${from_plugin_name}.cs, have you changed core project structure?"
fi

if [ -z "$from_github_repo" ]; then
	if ! GET_INPUT_BOOL "This warning is not fatal, are you sure you want to continue?" "Y"; then
		INFO "OK, as you wish!"
		exit 0
	fi

	from_github_repo="$(GET_INPUT_STRING "OK, from what GitHub repository you want to rename?" "$default_github_repo")"
fi

from_github_username=""

if [ -f "../.github/renovate.json5" ]; then
	from_github_username="$(grep -F ":assignee(" "../.github/renovate.json5" | cut -d '(' -f 2 | cut -d ')' -f 1)"

	if [ -n "$from_github_username" ]; then
		INFO "Detected current GitHub username: ${from_github_username}"
	else
		WARN "Could not detect GitHub username from .github/renovate.json5, have you removed :assignee property?"
	fi
else
	WARN "Couldn't find .github/renovate.json5, have you changed core project structure?"
fi

if [ -z "$from_github_username" ]; then
	if ! GET_INPUT_BOOL "This warning is not fatal, are you sure you want to continue?" "Y"; then
		INFO "OK, as you wish!"
		exit 0
	fi

	from_github_username="$(GET_INPUT_STRING "OK, from what GitHub username you want to rename?" "$default_github_username")"
fi

to_plugin_name="$(GET_INPUT_STRING "Please type target plugin name that you want to use, we recommend PascalCase" "$default_plugin_name")"
to_github_repo="$(GET_INPUT_STRING "Please type your GitHub repo" "$default_github_repo")"
to_github_username="$(GET_INPUT_STRING "Please type your GitHub username" "$default_github_username")"

if ! GET_INPUT_BOOL "Confirm rename: ${from_plugin_name} -> ${to_plugin_name} (plugin name), ${from_github_repo} -> ${to_github_repo} (git repo) and ${from_github_username} -> ${to_github_username} (git username):" "Y"; then
	INFO "OK, as you wish!"
	exit 0
fi

INFO "Please wait..."

if [ "$from_github_username" != "$to_github_username" ]; then
	if [ -f "../.github/renovate.json5" ]; then
		INFO "Processing .github/renovate.json5..."
		SED_REPLACE_FILE "\\:assignee(${from_github_username})" "\\:assignee(${to_github_username})" "../.github/renovate.json5"
	else
		WARN "Couldn't find .github/renovate.json5, moving on..."
	fi
fi

if [ "$from_github_repo" != "$to_github_repo" ]; then
	if [ -f "../${from_plugin_name}/${from_plugin_name}.cs" ]; then
		INFO "Processing ${from_plugin_name}/${from_plugin_name}.cs..."
		SED_REPLACE_FILE "${from_github_repo}" "${to_github_repo}" "../${from_plugin_name}/${from_plugin_name}.cs"
	else
		WARN "Couldn't find ${from_plugin_name}/${from_plugin_name}.cs, moving on..."
	fi
fi

if [ "$from_plugin_name" != "$to_plugin_name" ]; then
	if [ -f "../${from_plugin_name}/${from_plugin_name}.csproj" ]; then
		INFO "Processing ${from_plugin_name}/${from_plugin_name}.csproj..."
		mv "../${from_plugin_name}/${from_plugin_name}.csproj" "../${from_plugin_name}/${to_plugin_name}.csproj"
	else
		WARN "Couldn't find ${from_plugin_name}/${from_plugin_name}.csproj, moving on..."
	fi

	if [ -f "../${from_plugin_name}/${from_plugin_name}.cs" ]; then
		INFO "Processing ${from_plugin_name}/${from_plugin_name}.cs..."
		SED_REPLACE_FILE "$from_plugin_name" "$to_plugin_name" "../${from_plugin_name}/${from_plugin_name}.cs"
		mv "../${from_plugin_name}/${from_plugin_name}.cs" "../${from_plugin_name}/${to_plugin_name}.cs"
	else
		WARN "Couldn't find ${from_plugin_name}/${from_plugin_name}.cs, moving on..."
	fi

	if [ -d "../${from_plugin_name}" ]; then
		INFO "Processing ${from_plugin_name} (directory)..."
		mv "../${from_plugin_name}" "../${to_plugin_name}"
	else
		WARN "Couldn't find ${from_plugin_name} (directory), moving on..."
	fi

	if [ -f "../${from_plugin_name}.sln" ]; then
		INFO "Processing ${from_plugin_name}.sln..."
		SED_REPLACE_FILE "$from_plugin_name" "$to_plugin_name" "../${from_plugin_name}.sln"
		mv "../${from_plugin_name}.sln" "../${to_plugin_name}.sln"
	else
		WARN "Couldn't find ${from_plugin_name}.sln, moving on..."
	fi

	if [ -f "../${from_plugin_name}.sln.DotSettings" ]; then
		INFO "Processing ${from_plugin_name}.sln.DotSettings..."
		mv "../${from_plugin_name}.sln.DotSettings" "../${to_plugin_name}.sln.DotSettings"
	else
		WARN "Couldn't find ${from_plugin_name}.sln.DotSettings, moving on..."
	fi

	if [ -f "../Directory.Build.props" ]; then
		INFO "Processing Directory.Build.props..."
		SED_REPLACE_FILE "$from_plugin_name" "$to_plugin_name" "../Directory.Build.props"
	else
		WARN "Couldn't find Directory.Build.props, moving on..."
	fi
fi

SUCCESS "All done! :3"
