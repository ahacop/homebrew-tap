# ahacop's Homebrew Tap

Personal Homebrew tap for CLI tools and services.

## Installation

```bash
brew tap ahacop/tap
```

## Installing Formulae

```bash
# After tapping
brew install <formula>

# Or directly without tapping first
brew install ahacop/tap/<formula>
```

## Using in a Brewfile

```ruby
tap "ahacop/tap"
brew "<formula>"
```

## Available Formulae

| Formula | Description |
|---------|-------------|
| `clipboard-txt-watcher` | Watch a text file and sync its contents to the system clipboard |

## Services

Some formulae include service support. Manage them with:

```bash
# Start a service
brew services start ahacop/tap/<formula>

# Stop a service
brew services stop ahacop/tap/<formula>

# Restart a service
brew services restart ahacop/tap/<formula>

# List all services
brew services list
```

## Documentation

- `brew help`
- `man brew`
- [Homebrew Documentation](https://docs.brew.sh)
