# Homebrew Tap - Claude Instructions

This is ahacop's personal Homebrew tap for distributing CLI tools and services.

## Repository Structure

```
homebrew-tap/
├── Formula/           # Homebrew formulae (*.rb files)
├── .github/workflows/ # CI for testing and bottle publishing
├── CLAUDE.md          # This file
└── README.md          # User-facing documentation
```

## Creating a New Formula

### Standard Formula (CLI tool)

```ruby
class ToolName < Formula
  desc "Short description"
  homepage "https://github.com/ahacop/tool-name"
  url "https://github.com/ahacop/tool-name/archive/refs/tags/v1.0.0.tar.gz"
  # sha256: curl -sL <url> | shasum -a 256
  license "MIT"

  def install
    bin.install "tool-name"
  end

  test do
    system bin/"tool-name", "--version"
  end
end
```

### Formula with Service Support

For projects that should run as a background service:

```ruby
class ServiceName < Formula
  desc "Short description"
  homepage "https://github.com/ahacop/service-name"
  url "https://github.com/ahacop/service-name/archive/refs/tags/v1.0.0.tar.gz"
  # sha256: curl -sL <url> | shasum -a 256
  license "MIT"

  def install
    bin.install "service-name"
  end

  # Service configuration
  service do
    run [opt_bin/"service-name", "start"]
    keep_alive true
    working_dir var
    log_path var/"log/service-name.log"
    error_log_path var/"log/service-name.log"
  end

  test do
    system bin/"service-name", "--version"
  end
end
```

Users can then manage the service with:
- `brew services start ahacop/tap/service-name`
- `brew services stop ahacop/tap/service-name`
- `brew services restart ahacop/tap/service-name`

## Formula Naming Conventions

- Class name: PascalCase (e.g., `MyTool`)
- File name: kebab-case matching the formula name (e.g., `Formula/my-tool.rb`)
- The class name should be the PascalCase version of the file name

## Getting SHA256 for a Release

```bash
curl -sL https://github.com/ahacop/<project>/archive/refs/tags/v<version>.tar.gz | shasum -a 256
```

## Testing Formulae Locally

```bash
brew install --build-from-source Formula/tool-name.rb
brew test Formula/tool-name.rb
brew audit --strict Formula/tool-name.rb
```

## CI Workflows

- `tests.yml`: Runs `brew test-bot` on PRs and pushes
- `publish.yml`: Handles bottle publishing when PRs are labeled with `pr-pull`
